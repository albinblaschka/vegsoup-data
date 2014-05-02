
library(vegsoup)

file <- "~/Documents/vegsoup-data/burghausen dta/species.csv"
# promote to class "Species"

X <- species(file, sep = ";")
X <- X[, 1:4]

file <- "~/Documents/vegsoup-data/burghausen dta/sites wide.csv"
# promote to class "Sites"
Y <- stackSites(read.csv2(file))

file <- "~/Documents/vegsoup-standards/austrian standard list 2008/austrian standard list 2008.csv"
# promote to class "SpeciesTaxonomy"
XZ <- SpeciesTaxonomy(X, file.y = file)
# promote to class "Vegsoup"
bh <- Vegsoup(XZ, Y, coverscale = "braun.blanquet")

save(bh, file = "~/Documents/vegsoup-data/burghausen dta/bh.rda")
rm(list = ls()[-grep("bh", ls(), fixed = TRUE)])
