biler <- WASMP::biler
#########################################################

rm(list=ls())
#setwd("C:/Users/brukernavn/Dokumenter/R") ##Endre til plasseringen der du jobber (f.eks. der R-filen ligger.)

#########################################################
### Kapittel 2
########################################################
x <- 2
y <- 2*x+3

lonn <- c(320,290,170,480,510,410,650,370)
utd <- c(2,3,1,5,5,4,7,5)

###Alternativt hvis dataene er i en csv-fil:
#setwd("C:/Users/brukernavn/Dokumenter/R")
#lonndata <- read.table(file="lonnutd.csv", sep=";",fill=TRUE, header = TRUE)

plot(utd, lonn, main="Spredningsplott lC8nn og utdanning", xlab="utdanning", ylab="lC8nn", pch=19)


#########################################################
### Kapittel 3
########################################################
summary(lonn)
mean(lonn)
sd(lonn)
summary(utd)
mean(utd)
sd(utd)

cor(lonn,utd)
cor.test(lonn,utd)

#Normalfordelingen (venstre halesannsynlighet): 
pnorm(-1.96)
qnorm(0.025)
#t-fordelingen (venstre halesannsynlighet):
pt(-2.31,8)
qt(0.025,8)
#F-fordeling (hC8yre halesannsynlighet):
pf(5.786,2,5,lower.tail=FALSE)
qf(0.05,2,5,lower.tail=FALSE)
#Kjikvadratfordelingen (hC8yre halesannsynlighet):
pchisq(3.841,1, lower.tail=FALSE)
qchisq(0.05,1, lower.tail=FALSE)



#########################################################
### Kapittel 4
########################################################
hoyde <- c(181,182,170,172,190,200,175,177,183)
t.test(hoyde,mu=180,alternative = 'greater')

levetid <- c(5200,5100,4700,5200,5200,5200,4900,4800,5100,4500,5500,5000,4300,4500,4300)
t.test(levetid,mu=5000,alternative = 'less')

lonn21 <- c(315,295,165,470,490,380,630,370)
lonn22  <- c(320,290,170,480,510,410,650,370)
D <- lonn22-lonn21
t.test(D,mu=0,alternative = 'two.sided')

t.test(lonn22,lonn21, var.equal=TRUE,paired = TRUE)


#########################################################
### Kapittel 5
########################################################
enkelreg <- lm(lonn ~ utd)
summary(enkelreg)
abline(enkelreg)


### Prediksjon
yhat <- fitted(enkelreg)
uhat <- resid(enkelreg)

### ANOVA:
anova <- aov(enkelreg)
summary(anova)
### TSS:
sum((lonn-mean(lonn))^2)

### Konfidensintervall:
confint(enkelreg)

### Prediksjonsintervall
predict(enkelreg, interval="predict", level =0.95)


### Grafisk vurdering av forutsetningene
plot(utd, uhat , main="Spredningsplott residualer og uavhengig variabel", xlab="utdanning", ylab="residual", pch=19)
plot(uhat , main="Spredningsplott residualer og observasjonsnummer", xlab="observasjonsnr", ylab="residual", pch=19)
hist(uhat, main="Histogram residualer", xlab="residual", ylab="frekvens", pch=19)
plot(lonn, yhat , main="Spredningsplott lC8nn og predikert lC8nn", xlab="yhat", ylab="lonn", pch=19)


###Engelske figurer:
wage <- lonn
edu <- utd

plot(edu, uhat , main="Scatterplot residuals and independent variable", xlab="education",  ylab="residual", pch=19)
plot(uhat , main="Scatterplot residuals and observation number", xlab="observation number", ylab="residual", pch=19)
hist(uhat, main="Histogram residuals", xlab="residual", ylab="frequency", pch=19)
plot(wage, yhat , main="Scatter plot wage and predicted wage", xlab="yhat", ylab="wage", pch=19)

