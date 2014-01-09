require(vegsoup)

file <- "~/Documents/vegsoup-data/eckkrammer2003/species wide 3.csv"
X0 <- stackSpecies(file = file, schema = c("abbr", "layer", "taxon"))[, 1:4]

file <- "~/Documents/vegsoup-data/eckkrammer2003/footer species 3.csv"
X1 <- read.csv2(file, colClasses = "character")
X1 <- X1[, -grep("taxon", names(X1))]
X1 <- species(X1)
X <- rbind(X0, X1)

#
file <- "~/Documents/vegsoup-data/eckkrammer2003/sites wide 3.csv"
Y <- stackSites(file = file)

file <- "~/Documents/vegsoup-standards/austrian standard list 2008/austrian standard list 2008.csv"
XZ <- SpeciesTaxonomy(x = X, file.y = file)

eckkrammer2003tab3 <- Vegsoup(XZ, Y, coverscale = "braun.blanquet2")

rm(list = ls()[-grep("eckkrammer2003", ls())])
