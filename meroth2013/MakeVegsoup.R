require(vegsoup)

file <- "~/Documents/vegsoup-data/meroth2013/species wide.csv"
X <- stack.species(file = file)[, 1:4]

file <- "~/Documents/vegsoup-data/meroth2013/sites wide.csv"
Y <- stackSites(file = file)

file <- "~/Documents/vegsoup-standards/austrian standard list 2008/austrian standard list 2008.csv"
XZ <- SpeciesTaxonomy(x = X, file.y = file)

meroth2013 <- Vegsoup(XZ, Y, coverscale = "braun.blanquet")

save(meroth2013, file = "~/Documents/vegsoup-data/meroth2013/meroth2013.rda")
rm(list = ls()[-grep("meroth2013", ls())])
