library(vegsoup)
require(bibtex)

path <- "~/Documents/vegsoup-data/javakheti dta"
key <- read.bib(file.path(path, "references.bib"), encoding = "UTF-8")$key

file <- "~/Documents/vegsoup-data/javakheti dta/species.csv"
# promote to class "Species"
X <- species(file, sep = ";")
X <- X[, 1:4]

file <- "~/Documents/vegsoup-data/javakheti dta/sites.csv"
# promote to class "Sites"
Y <- sites(read.csv2(file))

file <- "~/Documents/vegsoup-data/javakheti dta/taxonomy.csv"
# promote to class "SpeciesTaxonomy"
XZ <- SpeciesTaxonomy(X, file.y = file)
# promote to class "Vegsoup"
obj <- Vegsoup(XZ, Y, coverscale = "braun.blanquet")

#	assign result object
assign(key, obj)

#	richness
obj$richness <- richness(obj, "sample")

#	save to disk
do.call("save", list(key, file = file.path(path, paste0(key, ".rda"))))
write.verbatim(obj, file.path(path, "transcript.txt"), sep = "", add.lines = TRUE)

#	tidy up
rm(list = ls()[-grep(key, ls())])