#########################################################
### Kapittel 6
########################################################
erf <- c(5,3,1,12,40,25,35,4)

multippelreg <- lm(lonn ~ utd + erf)
summary(multippelreg)

### F-test:
nullmodell <- lm(lonn ~ 1)
anova(multippelreg,nullmodell)


### Eksempel forbruk biler
#biler <- read.table(file="biler.csv", sep=",", fill=TRUE, header = TRUE) 
biler_mod1 <- lm(pris ~ forbruk, data=biler)
biler_mod2 <- lm(pris ~ forbruk + HK, data=biler)
biler_mod3 <- lm(pris ~ forbruk + HK + stv, data=biler)



### Heteroskedastisitetstest:
#install.packages("lmtest") #m?? gj??res f??rste gang
library(lmtest)
bptest(multippelreg)
bptest(multippelreg, ~ I(utd^2) + I(erf^2))
bptest(multippelreg, ~ I(utd^2) + I(erf^2) + utd*erf)

#install.packages("estimatr") #m?? gj??res f??rste gang
library(estimatr)
lm_robust(lonn ~ utd)

### Eksempel heteroskedastisitet
X4 <- 1:10
uhat <- c(0.2,-0.1,0.1,-0.2,0.15,0.3,-0.4,0.6,-0.8,0.7)
plot(X4,uhat, xlab="X4", ylab="uhat", pch=19)
abline(h=0, lty=2)

#########################################################
### Kapittel 7
########################################################
offsek <- c(1,1,1,0,0,0,0,1)
privsek <- c(0,0,0,1,1,1,1,0)

kommune <- c(301,5001,301,5001,4601,5001,4601,301)
oslo <- ifelse(kommune == 301, 1, 0)
bergen <- ifelse(kommune == 4601, 1, 0)
trondheim <- ifelse(kommune == 5001, 1, 0)

H0modell <- lm(lonn ~ 1)
BergenTrheim <- lm(lonn ~ bergen + trondheim)
anova(BergenTrheim,H0modell)


probitmodell <- glm(privsek ~ utd, family=binomial(link="probit"))
summary(probitmodell)
predict(probitmodell)
probitmodell$fitted.values

logitmodell <- glm(privsek ~ utd, family=binomial(link="logit"))
summary(logitmodell)
logitmodell$fitted.values
#########################################################
### Kapittel 8
########################################################
lnerf <- log(erf)
lnlonn <- log(lonn)

linlin <- lm(lonn ~ erf)
summary(linlin)
linlog <- lm(lonn ~ lnerf)
summary(linlog)
loglin <- lm(lnlonn ~ erf)
summary(loglin)
loglog <- lm(lnlonn ~ lnerf)
summary(loglog)

sq_erf = erf^2
cu_erf = erf^3
quadr <- lm(lonn ~ erf + sq_erf)
summary(quadr)
cubic <- lm(lonn ~ erf + sq_erf + cu_erf)
summary(cubic)

#########################################################
### Kapittel 9
########################################################
aar <- seq(as.Date("2001-01-01"), length = 6, by = "year")
salg <- c(4000,5500,5000,6000,7000,7500)
pris <- c(70,68,79,85,91,89)
#salg <- ts(salg, frequency = 1, start=c(2001))
#pris <- ts(pris, frequency = 1, start=c(2001))

#tsdata <- cbind(salg,pris,t, order.by=aar)

plot(salg, col="blue", ylab="salg (blC%)")
par(new = TRUE)
plot(pris, axes = FALSE, bty = "n", xlab = "", ylab = "", col="red")
axis(side=4, at = pretty(range(pris)))
mtext("pris (rC8d)", side=4, line=3)

t <- (1:6)
#t <- ts(t, frequency = 1, start=c(2001,1))


regsalgpris <- lm(salg ~ pris)
summary(regsalgpris)
regsalgprist <- lm(salg ~ pris + t)
summary(regsalgprist)

