require(vegsoup)

#	change directory
setwd("~/Documents/vegsoup-data/krisai1996")

#	read prepared digitized table
file <- "Krisai1996Tab8taxon2standard.txt"
x <- read.verbatim(file, "Aufnahme Nr.", verbose = FALSE, layers = "@")
X0 <- species(x)

#	and footer taxa
file <- "Krisai1996Tab8FooterSpecies.csv"
X1 <- species(file, sep = ";")[, 1:4]

X <- rbind(X0, X1)

#   sites data including coordinates
file <- "~/Documents/vegsoup-data/krisai1996/krisai1996Tab8Locations.csv"
Y <- stackSites(file = file)

# taxonomy reference list
file <- "~/Documents/vegsoup-standards/austrian standard list 2008/austrian standard list 2008.csv"
XZ <- SpeciesTaxonomy(X, file.y = file)

# promote to class "Vegsoup"
krisai1996 <- Vegsoup(XZ, Y, coverscale = "braun.blanquet2")

# assign header data stored as attributes in
# imported original community table
# omit dimnames, plot id (Releveé number) and class
df.attr <- header(x)

# reorder by plot
df.attr <- df.attr[match(rownames(krisai1996), rownames(df.attr)), ] 

# give names and assign variables
krisai1996$pls <- df.attr$Groesse.qm.x10 * 10
krisai1996$expo <- as.character(df.attr$Exposition)
krisai1996$slope <- df.attr$"Neigung.in.Grad"
krisai1996$htl <- df.attr$"Baumschicht..Hoehe.m"

krisai1996$tcov <- df.attr$"Baumschicht..Deckung.."
krisai1996$scov <- df.attr$"Strauchschicht..Deckung.."
krisai1996$hcov <- df.attr$"Krautschicht..Deckung.."

rownames(krisai1996) <- paste0("krisai1996:",
	gsub(" ", "0", format(rownames(krisai1996), width = 2, justify = "right")))

require(naturalsort)
krisai1996 <- krisai1996[naturalorder(rownames(krisai1996)), ]
krisai1996tab8 <- krisai1996
