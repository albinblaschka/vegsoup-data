library(vegsoup)

file <- "~/Documents/vegsoup-data/frommerkogel dta/species.csv"
# promote to class "Species"

X <- species(file, sep = ";")
X <- X[, 1:4]
file <- "~/Documents/vegsoup-data/frommerkogel dta/sites.csv"

# promote to class "Sites"
Y <- sites(read.csv2(file))

file <- "~/Documents/vegsoup-standards/austrian standard list 2008/austrian standard list 2008.csv"
# promote to class "SpeciesTaxonomy"
XZ <- SpeciesTaxonomy(X, file.y = file)
# promote to class "Vegsoup"
fk <- Vegsoup(XZ, Y, coverscale = "braun.blanquet")

save(fk, file = "~/Documents/vegsoup-data/frommerkogel dta/fk.rda")
rm(list = ls()[-grep("exner2004", ls(), fixed = TRUE)])