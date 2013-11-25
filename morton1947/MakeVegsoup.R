library(vegsoup)

file <- "~/Documents/vegsoup-data/morton1947/species.csv"
# promote to class "Species"

X <- species(file, sep = ";")
X <- X[, 1:4]
file <- "~/Documents/vegsoup-data/morton1947/sites.csv"

# promote to class "Sites"
Y <- sites(read.csv2(file))

file <- "~/Documents/vegsoup-standards/austrian standard list 2008/austrian standard list 2008.csv"
# promote to class "SpeciesTaxonomy"
XZ <- SpeciesTaxonomy(X, file.y = file)
# promote to class "Vegsoup"
morton1947 <- Vegsoup(XZ, Y, coverscale = "braun.blanquet2")

save(morton1947, file = "~/Documents/vegsoup-data/schmiederer2002/morton1947.rda")
rm(list = ls()[-grep("morton1947", ls(), fixed = TRUE)])