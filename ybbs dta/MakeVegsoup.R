library(vegsoup)

file <- "~/Documents/vegsoup-data/ybbs dta/species wide fer.csv"
X1 <- stackSpecies(file = file)

file <- "~/Documents/vegsoup-data/ybbs dta/species wide leu.csv"
X2 <- stackSpecies(file = file)

file <- "~/Documents/vegsoup-data/ybbs dta/species wide mat.csv"
X3 <- stackSpecies(file = file)

X <- rbind(X1, X2, X3)[, c(1:4)]

file <- "~/Documents/vegsoup-data/ybbs dta/sites wide.csv"
Y <- stackSites(file = file)

file <- "~/Documents/vegsoup-standards/austrian standard list 2008/austrian standard list 2008.csv"
XZ <- SpeciesTaxonomy(x = X, file.y = file)

yb <- Vegsoup(XZ, Y, coverscale = "braun.blanquet")

Layers(yb) <- c("tl1", "tl2", "sl", "hl")

save(yb, file = "~/Documents/vegsoup-data/ybbs dta/ybbs.rda")