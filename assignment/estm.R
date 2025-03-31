# Libraries
# Libraries
## Internal
#library(OEKA201ProgrammingJ<>)  # Insert your package here
## External
library(readr)
library(broom)
library(gretlR)

# Settings
# Reading data
#iwine <- <insert your package data here> 
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
