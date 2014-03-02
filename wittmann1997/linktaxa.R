library(linktaxa)

setwd("~/Documents/vegsoup-data/wittmann1997")
#	match taxa
file <- "Wittmann1997Tab1"
x <- readLines(paste0(file, ".txt"))

z <- read.csv2("~/Documents/vegsoup-standards/austrian standard list 2008/austrian standard list 2008.csv", colClasses = "character")

#	NOT RUN:
if (FALSE) {
	x <- extractTaxon(x, n = c(row = 4, column = 38))
	y <- linktaxa(x, z$taxon, order = FALSE)
	#	store results for editing
	write.csv2(y, "taxon2standard.csv", row.names = FALSE)	
	#	read edits
	y <- read.csv2("taxon2standard.csv", colClasses = "character")

	r <- replaceTaxon(x, y, z, where = 38)
	writeLines(r, paste0(file, "taxon2standard.txt"))
}