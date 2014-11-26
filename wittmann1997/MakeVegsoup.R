library(vegsoup)
require(bibtex)

path <- "~/Documents/vegsoup-data/wittmann1997"
key <- read.bib(file.path(path, "references.bib"), encoding = "UTF-8")$key

#	read prepared digitized table
file <- file.path(path, "Wittmann1997Tab1taxon2standard.txt")
x <- read.verbatim(file, colnames = "Aufnahmenummer", layers = "@")
#	promote to class "Species"
X <- species(x)

#   sites data including coordinates
file <- file.path(path, "Wittmann1997Tab1Locations.csv")
#	promote to class "Sites"
Y <- stackSites(file = file)

#	taxonomy reference list
file <- "~/Documents/vegsoup-standards/austrian standard list 2008/austrian standard list 2008.csv"
XZ <- SpeciesTaxonomy(X, file.y = file)

#	promote to class "Vegsoup"
obj <- Vegsoup(XZ, Y, coverscale = "braun.blanquet2")

#	syntaxa assigment missing
obj$alliance <- "Nanocyperion"

#	unique rownames
rownames(obj) <- paste(key, "Tab1", sprintf("%02d", as.numeric(rownames(obj))), sep = ":")
		
#	assign result object
assign(key, obj)

#	richness
obj$richness <- richness(obj, "sample")

#	save to disk
do.call("save", list(key, file = file.path(path, paste0(key, ".rda"))))
write.verbatim(obj, file.path(path, "transcript.txt"), sep = "",
	add.lines = TRUE, table.nr = TRUE)

#	tidy up
rm(list = ls()[-grep(key, ls())])