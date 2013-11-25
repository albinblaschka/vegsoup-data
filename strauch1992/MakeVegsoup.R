library(vegsoup)

#setwd("~/Dropbox/vegsoup prj/strauch1992")

file <- "~/Documents/vegsoup-data/strauch1992/Strauch1992Tab2.txt"
l = c("hl", "sl", "tl")
x <- read.verbatim(file = file, colnames = "Aufnahme Nr.", layers = l)

file <- "~/Documents/vegsoup-data/strauch1992/Strauch1992Tab2FooterSpecies.txt"
x <- read.verbatim.append(x, file, "plots")

x.df <- data.frame(
	abbr = sapply(strsplit(rownames(x), "@"), "[", 1),
	layer = sapply(strsplit(rownames(x), "@"), "[", 2),
	comment = NA,
	x,
	check.names = FALSE)
X <- stack.species(x.df)
X <- X[, 1:4]

Y <- read.delim("~/Documents/vegsoup-data/strauch1992/Strauch1992Tab2Locations.txt",
	header = FALSE, colClasses = "character")
names(Y) <- c("plot", "location", "tms")

Y <- data.frame(Y, t(sapply(Y[,3], str2latlng, USE.NAMES = FALSE)))
Y <- stack.sites(Y)

file <- "~/Documents/vegsoup-standards/austrian standard list 2008/austrian standard list 2008.csv"
Z <- SpeciesTaxonomy(X, file.y = file)

strauch1992 <- Vegsoup(X, Y, Z, coverscale = "braun.blanquet2")

# assign header data stored as attributes in
# imported original community table
# omit dimnames, class and plot id

df.attr <- as.data.frame(attributes(x)[-c(1:3)])
rownames(df.attr) <- df.attr$Aufnahme.Nr
# reorder by plot
df.attr <- df.attr[match(rownames(strauch1992), rownames(df.attr)), ]
#	identical(rownames(strauch1992), rownames(df.attr))
# give names and assign
strauch1992$block <- as.character(df.attr$"Ausbildungen")
strauch1992$tcov <- df.attr$"Deck..BS"
strauch1992$scov <- df.attr$"Deck..SS"
strauch1992$hcov <- df.attr$"Deck..KS"
strauch1992$syntaxon <- "Stellario-Carpinetum Oberd. 1957"

Layers(strauch1992) <- c("tl", "sl", "hl")

rownames(strauch1992) <- paste("strauch1992", rownames(strauch1992), sep = ":")

save(strauch1992, file = "~/Documents/vegsoup-data/strauch1992/strauch1992.rda")

rm(list = ls()[-grep("strauch1992", ls())])