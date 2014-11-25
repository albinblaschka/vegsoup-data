library(vegsoup)
library(bibtex)

path <- "~/Documents/vegsoup-data/eckkrammer2003"
key <- read.bib(file.path(path, "references.bib"), encoding = "UTF-8")$key
key <- key[[1]]


source("~/Documents/vegsoup-data/eckkrammer2003/MakeVegsoup 1.R")
source("~/Documents/vegsoup-data/eckkrammer2003/MakeVegsoup 2.R")
source("~/Documents/vegsoup-data/eckkrammer2003/MakeVegsoup 3.R")

obj <- bind(tab1, tab2, tab3)

#	order layer
Layers(obj)	 <- c("sl", "hl", "ml")

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
