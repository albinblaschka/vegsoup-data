library(vegsoup)

file <- "~/Documents/vegsoup-data/weißkirchen dta/species.csv"
# promote to class "Species"

X <- species(file, sep = ";")
X <- X[, 1:4]

file <- "~/Documents/vegsoup-data/weißkirchen dta/sites wide.csv"

# promote to class "Sites"
Y <- stack.sites(file = file)

file <- "~/Documents/vegsoup-standards/austrian standard list 2008/austrian standard list 2008.csv"

# promote to class "SpeciesTaxonomy"
XZ <- SpeciesTaxonomy(x = X, file.y = file)
XZ

# promote to class "Vegsoup"
wk <- Vegsoup(XZ, Y, coverscale = "braun.blanquet")

save(wk, file = "~/Documents/vegsoup-data/weißkirchen dta/wk.rda")
rm(list = ls()[-grep("wk", ls(), fixed = TRUE)])
