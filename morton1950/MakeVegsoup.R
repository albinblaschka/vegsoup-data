library(vegsoup)

file <- "~/Documents/vegsoup-data/morton1950/species.csv"
# promote to class "Species"

X <- species(file, sep = ";")
X <- X[, 1:4]
file <- "~/Documents/vegsoup-data/morton1950/sites.csv"

# promote to class "Sites"
Y <- sites(read.csv2(file))

file <- "~/Documents/vegsoup-standards/austrian standard list 2008/austrian standard list 2008.csv"
# promote to class "SpeciesTaxonomy"
XZ <- SpeciesTaxonomy(X, file.y = file)
# promote to class "Vegsoup"
morton1950 <- Vegsoup(XZ, Y, coverscale = "braun.blanquet2")

save(morton1950, file = "~/Documents/vegsoup-data/morton1950/morton1950.rda")
rm(list = ls()[-grep("morton1950", ls(), fixed = TRUE)])