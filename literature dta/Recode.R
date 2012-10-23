#	not run!
#	recode
tb <- read.delim("~/Documents/vegsoup data/literature dta/recode.txt", colClasses ="character", header = FALSE)
spc <- read.csv2("~/Documents/vegsoup data/literature dta/species.csv", colClasses ="character")
sts <- read.csv2("~/Documents/vegsoup data/literature dta/sites.csv", colClasses ="character")

for (i in 1:nrow(tb)) {
	spc[spc[,1] == tb[i,1], 1] <-  tb[i,2]
	sts[sts[,1] == tb[i,1], 1] <-  tb[i,2]
}

write.csv2(spc, "~/Documents/vegsoup data/literature dta/species.csv")
write.csv2(sts, "~/Documents/vegsoup data/literature dta/sites.csv")

#	add missing colon in spreadsheet

