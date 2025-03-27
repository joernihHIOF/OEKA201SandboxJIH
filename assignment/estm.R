# Libraries
library(readr)
library(broom)
library(gretlR)
suppressPackageStartupMessages(library(dplyr))
# Settings
# Reading data
iwine <- readr::read_csv("https://raw.githubusercontent.com/joernih/OEKA201Assignment/refs/heads/main/data-raw/csv/wine.csv",show_col_types = FALSE)
owine <- iwine %>%
        # variables in use
        dplyr::select(price, WinterRain, temp, HarvestRain, Age) %>%
        ## interaction effects
        ## na ommit


### Exercise 1

### Exercise 2

### Exercise 3

### Exercise 4

### Exercise 5
