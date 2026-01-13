import os
import subprocess
import pickle
import pandas as pd
import numpy as np
from plotnine import (
    ggplot, aes, geom_point, geom_vline, geom_label, geom_hline, geom_line,
    theme_classic, theme_minimal, labs
)
import pyreadr
# For Google Sheets reading, we use pandas read_csv with export URL conversion
import requests
from sklearn.datasets import load_iris

### 0. Installing packages ###
# In R, the libraries and package installations are handled interactively.
# In Python, it is more common to install packages outside the script.
# To mimic the R behavior, we call pip via subprocess.
subprocess.check_call(["pip", "install", "git+https://github.com/joernih/OEKA201Assignment.git"])
subprocess.check_call(["pip", "install", "git+https://github.com/dickoa/gretlReadWrite.git"])
subprocess.check_call(["pip", "install", "googlesheets4"])

# Loading datasets
# In R: df_iris <- iris. Here we use the iris dataset from scikit-learn.
iris_bunch = load_iris(as_frame=True)
df_iris = iris_bunch.frame

# In R: nb_ts <- get(load("../data/nb_ts.rda"))
result = pyreadr.read_r("../data/nb_ts.rda")
nb_ts = list(result.values())[0]  # Extracting the first (and assumed only) object

# In R: fred_ts <- get(load("../data/fred_ts.rda"))
result = pyreadr.read_r("../data/fred_ts.rda")
fred_ts = list(result.values())[0]

### I. Importing data to R ###
## a) Directoy from R 
# In R, data(...) lists datasets. Here we simulate with a placeholder dataframe.
df_res = pd.DataFrame({
    "Package": ["datasets"],
    "Item": [pd.__version__]  # Using pandas version as placeholder information
})
df_res
print(df_res)

df_asg = pd.DataFrame({
    "Package": ["OEKA201Assignment"],
    "Item": ["Details not available in Python"]  # Placeholder as package metadata
})
df_asg
print(df_asg)

## b) From CSV-format
df_wine = pd.read_csv("https://raw.githubusercontent.com/joernih/OEKA201Assignment/refs/heads/main/data-raw/csv/wine.csv")

## c) From Spreadsheets
### ca) Excel
df_excl = pd.read_excel("read.xlsx")
print(df_excl.describe())
### cb) Google
# gs4_deauth() is not applicable in Python; we proceed without authentication.
# The Google Sheet URL is modified to export CSV-format.
google_sheet_csv_url = "https://docs.google.com/spreadsheets/d/12V808zXNxFvWldpsfU3A8vo9ZNVbqFB7LQmTht_Pjbc/export?format=csv"
df_gosp = pd.read_csv(google_sheet_csv_url)
print(df_gosp.describe())

### II. Data transformation in R and Python ###
# The dplyr package
## Application 1
df_app1 = pd.DataFrame({
    "id": [1, 2, 3, 4, 5],
    "name": ["Alice", "Bob", "Charlie", "David", "Eve"],
    "age": [25, 30, 35, 40, 45]
})
app1out = (df_app1
    # Insert comment
    .loc[df_app1['age'] > 30]
    # Insert comment
    [['id', 'name']]
    # Insert comment
    .assign(name=lambda x: "Hello " + x['name'])
    # Insert comment
    .sort_values(by='id', ascending=False)
    # Insert comment
    .rename(columns={'id': 'user_id'})
    # Insert comment
    .iloc[0:3]
)

## Application 2
df_app2out = df_wine.dropna()
df_app2out
print(df_app2out)

## Application 3a
mvar = ["mb3", "cpi", "une", "mba", "int", "gdp"][0]
vd1 = pd.to_datetime("2022-01-01")
vd2 = pd.to_datetime("2020-02-01")
startd_i = '2020-01-01'
startd_n = '2024-01-01'
plv = ['nvalue', 'growth'][0]

### Data transformation
# In R: fred_ts[[2]] accesses the second element in the list (index 1 in Python).
df_fred_ts = fred_ts[1].copy()
app4aout = (df_fred_ts
    # Insert comment
    .loc[(df_fred_ts['id'] == mvar) & (df_fred_ts['country'] == "NOR")]
    # Insert comment
    .assign(date=lambda x: pd.to_datetime(x['date']))
    # Insert comment
    .loc[lambda x: x['date'] > pd.to_datetime(startd_i)]
    # Insert comment
    .loc[lambda x: x['date'] < pd.to_datetime(startd_n)]
    # Insert comment
    .assign(nvalue=lambda x: 100 * x['value'] / x['value'].iloc[0])
    # Insert comment
    .assign(lnalue=lambda x: np.log(x['value']))
    # Insert comment
    .assign(lvalue=lambda x: x['value'].shift(12))
    # Insert comment
    .assign(growth=lambda x: round(x['value'] / x['value'].shift(12) - 1, 6) * 100)
)

