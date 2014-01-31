require(vegsoup)

#	read digitized table 
file <- "~/Documents/vegsoup-data/Petrik2005/Petrik2005Tab1taxon2standard.txt"
x <- read.verbatim(file, "Releveé number", verbose = T)

#	assign moss layers
l <- rep("hl", nrow(x))
l[c(3,40, 42,43,70,71,74,97:174)] <- "ml"


# promote to class "Species"
x.df <- data.frame(abbr = rownames(x),
			layer = "hl",
			taxon = NA, x,
			check.names = FALSE)
X <- stackSpecies(x.df)
# groome abundance scale codes to fit the standard
# of the extended Braun-Blanquet scale used in the original publication
X$cov <- gsub("m", "2m", X$cov)
X$cov <- gsub("a", "2a", X$cov)
X$cov <- gsub("b", "2b", X$cov)

#   sites data including coordinates
file <- "~/Documents/vegsoup-data/Petrik2005/Petrik2005Tab1TLocations.csv"
Y <- read.csv2(file, colClasses = "character")
names(Y)[1] <- "plot"
# promote to class "Sites"
Y <- stackSites(Y)

# taxonomy reference list
file <- "~/Documents/vegsoup-standards/austrian standard list 2008/austrian standard list 2008.csv"
XZ <- SpeciesTaxonomy(X, file.y = file)

# promote to class "Vegsoup"
Petrik2005 <- Vegsoup(XZ, Y, coverscale = "braun.blanquet")
#	grome names
names(Petrik2005)[1:9] <- c("pls", "expo", "slope", "elevation",
	"hcov", "mcov", "cov", "bedrock", "date")
Petrik2005$syntaxon <- "Oxytropido carpaticae-Elynetum"		
save(Petrik2005, file = "~/Documents/vegsoup-data/Petrik2005/Petrik2005.rda")

rm(list = ls()[-grep("Petrik2005", ls(), fixed = TRUE)])

#QuickMap(Petrik2005)