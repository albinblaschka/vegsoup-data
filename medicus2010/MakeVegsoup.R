library(vegsoup)

source("~/Documents/vegsoup-data/medicus2010/MakeVegsoup 1.R")
source("~/Documents/vegsoup-data/medicus2010/MakeVegsoup 2.R")

medicus2010 <- bind(medicus2010tab1, medicus2010tab2)
QuickMap(medicus2010)
save(medicus2010, file = "~/Documents/vegsoup-data/medicus2010/medicus2010.rda")