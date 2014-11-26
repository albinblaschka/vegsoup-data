require(vegsoup)
require(bibtex)
require(naturalsort)

path <- "~/Documents/vegsoup-data/griesher1993"
key <- read.bib(file.path(path, "references.bib"), encoding = "UTF-8")$key

#	main table
file <- file.path(path, "Griehser1993Tab1.txt")
x <- xx <- read.verbatim(file, colnames = "Aufnahmenummer")

a <- read.csv2(file.path(path, "translate.csv"),
		colClasses = "character")
a <- a$abbr[match(rownames(x), a$taxon)]

x <- data.frame(abbr = a, layer = "hl", x, check.names = FALSE, stringsAsFactors = FALSE)

x$layer[c(38,39,40,41,49)] <- "ml"
X <- stackSpecies(x)[, 1:4]

#	read prepared digitized table
file <- "~/Documents/vegsoup-data/griesher1993/Griehser1993Tab1FooterSpecies.csv"
x <- read.csv2(file, colClasses = "character")
x <- x[, -grep("taxon", names(x))]
XX <- species(x)
X <- rbind(X, XX)

#   sites data including coordinates
file <- "~/Documents/vegsoup-data/griesher1993/Griehser1993Tab1Locations.csv"
Y <- read.csv2(file, colClasses = "character")
names(Y)[1] <- "plot"
# promote to class "Sites"
Y <- stackSites(Y)

# taxonomy reference list
file <- "~/Documents/vegsoup-standards/austrian standard list 2008/austrian standard list 2008.csv"
XZ <- SpeciesTaxonomy(X, file.y = file)

# promote to class "Vegsoup"
obj <- Vegsoup(XZ, Y, coverscale = "braun.blanquet2")

# assign header data stored as attributes in
# imported original community table
# omit dimnames, plot id (Releveé number) and class
df.attr <- as.data.frame(attributes(xx)[- c(1:3, 9)])
rownames(df.attr) <- colnames(xx)
# reorder by plot
df.attr <- df.attr[match(rownames(obj), rownames(df.attr)), ] 

# give names and assign variables
obj$elevation <- df.attr$"Höhe.über.dem.Meer.in.Meter"
obj$expo <- as.character(df.attr$Exposition)
obj$slope <- df.attr$"Neigung.in.Grad"
obj$pls <- df.attr$"Groesse.in.Quadratmeter"
obj$cov <- obj$hcov <- df.attr$"Deckung.in.."
obj$hcov <- obj$hcov <- df.attr$"Deckung.in.."

rownames(obj) <- paste0(key, ":",
	gsub(" ", "0", format(rownames(obj), width = 2, justify = "right")))

obj <- obj[naturalorder(rownames(obj)), ]

obj$alliance <- ""
obj$association <- ""
obj$association[1:7] <- "Caricetum firmae"
obj$alliance[1:7] <- "Caricion firmae"
obj$association[8:17] <- "Elynetum seslerietosum variae"
obj$alliance[8:17] <- "Oxytropido-Elynion"

		
#	assign result object
assign(key, obj)

#	richness
obj$richness <- richness(obj, "sample")

#	save to disk
do.call("save", list(key, file = file.path(path, paste0(key, ".rda"))))
write.verbatim(obj, file.path(path, "transcript.txt"), sep = "", add.lines = TRUE)

#	tidy up
rm(list = ls()[-grep(key, ls())])
