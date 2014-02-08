require(vegsoup)

#	read prepared digitized table 
file <- "~/Documents/vegsoup-data/roithinger1996/Roithinger1996TabAtaxon2standard.txt"
l <- rep("hl", times = 159)
l[3] <- "sl"
x <- read.verbatim(file, "Aufnahmenummer", verbose = T, layers = l)

# promote to class "Species"
x.df <- data.frame(abbr = rownames(x),
			layer = NA,
			taxon = NA, x,
			check.names = FALSE, stringsAsFactors = FALSE)
tmp <- strsplit(as.character(x.df$abbr), "@")			
x.df$abbr <- sapply(tmp, "[[", 1)		
x.df$layer <- sapply(tmp, "[[", 2)

X0 <- stackSpecies(x.df)
X0@data <- X0@data[, -5]

#	and footer taxa
file <- "~/Documents/vegsoup-data/roithinger1996/Roithinger1996TabAFooterSpecies.csv"
X1 <- read.csv2(file, colClasses = "character")
X1 <- X1[, -grep("taxon", names(X1))]
X1 <- species(X1)
X <- rbind(X0, X1)

#   sites data including coordinates
file <- "~/Documents/vegsoup-data/roithinger1996/Roithinger1996TabALocations.csv"
Y <- read.csv2(file, colClasses = "character")
names(Y)[1] <- "plot"
# promote to class "Sites"
Y <- stackSites(Y)

# taxonomy reference list
file <- "~/Documents/vegsoup-standards/austrian standard list 2008/austrian standard list 2008.csv"
XZ <- SpeciesTaxonomy(X, file.y = file)

# promote to class "Vegsoup"
roithinger1996 <- Vegsoup(XZ, Y, coverscale = "braun.blanquet2")


# assign header data stored as attributes in
# imported original community table
# omit dimnames, plot id (Releveé number) and class
df.attr <- as.data.frame(attributes(x)[- c(1:3, length(attributes(x)))])
rownames(df.attr) <- colnames(x)
# reorder by plot
df.attr <- df.attr[match(rownames(roithinger1996), rownames(df.attr)), ] 

# give names and assign variables
roithinger1996$elevation <- df.attr$"Meereshöhe.in.m"
roithinger1996$expo <- as.character(df.attr$Exposition)
roithinger1996$slope <- df.attr$"Inklination.in.Grad"
roithinger1996$pls <- df.attr$"Größe.der.Aufnahmefläche.in.m2"
roithinger1996$cov <- roithinger1996$cov <- df.attr$"Gesamtdeckung.in.."
roithinger1996$hcov <- roithinger1996$hhl <- df.attr$"Höhe.der.Vegetationsdecke.in.cm"
names(roithinger1996)[3] <- "scov"
names(roithinger1996)[4] <- "hsl"
names(roithinger1996)[5] <- "zcov"
names(roithinger1996)[6] <- "hzl"
names(roithinger1996)[7] <- "mcov"

rownames(roithinger1996) <- paste0("roithinger1996:",
	gsub(" ", "0", format(rownames(roithinger1996), width = 2, justify = "right")))
require(naturalsort)
roithinger1996 <- roithinger1996[naturalorder(rownames(roithinger1996)), ]

#	syntaxa assigment missing
roithinger1996$syntaxon <- ""
		
save(roithinger1996, file = "~/Documents/vegsoup-data/roithinger1996/roithinger1996.rda")

rm(list = ls()[-grep("roithinger1996", ls(), fixed = TRUE)])

#QuickMap(roithinger1996)