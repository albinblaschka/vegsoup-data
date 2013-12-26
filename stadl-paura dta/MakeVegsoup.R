library(vegsoup)

file <- "~/Documents/vegsoup-data/stadl-paura dta/species.csv"
# promote to class "Species"

X <- species(file, sep = ";")
X <- X[, 1:4]
file <- "~/Documents/vegsoup-data/stadl-paura dta/sites wide.csv"

# promote to class "Sites"
Y <- stackSites(file = file)

file <- "~/Documents/vegsoup-standards/austrian standard list 2008/austrian standard list 2008.csv"
# promote to class "SpeciesTaxonomy"
XZ <- SpeciesTaxonomy(X, file.y = file)
# promote to class "Vegsoup"
sp <- Vegsoup(XZ, Y, coverscale = "braun.blanquet")

save(sp, file = "~/Documents/vegsoup-data/stadl-paura dta/sp.rda")
rm(list = ls()[-grep("sp", ls())])