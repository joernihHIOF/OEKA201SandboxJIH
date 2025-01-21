# ToDox exercies
## Task 1
numbers <- c(4,5,8,11)
sum(numbers)
## Task 2
# help(sqrt)
## Task 3
rnorm(n=100, mean = 0, sd = 1)
## Task 4
now <- as.numeric(substring(paste(Sys.Date()),1,4))
started <- 2020
born <- 1995
spent <- (now-started)/(now-born)*100
round(spent, digits=4)
