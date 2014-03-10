library(vegit)
library(linktaxa)

setwd("~/Documents/vegsoup-data/hörandl1991")
#	match taxa
file <- "Hörandl1991Tab1"
x <- readLines(paste0(file, ".txt"))

z <- read.csv2("~/Documents/vegsoup-standards/austrian standard list 2008/austrian standard list 2008.csv", colClasses = "character")

#	NOT RUN:
if (FALSE) {
	x <- extractTaxon(x, row = 18, col = 36)
	y <- linktaxa(x, z$taxon, order = FALSE, file = "taxon2standard.csv")
	
	#	store results for editing
	write.csv2(y, , row.names = FALSE)	
	
	#	read edits
	y <- read.csv2("taxon2standard.csv", colClasses = "character")
	
	#	replace and save to file with suffix
	r <- replaceTaxon(x, y, z, col = 38, row = 4,
		overwrite = TRUE, keywords = TRUE,
		file = paste0(file, "taxon2standard.txt"))
}