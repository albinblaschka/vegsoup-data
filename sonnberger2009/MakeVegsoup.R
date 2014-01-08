require(vegsoup)

file <- "~/Documents/vegsoup-data/sonnberger2009/species wide.csv"
X <- stackSpecies(file = file)[, 1:4]

file <- "~/Documents/vegsoup-data/sonnberger2009/sites wide.csv"
Y <- stackSites(file = file)

file <- "~/Documents/vegsoup-standards/austrian standard list 2008/austrian standard list 2008.csv"
XZ <- SpeciesTaxonomy(x = X, file.y = file)

sonnberger2009 <- Vegsoup(XZ, Y, coverscale = "braun.blanquet")
QuickMap(sonnberger2009)

save(sonnberger2009, file = "~/Documents/vegsoup-data/sonnberger2009/sonnberger2009.rda")
rm(list = ls()[-grep("sonnberger2009", ls())])