motorv <- c(15.9, 15.7, 15.4, 15.3, 14.9)
sitron <- c(230,265,358,480,530)
regsitron <- lm(motorv ~ sitron)
summary(regsitron)
trend5 <- (1:5)
regsitront <- lm(motorv ~ sitron + trend5)
summary(regsitront)

#install.packages("dplyr") #kun fC8rste gang
library(dplyr)
salg1 <- lag(salg)
salg2 <- lag(salg, 2)

pris1 <- lag(pris)
pris2 <- lag(pris, 2)

dsalg <- salg-lag(salg)
dpris <- pris-lag(pris)

salgvekst <- (salg-lag(salg))/lag(salg)*100
prisvekst <- (pris-lag(pris))/lag(pris)*100


AR1 <- lm(salg ~ lag(salg))
summary(AR1)

set.seed(10)
trend20 <- (1:20)
random <- runif(20)
tsvar <- trend20+random
summary(lm(random ~ lag(random)))
summary(lm(tsvar ~ lag(tsvar)))
Z <- ts(random)
W <- ts(tsvar)
plot(Z,ylim=c(-0.5,1.5))
plot(W)

salgny <- c(4000,6000,12000,8000,10000,13000,20000,15000,17000,20000,25000,21000)
#salgny <- ts(salgny, frequency = 4, start=c(2000,1))
ar1 <- lm(salgny ~ lag(salgny))
summary(ar1)
trend12 <- 1:12
#trend12 <- ts(trend12, frequency = 4, start=c(2000,1))

#install.packages("urca") #m?? gj??res f??rste gang
library(urca)
adfc <- ur.df(salgny, type="drift", lags = 1)
summary(adfc)
adft <- ur.df(salgny, type="trend", lags = 1)
summary(adft)

#install.packages("forecast") #m?? gj??res f??rste gang
library(forecast)
salgnyts <- ts(salgny, frequency = 4, start=c(2000,1))
sesong <- seasonaldummy(salgnyts)
dq1 <- sesong[,1]
dq2 <- sesong[,2]
dq3 <- sesong[,3]
ar1dses <- lm(salgny ~ lag(salgny) + trend12 + dq1)
summary(ar1dses)

#install.packages("MLmetrics") #m?? gj??res f??rste gang
library(MLmetrics)
ar1tr <- lm(salgny ~ lag(salgny) + trend12)
summary(ar1tr)

RMSE(ar1$fitted.values, salgny[2:12])
MAE(ar1$fitted.values, salgny[2:12])
MAPE(ar1$fitted.values, salgny[2:12])

RMSE(ar1tr$fitted.values, salgny[2:12])
MAE(ar1tr$fitted.values, salgny[2:12])
MAPE(ar1tr$fitted.values, salgny[2:12])

#install.packages("lmtest") #m?? gj??res f??rste gang
library(lmtest)
bgtest(ar1,order=4,type="F")


#########################################################
### Kapittel 10
########################################################
### t-test;
Loff <- c(320,290,170,370)
Lpriv <- c(480,510,410,650)
t.test(Loff,Lpriv)


#### Kjikvadrattest:
#vareAB <- read.table(file="vareAB.csv", sep=",", fill=TRUE, header = TRUE) 
#A <- vareAB$A
#mann <- vareAB$mann
#chisq.test(A,mann,correct=FALSE)
#
#
#### Variansanalyse:
#anovalonnkommune <- aov(lonn ~ oslo + bergen + trondheim)
#summary(anovalonnkommune)
#
#variansanalyse ~ forklvar <- aov(lonn ~ factor(kommune))
#summary(variansanalyse)
#
#anova(anovalonnkommune, type="III")
#
#oneway.test(lonn ~ kommune)
#
#
########################################################################
##Dataene kan ogs?? settes inn i et eget objekt:
#dataframe <- data.frame(lonn,utd,erf,offsek,privsek,kommune,oslo,bergen,trondheim)
#
#
