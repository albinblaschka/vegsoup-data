
library(vegsoup)

file <- "~/Documents/vegsoup-data/bad bruck dta/species.csv"
# promote to class "Species"

X <- species(file, sep = ";")
X <- X[, 1:4]

file <- "~/Documents/vegsoup-data/bad bruck dta/sites.csv"
# promote to class "Sites"
Y <- sites(read.csv2(file))

file <- "~/Documents/vegsoup-standards/austrian standard list 2008/austrian standard list 2008.csv"
# promote to class "SpeciesTaxonomy"
XZ <- SpeciesTaxonomy(X, file.y = file)
# promote to class "Vegsoup"
bb <- Vegsoup(XZ, Y, coverscale = "braun.blanquet")

save(bb, file = "~/Documents/vegsoup-data/bad bruck dta/bb.rda")
rm(list = ls()[-grep("bb", ls(), fixed = TRUE)])

