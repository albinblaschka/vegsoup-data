library(vegsoup)
require(bibtex)

path <- "~/Documents/vegsoup-data/dirnböck1997"
key <- read.bib(file.path(path, "references.bib"), encoding = "UTF-8")$key
key <- key[[1]]

file <- "~/Documents/vegsoup-data/dirnböck1997/Dirnböck1997Tab3.txt"
x <- read.verbatim(file, "Aufnahmenummer")
x <- data.frame(abbr = rownames(x),
	layer = "hl", x, check.names = FALSE)
# promote to class "Species"
X <- stackSpecies(x)

file <- "~/Documents/vegsoup-data/dirnböck1997/Dirnböck1997Tab3Locations.csv"
Y <- stackSites(file = file, sep = ";", schema = "Aufahmenummer")

file <- "~/Documents/vegsoup-standards/austrian standard list 2008/austrian standard list 2008.csv"
# promote to class "SpeciesTaxonomy"
XZ <- SpeciesTaxonomy(X, file.y = file)

#	build "Vegsoup" object
obj <- Vegsoup(XZ, Y, coverscale = "braun.blanquet2")
coordinates(obj) <- ~Längengrad+Breitengrad
proj4string(obj) <- CRS("+init=epsg:4326")

#	assign result object
assign(key, obj)

#	richness
obj$richness <- richness(obj, "sample")

#	save to disk
do.call("save", list(key, file = file.path(path, paste0(key, ".rda"))))
write.verbatim(obj, file.path(path, "transcript.txt"), sep = "", add.lines = TRUE)

if (FALSE) {
	decostand(obj) <- "pa"
	vegdist(obj) <- "bray"
	write.verbatim(seriation(obj), file.path(path, "seriation.txt"),
	sep = "", add.lines = TRUE)
	KML(obj)
}
#	tidy up
rm(list = ls()[-grep(key, ls())])
