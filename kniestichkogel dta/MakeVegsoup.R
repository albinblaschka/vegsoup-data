library(vegsoup)

file <- "~/Documents/vegsoup-data/kniestichkogel dta/species.csv"
# promote to class "Species"

X <- species(file, sep = ";")
X <- X[, 1:4]
file <- "~/Documents/vegsoup-data/kniestichkogel dta/sites wide.csv"

# promote to class "Sites"
Y <- stack.sites(file = file)

file <- "~/Documents/vegsoup-standards/austrian standard list 2008/austrian standard list 2008.csv"
# promote to class "SpeciesTaxonomy"
XZ <- SpeciesTaxonomy(X, file.y = file)
# promote to class "Vegsoup"
kn <- Vegsoup(XZ, Y, coverscale = "braun.blanquet")

save(kn, file = "~/Documents/vegsoup-data/kniestichkogel dta/kn.rda")
rm(list = ls()[-grep("kn", ls())])
