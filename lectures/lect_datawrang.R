### 0. Installing packages ###
library(devtools)
library(readr)
library(datasets)
library(dplyr)
library(writexl)
library(googlesheets4)
install_github("joernih/OEKA201Assignment")
install.packages("googlesheets4")
|#install_github("joernih/https://github.com/joernih/WASMA")



### I. Importing data to R ###
data(package = "datasets")
data(package = "OEKA201Assignment")
## a) From CSV-format
df_iris  <- iris
## c) From CSV-format
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
df_app0 <- data.frame(
  id = c(1, 2, 3, 4, 5),
  name = c("Alice", "Bob", "Charlie", "David", "Eve"),
  age = c(25, 30, 35, 40, 45)
)
df_app0out <- df_app0 %>%
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

## Application 2
df_app2out <- df_wine %>%
  # Insert comment
	na.omit()

#nb_ts
#fred_ts[[2]]
#fred_ts[[2]]
#data_vk <- data.frame(nb_ts[[1]][[1]])

## Application 3
df_app3out <- df_app0
## Application 4a
df_app4aout <- df_app0 #%>%
## Application 4b
df_app4bout <- df_app0 #%>%

### III. Exporting data from R and Python ###
## To R data format (hyperfast!)
## To CSV
data <- data.frame(x = c(1, 2, 3), y = c("A", "B", "C"))
write.csv(data, "output.csv", row.names = FALSE)
## To spreadsheets
# import writexl library
library(writexl)

# Create a data frame
data <- data.frame(player=c('A', 'B', 'C', 'D'),
				runs=c(100, 200, 408, NA),
				wickets=c(17, 20, NA, 5))

# Import data in dataframe to an excel sheet
## Excel
write_xlsx(data, "write.xlsx")
## Google sheet

