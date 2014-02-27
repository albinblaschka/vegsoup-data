
library(vegsoup)

file <- "~/Documents/vegsoup-data/barmstein dta/species.csv"
# promote to class "Species"

X <- species(file, sep = ";")
X <- X[, 1:4]

file <- "~/Documents/vegsoup-data/barmstein dta/sites wide.csv"
# promote to class "Sites"
Y <- stackSites(file = file)
Y$value <- gsub("ß", "\u00df", Y$value)
Y$value <- gsub("ü", "\u00fc", Y$value)

file <- "~/Documents/vegsoup-standards/austrian standard list 2008/austrian standard list 2008.csv"
# promote to class "SpeciesTaxonomy"
XZ <- SpeciesTaxonomy(X, file.y = file)
# promote to class "Vegsoup"
bs <- Vegsoup(XZ, Y, coverscale = "braun.blanquet")

save(bs, file = "~/Documents/vegsoup-data/barmstein dta/bs.rda")
rm(list = ls()[-grep("bs", ls(), fixed = TRUE)])

#	vegsoup test data
#	barmstein <- bs
#	barmstein@sites <- barmstein@sites[, -grep("comment", names(barmstein))]
#	barmstein@sites <- barmstein@sites[, -grep("description", names(barmstein))]
#	barmstein@sites <- barmstein@sites[, -grep("location", names(barmstein))]
#	barmstein@taxonomy <- barmstein@taxonomy[, c(1,2,4)]
#	Sites(barmstein)
#	save(barmstein, file = "barmstein.rda")


