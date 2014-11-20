require(vegsoup)
require(bibtex)

path <- "~/Documents/vegsoup-data/wittmann2007"
source(file.path(path, "MakeVegsoup1.R"))
source(file.path(path, "MakeVegsoup2.R"))

key <- read.bib(file.path(path, "references.bib"), encoding = "UTF-8")$key

#	bind data sets
obj <- bind(Wittmann2007Tab1, Wittmann2007Tab2)

#	assign result object
assign(key, obj)

do.call("save", list(key, file = file.path(path, paste0(key, ".rda"))))

#	save to disk
write.verbatim(obj, file.path(path, "transcript2.txt"), sep = "", add.lines = TRUE)

rm(list = ls()[-grep(key, ls())])
rm(Wittmann2007Tab1, Wittmann2007Tab2)