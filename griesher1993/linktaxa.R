library(linktaxa)
library(stringr)
#	Not run

#	match taxa
file <- "~/Documents/vegsoup-data/griesher1993/Griehser1993Tab1.txt"
con <- file(file)
x <- readLines(con)
close(con)

yy <- read.csv2("~/Documents/vegsoup-standards/austrian standard list 2008/austrian standard list 2008.csv", colClasses = "character")
y <- yy$taxon

#	NOT RUN:
if (FALSE) {
	x <- sapply(x, function (x) substring(x, 1, 36), USE.NAMES = FALSE)
	x <- x[18:(length(x) -1)]
	x <- str_trim(x)
	x[x == ""] <- "BLANK"

	xy <- linktaxa(x, y, order = FALSE)
#	edit results stored as taxon2standard.csv
	write.csv2(xy, "~/Documents/vegsoup-data/griesher1993/taxon2standard.csv")
#	read an join abbr
	x <- read.csv2("~/Documents/vegsoup-data/griesher1993/taxon2standard.csv",
		colClasses = "character")
	a <- yy$abbr[match(x$matched.taxon, y)]
	x$abbr <- a
#	saved to file
	write.csv2(x, "~/Documents/vegsoup-data/griesher1993/taxon2standard.csv",
	row.names = FALSE)

	#	footer species
	zz <- read.csv2("~/Documents/vegsoup-data/griesher1993/footer species.csv",
		colClasses = "character")
	x <- zz$taxon
	xy <- linktaxa(x, y, order = FALSE)
	#	edited results stored as taxon2standard footer species.csv
	write.csv2(xy, "~/Documents/vegsoup-data/griesher1993/taxon2standard footer species.csv")

	x <- read.csv2("~/Documents/vegsoup-data/griesher1993/taxon2standard footer species.csv",
		colClasses = "character")
	a <- yy$abbr[match(x$matched.taxon, y)]
	#	saved and pasted into table
	write.csv2(a, "~/Documents/vegsoup-data/griesher1993/tmp.csv")
}