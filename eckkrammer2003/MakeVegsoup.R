library(vegsoup)

source("~/Documents/vegsoup-data/eckkrammer2003/MakeVegsoup 1.R")
source("~/Documents/vegsoup-data/eckkrammer2003/MakeVegsoup 2.R")
source("~/Documents/vegsoup-data/eckkrammer2003/MakeVegsoup 3.R")

eckkrammer2003 <- bind(eckkrammer2003tab1, eckkrammer2003tab2, eckkrammer2003tab3)
save(eckkrammer2003, file = "~/Documents/vegsoup-data/eckkrammer2003/eckkrammer2003.rda")