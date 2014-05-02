library(vegsoup)

#	change directory
setwd("~/Documents/vegsoup-data/krisai1996")

source("MakeVegsoupTab7.R")
source("MakeVegsoupTab8.R")

krisai1996 <- bind(krisai1996tab7, krisai1996tab8)
Layers(krisai1996)
save(krisai1996, file = "~/Documents/vegsoup-data/krisai1996/krisai1996.rda")

Layers(krisai1996) <- rev(c("ml", "hl", "sl", "tl"))

rm(list = ls()[-grep("krisai1996", ls(), fixed = TRUE)])

#	QuickMap(krisai1996)
#	vp <- VegsoupPartition(krisai1996, clustering = "syntaxon")
#	Latex(Fidelity(vp, "TCR"), stat.min  = 0.3)
#	
