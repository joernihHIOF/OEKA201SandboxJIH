### 0. Installing packages ###
library(devtools)
library(readr)
library(datasets)
library(dplyr)
library(writexl)
library(googlesheets4)
library(ggplot2)
install_github("joernih/OEKA201Assignment")
install.packages("googlesheets4")
df_iris  <- iris
nb_ts <- get(load("../data/nb_ts.rda"))
fred_ts <- get(load("../data/fred_ts.rda"))

### I. Importing data to R ###
## a) Directoy from R
df_res <- data(package = "datasets")$results
df_res
df_asg <- data(package = "OEKA201Assignment")$results
df_asg

## b) From CSV-format
df_wine <- read_csv("https://raw.githubusercontent.com/joernih/OEKA201Assignment/refs/heads/main/data-raw/csv/wine.csv")
## c) From Spreadsheets
### ca) Excel
df_excl <- readxl::read_excel("read.xlsx")
summary(df_excl)
### cb) Google
gs4_deauth()
df_gosp <- read_sheet("https://docs.google.com/spreadsheets/d/12V808zXNxFvWldpsfU3A8vo9ZNVbqFB7LQmTht_Pjbc/edit?usp=sharing")
summary(df_gosp)

### II. Data transformation in R and Python ###
# The dplyr package
## Application 1
df_app1 <- data.frame(
  id = c(1, 2, 3, 4, 5),
  name = c("Alice", "Bob", "Charlie", "David", "Eve"),
  age = c(25, 30, 35, 40, 45)
)
app1out <- df_app1 %>%
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
#View(app1out)

## Application 2
df_app2out <- df_wine %>%
  # Exercise: Try to insert three new pipes
  # Insert comment
  # Insert comment
  # Insert comment
   na.omit()
df_app2out
#View(app2out)

## Application 3a
### Settings
mvar <- c("mb3","cpi","une","mba","int","gdp")[1]
vd1 <- as.Date("2022-01-01")
vd2 <- as.Date("2020-02-01")
startd_i <- '2020-01-01'
startd_n <- '2024-01-01'
plv <- c('nvalue','growth')[1]

### Data transformation
app3aout <-
 fred_ts[[2]] %>%
  # Insert comment
 dplyr::filter(id==mvar,country=="NOR") %>%
  # Insert comment
 dplyr::mutate(date=base::as.Date(date)) %>%
  # Insert comment
 dplyr::filter(date>startd_i) %>%
  # Insert comment
 dplyr::filter(date<startd_n) %>%
  # Insert comment
 dplyr::mutate(nvalue=100*value/value[1]) %>%
  # Insert comment
 dplyr::mutate(lnalue=log(value)) %>%
  # Insert comment
 dplyr::mutate(lvalue=dplyr::lag(value,n=12)) %>%
  # Insert comment
 dplyr::mutate(growth=round(value/lvalue-1, 6)*100)

# Finding the mean values for all variables in fred_ts
mv1 <- mean(app3aout[[plv]], na.rm=TRUE)
#View(app3aout)

### Plot
summary(app3aout,5)

### Plot
pp1 <- ggplot(app3aout,aes(x = date, y = !!as.name(plv))) +
  geom_point() + # ...
  geom_vline(xintercept = as.numeric(vd1), linetype = "dashed", color = "blue") + # ...
  geom_vline(xintercept = as.numeric(vd2), linetype = "dashed", color = "blue") + # ...
  geom_label(y=100,x=as.numeric(vd1),label="Pandemi sluttfase") + # ...
  geom_label(y=100,x=as.numeric(vd2),label="Pandemi startfase") + # ...
  geom_hline(yintercept = mv1, linetype = "dashed", color = "red") + # ...
  geom_line() +
  theme_classic()
pp1

## Application 3b
### Settings
lnd <- c("USA","JPN","EUZ","GBR","CAN","NOR","DEN","SWE","SKE")[c(6,1,2,3)]
vd1 <- as.Date("2022-01-01")
vd2 <- as.Date("2020-02-01")
startd_i <- '2020-01-01'
startd_n <- '2024-01-01'
mvar <- c("mb3","cpi","une","mba","int","gdp")[1]
plv <- c('nvalue','growth')[1]

### Data transformation
app3bout <-
 fred_ts[[2]] %>%
 # Insert comment
 dplyr::filter(id==mvar,country%in%lnd) %>%
 # Insert comment
 dplyr::mutate(date=base::as.Date(date)) %>%
 # Insert comment
 dplyr::filter(date>startd_i) %>%
 # Insert comment
 dplyr::filter(date<startd_n) %>%
 # Insert comment
 dplyr::group_by(country) %>%
 # Insert comment
 dplyr::mutate(couid=paste0(country,id)) %>%
 # Insert comment
 dplyr::mutate(nvalue=100*value/value[1]) %>%
 # Insert comment
 dplyr::mutate(lnalue=log(value)) %>%
 # Insert comment
 dplyr::mutate(lvalue=dplyr::lag(value,n=12)) %>%
 # Insert comment
 dplyr::mutate(growth=round(value/lvalue-1, 6)*100) %>%
 dplyr::ungroup()
mv2 <- mean(app3bout[[plv]], na.rm=TRUE)

### Summary
summary(app3bout,5)

### Plot
ggplot2::ggplot(data=app3bout, aes(x = date, y =!!as.name(plv))) +
  geom_line(aes(color = couid)) + ggplot2::labs(title='Tidsserier') +
  geom_label(y=100,x=as.numeric(vd1),label="Pandemi sluttfase") +
  geom_label(y=100,x=as.numeric(vd2),label="Pandemi startfase") +
  ggplot2::theme_minimal()


### III. Exporting data from R and Python ###
## a) To R data format (hyperfast!)
library(usethis)
# You can yourself determine the file path
save(df_app2out, file = "../data/abc.rda")


## b) To CSV
data <- data.frame(x = c(1, 2, 3), y = c("A", "B", "C"))
write.csv(data, "output.csv", row.names = FALSE)
## To spreadsheets
# import writexl library
library(writexl)

# Create a data frame
data <- data.frame(player=c('A', 'B', 'C', 'D'),
				runs=c(100, 200, 408, NA),
				wickets=c(17, 20, NA, 5))

# c) Import data in dataframe to an excel sheet
## Excel
write_xlsx(df_iris, "write.xlsx")
## Google sheet




