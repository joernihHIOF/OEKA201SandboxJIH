# Abc

# abc_out.data
# abc_out.js.metadata
# biler.csv
# biler.gdt
# boliger.csv
# boliger.gdt
# elbiler.csv
# elbiler.gdt
# feriereiser.gdt
# luftkvalitet.csv
# luftkvalitet.gdt
# newcars.gdt
# pizza.csv
# pizza.gdt
# tidsserier.gdt
# toyota.csv
# toyota.gdt
# usedvw.gdt
# vareAB.csv
# vareAB.gdt

usedvw <- gretlReadWrite::read.gdt("gdt/usedvw.gdt")
newcars <- gretlReadWrite::read.gdt("gdt/newcars.gdt")
icecream <- gretlReadWrite::read.gdt("../internal/ex1_linear/icecream.gdt")
adverticing <- gretlReadWrite::read.gdt("../internal/ex2_nonlinear/advertising.gdt")
tssales <- gretlReadWrite::read.gdt("../internal/ex3_timeseries/TSsales1.gdt")


usethis::use_data(usedvw,overwrite=TRUE)
usethis::use_data(newcars,overwrite=TRUE)
usethis::use_data(adverticing,overwrite=TRUE)
usethis::use_data(tsales,overwrite=TRUE)
