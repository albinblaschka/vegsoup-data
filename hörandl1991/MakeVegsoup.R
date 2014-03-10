require(vegsoup)
require(naturalsort)

#	read prepared digitized table
file <- "~/Documents/vegsoup-data/wittmann1997/Wittmann1997Tab1taxon2standard.txt"
x <- read.verbatim(file, "Aufnahmenummer", layers = "@")
# promote to class "Species"
X <- species(x)

#   sites data including coordinates
file <- "~/Documents/vegsoup-data/wittmann1997/Wittmann1997Tab1Locations.csv"
Y <- read.csv2(file, colClasses = "character")
# promote to class "Sites"
Y <- stackSites(Y)

# taxonomy reference list
file <- "~/Documents/vegsoup-standards/austrian standard list 2008/austrian standard list 2008.csv"
XZ <- SpeciesTaxonomy(X, file.y = file)

# promote to class "Vegsoup"
wittmann1997 <- Vegsoup(XZ, Y, coverscale = "braun.blanquet2")

# assign plot names	
rownames(wittmann1997) <- paste0("wittmann1997:",
	sprintf("%02d", as.numeric(rownames(wittmann1997))))

wittmann1997 <- wittmann1997[naturalorder(rownames(wittmann1997)), ]

#	syntaxa assigment missing
wittmann1997$syntaxon <- ""
		
save(wittmann1997, file = "~/Documents/vegsoup-data/wittmann1997/wittmann1997.rda")

rm(list = ls()[-grep("wittmann1997", ls(), fixed = TRUE)])

#QuickMap(wittmann1997)