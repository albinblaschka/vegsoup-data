require(vegsoup)

###	Not run
if (FALSE) {
#	assign taxon abbreviations
file <- "~/Documents/vegsoup-data/springer1990/Springer1990Tab5.txt"
con <- file(file)
x <- readLines(con)
close(con)

xx <- read.csv2("~/Documents/vegsoup-data/springer1990/taxon2standard.csv",
	stringsAsFactors = FALSE)	
xx <- xx[!is.na(xx[,1]),]

#	width: number of letters of taxon names 
width = 33

for (i in 1:nrow(xx)) {
	x <- gsub(xx[i, 1], format(xx[i, 3],
		width = width - (width - nchar(xx[i, 1])), justiy = "left"), x)	
}

#	save to disk
file <- "~/Documents/vegsoup-data/springer1990/Springer1990Tab5taxon2standard.txt"
con <- file(file)
x <- writeLines(x, con)
close(con)
#	and add KEYWORDS
}

#	read digitized table 
file <- "~/Documents/vegsoup-data/springer1990/Springer1990Tab5taxon2standard.txt"
x <- read.verbatim(file, "Releveé number", verbose = T)

# promote to class "Species"
x.df <- data.frame(abbr = rownames(x),
			layer = "hl",
			taxon = NA, x,
			check.names = FALSE)

X <- stackSpecies(x.df)

#   sites data including coordinates
file <- "~/Documents/vegsoup-data/springer1990/Springer1990Tab5Locations.csv"
Y <- read.csv2(file, colClasses = "character")
names(Y)[1] <- "plot"
# promote to class "Sites"
Y <- stackSites(Y)

# taxonomy reference list
file <- "~/Documents/vegsoup-standards/austrian standard list 2008/austrian standard list 2008.csv"
XZ <- SpeciesTaxonomy(X, file.y = file)

# promote to class "Vegsoup"
springer1990 <- Vegsoup(XZ, Y, coverscale = "braun.blanquet2")


# assign header data stored as attributes in
# imported original community table
# omit dimnames, plot id (Releveé number) and class
df.attr <- as.data.frame(attributes(x)[- c(1:3, 8)])
rownames(df.attr) <- colnames(x)
# reorder by plot
df.attr <- df.attr[match(rownames(springer1990), rownames(df.attr)), ] 

# give names and assign variables
springer1990$elevation <- df.attr$"Höhe"
springer1990$expo <- as.character(df.attr$Exposition)
springer1990$slope <- df.attr$"Inklination"
springer1990$cov <- springer1990$hcov <- df.attr$"Deckungsgrad.."
springer1990$hcov <- springer1990$hcov <- df.attr$"Deckungsgrad.."

rownames(springer1990) <- paste0("springer1990:",
	gsub(" ", "0", format(rownames(springer1990), width = 2, justify = "right")))

Sites(springer1990)
springer1990$syntaxon <- "Juncus trlfidus-Primula mlnima-Gesel1schaft"		
save(springer1990, file = "~/Documents/vegsoup-data/springer1990/springer1990.rda")

rm(list = ls()[-grep("springer1990", ls(), fixed = TRUE)])

#QuickMap(springer1990)