require(vegsoup)
require(bibtex)

path <- "~/Documents/vegsoup-data/franz2000"
key <- read.bib(file.path(path, "references.bib"), encoding = "UTF-8")$key

#	main table
file <- file.path(path, "Franz2000Tab1.txt")
x <- read.verbatim(file, colnames = "Laufende Nr.")

a <- read.csv2(file.path(path, "translate.csv"),
		colClasses = "character")
a <- a$abbr[match(rownames(x), a$taxon)]

x <- data.frame(abbr = a, layer = "hl", x, check.names = FALSE, stringsAsFactors = FALSE)
x$layer[30:nrow(x)] <- "ml"
X <- stackSpecies(x)[, 1:4]

#	additional species
file <- file.path(path, "Franz2000Tab1FooterSpecies.txt")
x <- data.frame(castFooter(file, first = FALSE))

a <- read.csv2(file.path(path, "translate footer species.csv"),
		colClasses = "character")
a <- a$abbr[match(x$taxon, a$taxon)]
x <- data.frame(plot = x$plot, abbr = a, layer = "hl", cov = x$cov, stringsAsFactors = FALSE)
x$layer[c(1,2,10,17,23:26)] <- "ml"
XX <- species(x)

X <- rbind(X, XX)

#	sites
file <- file.path(path, "Franz2000Tab1Locations.csv")
Y <- stackSites(file = file, schema = "Laufende Nr.")

file <- "~/Documents/vegsoup-standards/austrian standard list 2008/austrian standard list 2008.csv"
#	promote to class "SpeciesTaxonomy"
XZ <- SpeciesTaxonomy(X, file.y = file)

#	build "Vegsoup" object
obj <- Vegsoup(XZ, Y, coverscale = "braun.blanquet2")

#	order layer
Layers(obj)	 <- c("hl", "ml")

#	
obj$alliance <- "Loiseleurio-Vaccinion"
obj$association <- "Carici bigelowii-Loiseleurietum procumbentis"

#	assign result object
assign(key, obj)

#	richness
obj$richness <- richness(obj, "sample")

#	save to disk
do.call("save", list(key, file = file.path(path, paste0(key, ".rda"))))
write.verbatim(obj, file.path(path, "transcript.txt"), sep = "", add.lines = TRUE)

#	tidy up
rm(list = ls()[-grep(key, ls())])
