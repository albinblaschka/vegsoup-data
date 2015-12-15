require(vegsoup)
require(bibtex)

path <- "~/Documents/vegsoup-data/erschbamer1992"
key <- read.bib(file.path(path, "references.bib"), encoding = "UTF-8")$key

<<<<<<< HEAD
file <- file.path(path, "Erschbamer1992Tab4.txt")

# read digitized table
x1 <- read.verbatim(file, colnames = "Aufnahme Nr.")

# extract header (sites) data from VegsoupVerbatim object
y1 <- header(x1)
# translate and groome names
names(y1) <- c("altitude", "aspect", "slope", "cover", "pH", "block")
# promote to Sites object	
y1$plot <- rownames(y1) # header returns plot names as rownames 
y1 <- stackSites(y1, schema = "plot")
y1

# promote table body to Species object
x1 <- species(x1)
richness(x1)

# get species from table footer
# a listing of species not covered by the main table and plot where they occur in
# the source does not supply any abundance values, we assume '+'
file <- file.path(path, "Erschbamer1992Tab4Tablefooter.txt")
x2 <- castFooter(file, species.first = TRUE, abundance.first = NA,
                 abundance = "+")
x2$plot <- sprintf("%03d", as.numeric(x2$plot))
richness(x2)
# bind species in table footer with main table
X <- bind(x1, x2)
X
richness(X)

#   additional sites data including coordinates as a tab delimited file
file <- file.path(path, "Erschbamer1992Tab4Locations.txt")
y2 <- read.delim(file, colClasses = "character")
head(y2)
# add leading zeros
y2$nr <- sprintf("%03d", as.numeric(y2$nr))
# promote to class "Sites"
y2 <- stackSites(y2, schema = "nr")
y2

#	bind with sites data from table header
Y <- bind(y1, y2)

# taxonomy reference list
file <- "~/Documents/vegsoup-standards/austrian standard list 2008/austrian standard list 2008.csv"
Z <- taxonomy(Z)

# groome abundance scale codes to fit the standard
# of the extended Braun-Blanquet scale used in the origional publication
X$cov <- gsub("m", "2m", X$cov)
X$cov <- gsub("a", "2a", X$cov)
X$cov <- gsub("b", "2b", X$cov)

# promote to class "Vegsoup"
obj <- Vegsoup(X, Y, Z, coverscale = "braun.blanquet")
=======
#	read digitized table 
file <- "~/Documents/vegsoup-data/Erschbamer1992/Erschbamer1992Tab4.txt"
x <- read.verbatim(file, "Aufnahme Nr.", verbose = T)

# add species from table footer
file <- "~/Documents/vegsoup-data/Erschbamer1992/Erschbamer1992Tab4Tablefooter.txt"
x <- read.verbatim.append(x, file, mode = "species")

# turn into long format
l <- rep("hl", nrow(x))
l[c(10:13, 52, 65, 94, 96, 100, 112, 114, 121, 126, 143, 150)] <- "ml"

x.df <- data.frame(abbr = rownames(x),
			layer = l,
			comment = NA, x,
			check.names = FALSE)
# promote to class "Species"
X <- stackSpecies(x.df)
# groome abundance scale codes to fit the standard
# of the extended Braun-Blanquet scale used in the original publication
X$cov <- gsub("m", "2m", X$cov)
X$cov <- gsub("a", "2a", X$cov)
X$cov <- gsub("b", "2b", X$cov)

#   sites data including coordinates
file <- "~/Documents/vegsoup-data/Erschbamer1992/Erschbamer1992Tab4Locations.txt"
Y <- read.delim(file, colClasses = "character")
names(Y)[1] <- "plot"
# promote to class "Sites"
Y <- stackSites(Y)

# taxonomy reference list
file <- "~/Documents/vegsoup-standards/austrian standard list 2008/austrian standard list 2008.csv"
XZ <- SpeciesTaxonomy(X, file.y = file)

# promote to class "Vegsoup"
obj <- Vegsoup(XZ, Y, coverscale = "braun.blanquet")

# assign header data stored as attributes in
# imported original community table
# omit dimnames, class and plot id
df.attr <- as.data.frame(attributes(x)[-c(1:4)])
rownames(df.attr) <- colnames(x)
# reorder by plot
df.attr <- df.attr[match(rownames(obj), rownames(df.attr)), ] 

# give names and assign sites variables
obj$block <- df.attr$Block
obj$altitude <- df.attr$Seehöhe
obj$expo <- df.attr$Exposition
obj$cov <- df.attr$"Deckung...."
obj$ph <- df.attr$"ph...10.2."
>>>>>>> refs/remotes/kardinal-eros/master

#	unique rownames
rownames(obj) <- paste(key, "Tab4", sprintf("%03d", as.numeric(rownames(obj))), sep = ":")	
#	assign result object
assign(key, obj)

#	richness
obj$richness <- richness(obj, "sample")

#	save to disk
do.call("save", list(key, file = file.path(path, paste0(key, ".rda"))))
write.verbatim(obj, file.path(path, "transcript.txt"), sep = "",
	add.lines = TRUE, table.nr = TRUE)

#	tidy up
rm(list = ls()[-grep(key, ls())])