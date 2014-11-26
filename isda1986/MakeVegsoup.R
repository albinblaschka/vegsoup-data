library(vegsoup)
require(bibtex)

path <- "~/Documents/vegsoup-data/isda1986"
key <- read.bib(file.path(path, "references.bib"), encoding = "UTF-8")$key

file <- "~/Documents/vegsoup-data/isda1986/Isda1986Tab1.txt"
x <- read.verbatim(file, "Aufnahmenummer")

file <- "~/Documents/vegsoup-data/isda1986/Isda1986Tab1TableFooter.txt"
x <- read.verbatim.append(x, file, "plots", abundance = TRUE)

x.df <- data.frame(abbr = rownames(x), layer = "hl", taxon = NA, x,
	check.names = FALSE)
X <- stackSpecies(x.df)

Y <- read.delim("~/Documents/vegsoup-data/isda1986/Isda1986Tab1Locations.txt",
	header = FALSE, colClasses = "character")
names(Y) <- c("plot", "location.short", "location", "tms")
Y$plot <- type.convert(Y$plot)	

Y <- data.frame(Y, t(sapply(Y[,4], str2latlng, USE.NAMES = FALSE)))
Y <- stackSites(Y)

file <- "~/Documents/vegsoup-standards/austrian standard list 2008/austrian standard list 2008.csv"
Z <- SpeciesTaxonomy(X, file.y = file)

obj <- Vegsoup(X, Y, Z, coverscale = "braun.blanquet2")

# assign header data stored as attributes in
# imported original community table
# omit dimnames, class and plot id

df.attr <- as.data.frame(attributes(x)[-c(1:3)])
rownames(df.attr) <- colnames(x)
# reorder by plot
df.attr <- df.attr[match(rownames(obj), rownames(df.attr)), ]
# give names and assign
obj$block <- df.attr$"block"
obj$ph <- as.character(df.attr$"pH..10..1.")
obj$ph[obj$ph == ".."] <- 0
obj$ph <- as.numeric(obj$ph) /10
obj$expo <- toupper(gsub("[[:punct:]]", "", as.character(df.attr$Exposition)))
obj$slope <- df.attr$Hangneigung
obj$elevation <- df.attr$"Seehöhe...100." * 100
obj$block <- df.attr$Block
obj$altitude <- df.attr$Seehöhe

#	assign result object
assign(key, obj)

#	richness
obj$richness <- richness(obj, "sample")

#	save to disk
do.call("save", list(key, file = file.path(path, paste0(key, ".rda"))))
write.verbatim(obj, file.path(path, "transcript.txt"), sep = "", add.lines = TRUE)

#	tidy up
rm(list = ls()[-grep(key, ls())])
