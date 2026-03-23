library(readr)
library(dplyr)
library(ggplot2)
wine <- readr::read_csv("https://raw.githubusercontent.com/joernih/OEKA201Assignment/refs/heads/main/data-raw/csv/wine.csv")
iwine <- readr::read_csv("https://raw.githubusercontent.com/joernih/OEKA201Assignment/refs/heads/main/data-raw/csv/wine.csv",show_col_types = FALSE)
iadvt <- readr::read_csv("https://raw.githubusercontent.com/joernih/OEKA201Assignment/refs/heads/main/data-raw/csv/adverticing.csv",show_col_types = FALSE)
itssl <- readr::read_csv("https://raw.githubusercontent.com/joernih/OEKA201Assignment/refs/heads/main/data-raw/csv/tssales.csv",show_col_types = FALSE)
mvardee <- read.csv("https://raw.githubusercontent.com/joernih/WASMP/refs/heads/main/data-raw/csv/mvardf.csv", comment.char="#") 

#### Application 1: Chatgpt generated
df_app0 <- data.frame(
  id = c(1, 2, 3, 4, 5),
  name = c("Alice", "Bob", "Charlie", "David", "Eve"),
  age = c(25, 30, 35, 40, 45)
)
app1out <- df_app0 %>%
  # Insert comment
  filter(age > 30) %>%
  # Insert comment
  select(id, name) %>%
  # Insert comment
  mutate(name = paste("Hello", name)) %>%
  # Insert comment
  arrange(desc(id)) %>%
  # Insert comment
  rename(user_id = id) %>%
  # Insert comment
  slice(1:3)
print(app1out)
#
##### Application 2: Wine (Bjørnar's assignment)
app2out <- wine |>
  # Exercise: Try to insert three new pipes
  # Insert comment
  # Insert comment
  # Insert comment
  na.omit()
summary(app2out,10)
names(app2out)
ggplot2::ggplot(data=app2out,aes(x = temp, y = price)) + geom_line()

#
#
##### Application 3a: {{< var app.nrc >}}
### R
mvar <- c("mb3","cpi","une","mba","int","gdp")[1]
vd1 <- as.Date("2022-01-01")
vd2 <- as.Date("2020-02-01")
startd_i <- '2020-01-01'
startd_n <- '2024-01-01'
plv <- c('nvalue','growth')[1]
#
## Data transformation
app4aout <- mvardee %>%
  # Filter data on mb3 (money supply) and NOR (Norway)
  dplyr::filter(id==mvar,country=="NOR") %>%
  # Change data type for variable date to Date
  dplyr::mutate(date=base::as.Date(date)) %>%
  # Filter out all observations starting earlier than startd_i
  dplyr::filter(date>startd_i) %>%
  # Filter out all observations starting later or equal than startd_n
  dplyr::filter(date<startd_n) %>%
  # Creating variable nvalue to normalize the dataset
  dplyr::mutate(nvalue=100*value/value[1]) %>%
  # Creating variable lnvalue as the natural logarithm
  dplyr::mutate(lnalue=log(value)) %>%
  # Creating lvalue as the lagged variable 12 months back in time
  dplyr::mutate(lvalue=dplyr::lag(value,n=12)) %>%
  # Creating variable for year growth
  dplyr::mutate(growth=round(value/lvalue-1, 6)*100)
  # Finding the mean values for all variables in fred_ts
  #dplyr::mutate(m
mv1 <- mean(app4aout[[plv]], na.rm=TRUE)
#**Table**
summary(app4aout,5)

#**Plot**
pp1 <- ggplot(app4aout,aes(x = date, y = !!as.name(plv))) +
  geom_point() + # ...
  geom_vline(xintercept = as.numeric(vd1), linetype = "dashed", color = "blue") + # ...
  geom_vline(xintercept = as.numeric(vd2), linetype = "dashed", color = "blue") + # ...
  geom_label(y=100,x=as.numeric(vd1),label="Pandemi sluttfase") + # ...
  geom_label(y=100,x=as.numeric(vd2),label="Pandemi startfase") + # ...
  geom_hline(yintercept = mv1, linetype = "dashed", color = "red") + # ...
  geom_line() +
  theme_classic()
pp1

# **Download data**

## Settings
lnd <- c("USA","JPN","EUZ","GBR","CAN","NOR","DEN","SWE","SKE")[c(6,1,2,3)]
vd1 <- as.Date("2022-01-01")
vd2 <- as.Date("2020-02-01")
startd_i <- '2020-01-01'
startd_n <- '2024-01-01'
mvar <- c("mb3","cpi","une","mba","int","gdp")[1]
plv <- c('nvalue','growth')[1]

app4bout <- mvardee |>
 # Filter data on mb3 (money supply)
 dplyr::filter(id==mvar,country%in%lnd) %>%
  # Change data type for variable date to Date
 dplyr::mutate(date=base::as.Date(date)) %>%
 # Filter out all observations starting earlier or equal than startd_i
 dplyr::filter(date>startd_i) %>%
 # Filter out all observations starting later or equal than startd_n
 dplyr::filter(date<startd_n) %>%
 # Group for each country included in lnd
 dplyr::group_by(country) %>%
 # Create id-variable for each country
 dplyr::mutate(couid=paste0(country,id)) %>%
 # Creating variable lnvalue as the natural logarithm for each country
 dplyr::mutate(nvalue=100*value/value[1]) %>%
 # Creating variable lnvalue as the natural logarithm
 dplyr::mutate(lnalue=log(value)) %>%
 # Creating lvalue as the lagged variable 12 months back in timefor each country
 dplyr::mutate(lvalue=dplyr::lag(value,n=12)) %>%
 # Creating variable for year growth
 dplyr::mutate(growth=round(value/lvalue-1, 6)*100) %>%
 dplyr::ungroup()
mv2 <- mean(app4bout[[plv]], na.rm=TRUE)
#
#**Table**
summary(app4bout,5)

## **Plot**
ggplot2::ggplot(data=app4bout, aes(x = date, y =!!as.name(plv))) +
  geom_line(aes(color = couid)) + ggplot2::labs(title='Tidsserier') +
  geom_label(y=100,x=as.numeric(vd1),label="Pandemi sluttfase") +
  geom_label(y=100,x=as.numeric(vd2),label="Pandemi startfase") +
  ggplot2::theme_minimal()

