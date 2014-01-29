require(vegsoup)

###	NOT RUN
#	assign taxon abbreviations

if (FALSE) {
	file <- "~/Documents/vegsoup-data/griesher1993/Griehser1993Tab1.txt"
	con <- file(file)
	x <- readLines(con)
	close(con)
	
	xx <- read.csv2("~/Documents/vegsoup-data/griesher1993/taxon2standard.csv",
		stringsAsFactors = FALSE)	
	xx <- xx[!is.na(xx[,1]),]
	
	#	width: number of letters of taxon names 
	width = 36
	for (i in 1:nrow(xx)) {
		x <- gsub(xx[i, 1], format(xx[i, 3],
			width = width - (width - nchar(xx[i, 1])), justiy = "left"), x)	
	}
	
	#	save to disk
	file <- "~/Documents/vegsoup-data/griesher1993/Griehser1993Tab1taxon2standard.txt"
	con <- file(file)
	x <- writeLines(x, con)
	close(con)
	#	and add KEYWORDS
}

#	read prepared digitized table 
file <- "~/Documents/vegsoup-data/griesher1993/Griehser1993Tab1taxon2standard.txt"
x <- read.verbatim(file, "Aufnahmenummer", verbose = T)

# promote to class "Species"
x.df <- data.frame(abbr = rownames(x),
			layer = "hl",
			taxon = NA, x,
			check.names = FALSE)

X0 <- stackSpecies(x.df)
X0@data <- X0@data[, -5]

#	and footer taxa
file <- "~/Documents/vegsoup-data/griesher1993/footer species.csv"
X1 <- read.csv2(file, colClasses = "character")
X1 <- X1[, -grep("taxon", names(X1))]
X1 <- species(X1)
X <- rbind(X0, X1)

#   sites data including coordinates
file <- "~/Documents/vegsoup-data/griesher1993/Griehser1993Tab1Locations.csv"
Y <- read.csv2(file, colClasses = "character")
names(Y)[1] <- "plot"
# promote to class "Sites"
Y <- stackSites(Y)

# taxonomy reference list
file <- "~/Documents/vegsoup-standards/austrian standard list 2008/austrian standard list 2008.csv"
XZ <- SpeciesTaxonomy(X, file.y = file)

# promote to class "Vegsoup"
griesher1993 <- Vegsoup(XZ, Y, coverscale = "braun.blanquet2")


# assign header data stored as attributes in
# imported original community table
# omit dimnames, plot id (Releveé number) and class
df.attr <- as.data.frame(attributes(x)[- c(1:3, 9)])
rownames(df.attr) <- colnames(x)
# reorder by plot
df.attr <- df.attr[match(rownames(griesher1993), rownames(df.attr)), ] 

# give names and assign variables
griesher1993$elevation <- df.attr$"Höhe.über.dem.Meer.in.Meter"
griesher1993$expo <- as.character(df.attr$Exposition)
griesher1993$slope <- df.attr$"Neigung.in.Grad"
griesher1993$pls <- df.attr$"Groesse.in.Quadratmeter"
griesher1993$cov <- griesher1993$hcov <- df.attr$"Deckung.in.."
griesher1993$hcov <- griesher1993$hcov <- df.attr$"Deckung.in.."

rownames(griesher1993) <- paste0("griesher1993:",
	gsub(" ", "0", format(rownames(griesher1993), width = 2, justify = "right")))

griesher1993$syntaxon <- ""
griesher1993$syntaxon[1:7] <- "Caricetum firmae"
griesher1993$syntaxon[8:17] <- "Elynetum seslerietosum variae"

Sites(griesher1993)		
save(griesher1993, file = "~/Documents/vegsoup-data/springer1990/springer1990.rda")

rm(list = ls()[-grep("griesher1993", ls(), fixed = TRUE)])

#QuickMap(griesher1993)