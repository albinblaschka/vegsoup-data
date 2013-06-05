library(vegsoup)
file <- "~/Dropbox/vegsoup prj/dirnböck1997/Dirnböck1997Tab3.txt"
x <- read.verbatim(file, "Aufnahmenummer")
x.df <- data.frame(abbr = rownames(x),
	layer = "hl", comment = NA, x,	check.names = FALSE)
# promote to class "Species"
X <- stack.species(x.df)

file <- "~/Dropbox/vegsoup prj/Dirnböck1997/Dirnböck1997Tab3Locations.txt"
Y <- read.delim(file, colClasses = "character")
names(Y)[1] <- "plot"
names(Y)[grep("Längengrad", names(Y))] <- "longitude"
names(Y)[grep("Breitengrad", names(Y))] <- "latitude"

# promote to class "Sites"
Y <- stack.sites(Y)

file <- "~/Documents/vegsoup-standards/austrian standard list 2008/austrian standard list 2008.csv"
# promote to class "SpeciesTaxonomy"
XZ <- SpeciesTaxonomy(X, file.y = file)
# promote to class "Vegsoup"
rx <- Vegsoup(XZ, Y, coverscale = "braun.blanquet2")
