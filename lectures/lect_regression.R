# Libraries
library(readr)
library(broom)
library(gretlR)
suppressPackageStartupMessages(library(dplyr))
# Reading data

##¤ 1. model specifications ###
#### Model 1
asbjmlv1 <- "price_i=\\beta_0+\\beta_1 Age_i"
asbjmev1 <- price ~ Age 

#### Model 2
asbjmlv2 <- "price_i = \\beta_0+\\beta_1 Age_i + \\beta_2 WinterRain_i + \\beta_3 temp_i + \\beta_4 HarvestRain_i"
asbjmev2 <- price ~ Age + WinterRain + temp + HarvestRain 

#### Model 3
asbjmlv3 <- "price_i = \\beta_0+\\beta_1 Age_i + \\beta_2 WinterRain_i + \\beta_3 temp_i + \\beta_4 HarvestRain_i + \\beta_5 Dheavyraint"
asbjmev3 <- price ~ Age + WinterRain + temp + HarvestRain + Dheavyraint

### 2. Data import and transformations ###
iwine <- readr::read_csv("https://raw.githubusercontent.com/joernih/OEKA201Assignment/refs/heads/main/data-raw/csv/wine.csv",show_col_types = FALSE)
names(iwine)
iadvt <- readr::read_csv("https://raw.githubusercontent.com/joernih/OEKA201Assignment/refs/heads/main/data-raw/csv/adverticing.csv",show_col_types = FALSE)
names(iadvt)
itssl <- readr::read_csv("https://raw.githubusercontent.com/joernih/OEKA201Assignment/refs/heads/main/data-raw/csv/tssales.csv",show_col_types = FALSE)
names(itssl)
# [1] "obs"         "price"       "WinterRain"  "temp"        "HarvestRain" "Age"        
# [1] "obs"         "price"       "WinterRain"  "temp"        "HarvestRain" "Age"        

# Generate a new variable Dheavyraint that is equal to one for the vintages in the sample with very high levels of rainfall in the harvest season (more than 200 mm) and 0 otherwise.
hlim <- 200
owine <- iwine %>%
        # variables in use
        dplyr::select(price, WinterRain, temp, HarvestRain, Age) %>%
        ## interaction effects
        dplyr::mutate(Dheavyraint=ifelse(HarvestRain>hlim,1,0)) %>%
        ## na ommit
        stats::na.omit()

# More pipes will be added here
oadvt <- iadvt
otssl  <- itssl
#View(owine)

### Graphical
#pgr <- pairs(owine)

### Numerical
sds <- summary(owine)
cds <- cor(owine)

### 4. Model estimations ###
mod1 <- lm(asbjmev1,data=owine)
mod2 <- lm(asbjmev2,data=owine)
mod3 <- lm(asbjmev3,data=owine)

### 5. Results ###
# Note:
class(owine); class(mod1)
## Estimation summary
summary(mod1)
summary(mod2)
summary(mod3)

### Broom package: Pretty output
mot1 <- broom::tidy(mod1)
mot2 <- broom::tidy(mod2)
mot3 <- broom::tidy(mod3)
moa1 <- broom::augment(mod1)
moa2 <- broom::augment(mod2)
moa3 <- broom::augment(mod3)
mog1 <- broom::glance(mod1)
mog2 <- broom::glance(mod2)
mog3 <- broom::glance(mod3)

### Output
mot1
mot2
mot3
moa1
moa2
moa3
mog1
mog2
mog3

## Predict
nd1 <- data.frame(Age = 30)
pv1 <- predict(mod1, newdata = nd1)
nd2 <- data.frame(Age = 30)
pv2 <- predict(mod1, newdata = nd2, interval = "prediction", level = 0.95)
## Assuming your model is named 'mod1' and the dataset contains a column 'vintage'

