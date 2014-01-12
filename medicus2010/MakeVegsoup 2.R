require(vegsoup)

file <- "~/Documents/vegsoup-data/medicus2010/species wide 2.csv"
X <- stackSpecies(file = file, schema = c("abbr", "layer", "taxon"))[, 1:4]

#
file <- "~/Documents/vegsoup-data/medicus2010/sites wide 2.csv"
Y <- stackSites(file = file)

file <- "~/Documents/vegsoup-standards/austrian standard list 2008/austrian standard list 2008.csv"
XZ <- SpeciesTaxonomy(x = X, file.y = file)

medicus2010tab2 <- Vegsoup(XZ, Y, coverscale = "braun.blanquet")

rm(list = ls()[-grep("medicus2010", ls())])
