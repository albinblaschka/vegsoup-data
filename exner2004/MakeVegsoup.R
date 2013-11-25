library(vegsoup)

file <- "~/Documents/vegsoup-data/exner2004/species.csv"
# promote to class "Species"

X <- species(file, sep = ";")
X <- X[, 1:4]
file <- "~/Documents/vegsoup-data/exner2004/sites.csv"

# promote to class "Sites"
Y <- sites(read.csv2(file))

file <- "~/Documents/vegsoup-standards/austrian standard list 2008/austrian standard list 2008.csv"
# promote to class "SpeciesTaxonomy"
XZ <- SpeciesTaxonomy(X, file.y = file)
# promote to class "Vegsoup"
exner2004 <- Vegsoup(XZ, Y, coverscale = "braun.blanquet2")

save(exner2004, file = "~/Documents/vegsoup-data/exner2004/exner2004.rda")
rm(list = ls()[-grep("exner2004", ls(), fixed = TRUE)])