library(vegsoup)

file <- "~/Documents/vegsoup-data/weitwörth dta/species.csv"
# promote to class "Species"

X <- species(file, sep = ";")
X <- X[, 1:4]
file <- "~/Documents/vegsoup-data/weitwörth dta/sites wide.csv"

# promote to class "Sites"
Y <- stackSites(file = file)

file <- "~/Documents/vegsoup-standards/austrian standard list 2008/austrian standard list 2008.csv"
# promote to class "SpeciesTaxonomy"
XZ <- SpeciesTaxonomy(X, file.y = file)
# promote to class "Vegsoup"
ww <- Vegsoup(XZ, Y, coverscale = "braun.blanquet")

save(ww, file = "~/Documents/vegsoup-data/weitwörth dta/ww.rda")
rm(list = ls()[-grep("ww", ls(), fixed = TRUE)])

