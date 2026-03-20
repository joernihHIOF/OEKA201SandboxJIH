---
title : "Template for Bjørnar's assignment using Gretl"
format: html
#format: pdf
#format: docx
author:
  - name: John Doe
    affiliations:
      - Carnegie Mellon University
      - University of Chicago
  - name: Jane Smith
    affiliations:
      - Stanford University
---

# Step A: Research question and data
## 1. Research question
## 2. Data set
# Step B: Analysis
## 1. Data Description & Summary
## 2. Simple regression model
## 3. Multiple regression Model 
## 4. Dummy variable analysis
## 4. Non-linear effects
## 5. Model selection and analysis


# Appendix
*Model 1*
$$
price_i = \beta_0 + \beta_1Age_i + u_i 
$$

a.
a.
a.
a.
a.

*Model 2*
$$
price_i = \beta_0 + \beta_1Age_i + \beta_2WinterRain_i  +\beta_3temp_i + \beta_3HarvestRain_i + u_i 
$$

a.
a.
a.

*Model 3*
$$
price_i = \beta_0 + \beta_1Dheavyraint_i + \beta_2tempt_i + \beta_3temp_i · Dheavyrain_i + u_i
$$

Legger til txt fil fra Gretl

``` 
                    Mean      Median        S.D.         Min         Max
price             1405,8      1079,8      1027,2      495,17      4883,9
WinterRain        608,41      600,00      129,03      376,00      830,00
temp              16,478      16,417     0,65919      14,983      17,650
HarvestRain       144,81      123,00      73,066      38,000      292,00
Age               16,185      16,000      8,2464      3,0000      31,000

```

Legger til png fra Gretl

![Png of residualta](gretl/res1.png)




::: {.cell}

:::


