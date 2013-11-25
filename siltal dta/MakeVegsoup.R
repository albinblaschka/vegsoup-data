library(vegsoup)

file <- "~/Documents/vegsoup-data/siltal dta/species.csv"
# promote to class "Species"

X <- species(file, sep = ";")
X <- X[, 1:4]
file <- "~/Documents/vegsoup-data/siltal dta/sites.csv"

# promote to class "Sites"
Y <- sites(read.csv2(file))

file <- "~/Documents/vegsoup-standards/austrian standard list 2008/austrian standard list 2008.csv"
# promote to class "SpeciesTaxonomy"
XZ <- SpeciesTaxonomy(X, file.y = file)
# promote to class "Vegsoup"
si <- Vegsoup(XZ, Y, coverscale = "braun.blanquet")

save(si, file = "~/Documents/vegsoup-data/siltal dta/si.rda")
rm(X, Y, XZ, file)