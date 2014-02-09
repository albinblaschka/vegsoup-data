require(vegsoup)

#	read prepared digitized table 
file <- "~/Documents/vegsoup-data/pils1994/Pils1994Tab8taxon2standard.txt"
l <- rep("hl", times = 155)
l[c(101, 102, 125, 126, 131)] <- "ml"

x <- read.verbatim(file, "Aufnahmenummer", verbose = T, layers = l)
X0 <- species(x)[, -5]

#	and footer taxa
file <- "~/Documents/vegsoup-data/pils1994/Pils1994Tab8FooterSpecies.csv"
X1 <- read.csv2(file, colClasses = "character")
X1 <- X1[, -grep("taxon", names(X1))]
X1 <- species(X1)
X <- rbind(X0, X1)

#   sites data including coordinates
file <- "~/Documents/vegsoup-data/pils1994/Pils1994Tab8Locations.csv"
Y <- read.csv2(file, colClasses = "character")
names(Y)[1] <- "plot"
# promote to class "Sites"
Y <- stackSites(Y)

# taxonomy reference list
file <- "~/Documents/vegsoup-standards/austrian standard list 2008/austrian standard list 2008.csv"
XZ <- SpeciesTaxonomy(X, file.y = file)

# promote to class "Vegsoup"
pils1994 <- Vegsoup(XZ, Y, coverscale = "braun.blanquet2")
Sites(pils1994)

# assign header data stored as attributes in
# imported original community table
# omit dimnames, plot id (Releveé number) and class
df.attr <- header(x)

# reorder by plot
df.attr <- df.attr[match(rownames(pils1994), rownames(df.attr)), ] 

# give names and assign variables
pils1994$elevation <- df.attr$"Seehöhe.in.10.m" * 10
pils1994$expo <- as.character(df.attr$Exposition)
pils1994$slope <- df.attr$"Neigung.in.Grad"
pils1994$pls <- df.attr$"Aufnahmefläche.in.10.qm" * 10
pils1994$cov <- pils1994$cov <- df.attr$"Deckung.in.."

rownames(pils1994) <- paste0("pils1994:",
	gsub(" ", "0", format(rownames(pils1994), width = 2, justify = "right")))
require(naturalsort)
pils1994 <- pils1994[naturalorder(rownames(pils1994)), ]

		
save(pils1994, file = "~/Documents/vegsoup-data/pils1994/pils1994.rda")

rm(list = ls()[-grep("pils1994", ls(), fixed = TRUE)])

#QuickMap(pils1994)