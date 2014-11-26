library(vegsoup)
require(bibtex)

path <- "~/Documents/vegsoup-data/pils1994"
key <- read.bib(file.path(path, "references.bib"), encoding = "UTF-8")$key

#	read prepared digitized table 
file <- "~/Documents/vegsoup-data/pils1994/Pils1994Tab8taxon2standard.txt"
l <- rep("hl", times = 155)
l[c(101, 102, 125, 126, 131)] <- "ml"

x <- read.verbatim(file, "Aufnahmenummer", verbose = T, layers = l)
X0 <- species(x)[, -5]

#	and footer taxa
file <- "~/Documents/vegsoup-data/pils1994/Pils1994Tab8FooterSpecies.csv"
X1 <- read.csv2(file, colClasses = "character")
X1 <- X1[, -grep("taxon", names(X1))]
X1 <- species(X1)
X <- rbind(X0, X1)

#   sites data including coordinates
file <- "~/Documents/vegsoup-data/pils1994/Pils1994Tab8Locations.csv"
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
df.attr <- header(x)

# reorder by plot
df.attr <- df.attr[match(rownames(obj), rownames(df.attr)), ] 

# give names and assign variables
obj$elevation <- df.attr$"Seehöhe.in.10.m" * 10
obj$expo <- as.character(df.attr$Exposition)
obj$slope <- df.attr$"Neigung.in.Grad"
obj$pls <- df.attr$"Aufnahmefläche.in.10.qm" * 10
obj$cov <- obj$cov <- df.attr$"Deckung.in.."

#	assign result object
assign(key, obj)

#	richness
obj$richness <- richness(obj, "sample")

#	save to disk
do.call("save", list(key, file = file.path(path, paste0(key, ".rda"))))
write.verbatim(obj, file.path(path, "transcript.txt"), sep = "", add.lines = TRUE)

#	tidy up
rm(list = ls()[-grep(key, ls())])
