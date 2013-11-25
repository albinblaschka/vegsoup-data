library(vegsoup)

file <- "~/Documents/vegsoup-data/niklfeld1964/species.csv"
# promote to class "Species"

X <- species(file, sep = ";")
X <- X[, 1:4]
file <- "~/Documents/vegsoup-data/niklfeld1964/sites.csv"

# promote to class "Sites"
Y <- sites(read.csv2(file))

file <- "~/Documents/vegsoup-standards/austrian standard list 2008/austrian standard list 2008.csv"
# promote to class "SpeciesTaxonomy"
XZ <- SpeciesTaxonomy(X, file.y = file)
# promote to class "Vegsoup"
niklfeld1964 <- Vegsoup(XZ, Y, coverscale = "braun.blanquet2")

save(niklfeld1964, file = "~/Documents/vegsoup-data/niklfeld1964/niklfeld1964.rda")
rm(list = ls()[-grep("niklfeld1964", ls(), fixed = TRUE)])