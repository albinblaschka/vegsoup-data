library(vegsoup)
require(bibtex)

path <- "~/Documents/vegsoup-data/niklfeld1964"
key <- read.bib(file.path(path, "references.bib"), encoding = "UTF-8")$key

file <- file.path(path, "species.csv")
#	promote to class "Species"
X <- species(file, sep = ";")
X <- X[, 1:4]

file <- file.path(path, "sites.csv")
#	promote to class "Sites"
Y <- sites(file, sep = ";")

file <- "~/Documents/vegsoup-standards/austrian standard list 2008/austrian standard list 2008.csv"
#	promote to class "SpeciesTaxonomy"
XZ <- SpeciesTaxonomy(X, file.y = file)

#	build "Vegsoup" object
obj <- Vegsoup(XZ, Y, coverscale = "braun.blanquet2")

#	order layer
layers(obj)	 <- c("hl", "ml")

#	unique rownames
rownames(obj) <- paste(key, rownames(obj), sep = ":")

#	assign result object
assign(key, obj)

#	richness
obj$richness <- richness(obj, "sample")

#	save to disk
do.call("save", list(key, file = file.path(path, paste0(key, ".rda"))))
write.verbatim(obj, file.path(path, "transcript.txt"), sep = "", add.lines = TRUE)

#	tidy up
rm(list = ls()[-grep(key, ls())])