# Finding the mean values for all variables in fred_ts
mv1 = app4aout[plv].mean(skipna=True)

### Plot
print(app4aout.describe().round(5))

pp1 = (ggplot(app4aout, aes(x="date", y=plv))
    + geom_point()  # ...
    + geom_vline(xintercept=vd1, linetype="dashed", color="blue")  # ...
    + geom_vline(xintercept=vd2, linetype="dashed", color="blue")  # ...
    + geom_label(aes(x=vd1, y=100, label="Pandemi sluttfase"))  # ...
    + geom_label(aes(x=vd2, y=100, label="Pandemi startfase"))  # ...
    + geom_hline(yintercept=mv1, linetype="dashed", color="red")  # ...
    + geom_line()
    + theme_classic()
)
pp1
print(pp1)

## Application 3b
lnd = ["USA", "JPN", "EUZ", "GBR", "CAN", "NOR", "DEN", "SWE", "SKE"]
lnd = [lnd[i - 1] for i in [6, 1, 2, 3]]  # Adjusted for 0-indexing; results in ["NOR", "USA", "JPN", "EUZ"]
vd1 = pd.to_datetime("2022-01-01")
vd2 = pd.to_datetime("2020-02-01")
startd_i = '2020-01-01'
startd_n = '2024-01-01'
mvar = ["mb3", "cpi", "une", "mba", "int", "gdp"][0]
plv = ['nvalue', 'growth'][0]

df_fred_ts = fred_ts[1].copy()
# Data transformation
def transform_group(df):
    df = df.copy()
    # Insert comment
    df['couid'] = df['country'].astype(str) + df['id'].astype(str)
    # Insert comment
    df['nvalue'] = 100 * df['value'] / df['value'].iloc[0]
    # Insert comment
    df['lnalue'] = np.log(df['value'])
    # Insert comment
    df['lvalue'] = df['value'].shift(12)
    # Insert comment
    df['growth'] = round(df['value'] / df['lvalue'] - 1, 6) * 100
    return df

app4bout = (df_fred_ts
    # Insert comment
    .loc[(df_fred_ts['id'] == mvar) & (df_fred_ts['country'].isin(lnd))]
    # Insert comment
    .assign(date=lambda x: pd.to_datetime(x['date']))
    # Insert comment
    .loc[lambda x: x['date'] > pd.to_datetime(startd_i)]
    # Insert comment
    .loc[lambda x: x['date'] < pd.to_datetime(startd_n)]
    # Insert comment
    .groupby("country", group_keys=False)
    .apply(transform_group)
)
mv2 = app4bout[plv].mean(skipna=True)

### Summary
print(app4bout.describe().round(5))

### Plot
p = (ggplot(app4bout, aes(x="date", y=plv, color="couid"))
    + geom_line(aes(color="couid"))
    + labs(title='Tidsserier')
    + geom_label(aes(x=vd1, y=100, label="Pandemi sluttfase"))
    + geom_label(aes(x=vd2, y=100, label="Pandemi startfase"))
    + theme_minimal()
)
print(p)

### III. Exporting data from R and Python ###
## a) To R data format (hyperfast!)
# In R, save() writes an .rda file. In Python, we use pickle to save the dataframe.
os.makedirs("data", exist_ok=True)
with open("data/abc.rda", "wb") as f:
    pickle.dump(df_app2out, f)

## b) To CSV
data = pd.DataFrame({
    "x": [1, 2, 3],
    "y": ["A", "B", "C"]
})
data.to_csv("output.csv", index=False)
## To spreadsheets
# import writexl library is not needed in Python since we use pandas for Excel writing.

# Create a data frame
data = pd.DataFrame({
    "player": ['A', 'B', 'C', 'D'],
    "runs": [100, 200, 408, np.nan],
    "wickets": [17, 20, np.nan, 5]
})

# c) Import data in dataframe to an excel sheet
## Excel
df_iris.to_excel("write.xlsx", index=False)
## Google sheet
# (No direct equivalent provided; functionality not implemented in this translation)

