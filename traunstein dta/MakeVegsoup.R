library(vegsoup)

file <- "~/Documents/vegsoup-data/traunstein dta/species.csv"
# promote to class "Species"

X <- species(file, sep = ";")
X <- X[, 1:4]
file <- "~/Documents/vegsoup-data/traunstein dta/sites wide.csv"

# promote to class "Sites"
Y <- stack.sites(file = file)

file <- "~/Documents/vegsoup-standards/austrian standard list 2008/austrian standard list 2008.csv"
# promote to class "SpeciesTaxonomy"
XZ <- SpeciesTaxonomy(X, file.y = file)
# promote to class "Vegsoup"
ts <- Vegsoup(XZ, Y, coverscale = "braun.blanquet")

save(ts, file = "~/Documents/vegsoup-data/traunstein dta/ts.rda")
rm(list = ls()[-grep("ts", ls(), fixed = TRUE)])