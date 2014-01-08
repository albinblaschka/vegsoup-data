library(vegsoup)

file <- "~/Documents/vegsoup-data/starzengruber1979/Starzengruber1979Tab1.txt"
l <- list(tl = c(1,20), sl = c(21,54), hl = c(55,178), ml = c(179,210))
x <- read.verbatim(file, colnames = "Laufende Nummer", layers = l)

yy <- attributes(x)	# attributes for later use

abbr <- unlist(lapply(strsplit(rownames(x), "@"), "[[", 1))
layer <- unlist(lapply(strsplit(rownames(x), "@"), "[[", 2))
x.df <- data.frame(abbr = abbr, layer = layer, comment = "", x,
	check.names = FALSE)
X <- stackSpecies(x.df)

#	sites data also including coordinates
file <- "~/Documents/vegsoup-data/starzengruber1979/Starzengruber1979Tab1Locations.txt"
Y <- read.delim(file, colClasses = "character")
names(Y)[1] <- "plot"

#	merge from attributes
Y$altitude <- yy$"Meereshöhe"
Y$expo <- yy$"Exposition"
Y$slope <- yy$"Hangneigung"
Y$htl1 <- yy$"Höhe max BS in m"
Y$hsl <- yy$"Höhe max SS in m"
Y$hhl1 <- yy$"Höhe max KS in cm"
Y$tcov1 <- yy$"Deckung BS"
Y$scov <- yy$"Deckung SS"
Y$hcov <- yy$"Deckung KS"
Y$mcov <- yy$"Deckung MS"
Y$pls <- yy$"Aufnahmefl. (m²x100)" * 100
Y <- stackSites(Y)

file <- "~/Documents/vegsoup-standards/austrian standard list 2008/austrian standard list 2008.csv"
# promote to class "SpeciesTaxonomy"
XZ <- SpeciesTaxonomy(X, file.y = file)

starzengruber1979 <- Vegsoup(XZ, Y, coverscale = "braun.blanquet2")

#	move rubus to herb layer
tmp <- Species(starzengruber1979)
tmp[tmp$abbr == "rubu.sect.rubu", ]$layer <- "hl"
tmp[tmp$abbr == "rubu.idae", ]$layer <- "hl"

starzengruber1979@species <- tmp

rownames(starzengruber1979) <- paste("starzengruber1979", rownames(starzengruber1979), sep = ":")
save(starzengruber1979, file = "~/Documents/vegsoup-data/starzengruber1979/starzengruber1979.rda")

rm(list = ls()[-grep("starzengruber1979", ls())])


