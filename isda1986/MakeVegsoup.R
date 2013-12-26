library(vegsoup)

#setwd("~/Dropbox/vegsoup prj/isda1986")

file <- "~/Documents/vegsoup-data/isda1986/Isda1986Tab1.txt"
x <- read.verbatim(file, "Aufnahmenummer")

file <- "~/Documents/vegsoup-data/isda1986/Isda1986Tab1TableFooter.txt"
x <- read.verbatim.append(x, file, "plots", abundance = TRUE)

x.df <- data.frame(abbr = rownames(x), layer = "hl", comment = NA, x,
	check.names = FALSE)
X <- stack.species(x.df)

Y <- read.delim("~/Documents/vegsoup-data/isda1986/Isda1986Tab1Locations.txt",
	header = FALSE, colClasses = "character")
names(Y) <- c("plot", "location.short", "location", "tms")
Y$plot <- type.convert(Y$plot)	

Y <- data.frame(Y, t(sapply(Y[,4], str2latlng, USE.NAMES = FALSE)))
Y <- stackSites(Y)

file <- "~/Documents/vegsoup-standards/austrian standard list 2008/austrian standard list 2008.csv"
Z <- SpeciesTaxonomy(X, file.y = file)

dta <- Vegsoup(X, Y, Z, coverscale = "braun.blanquet2")

# assign header data stored as attributes in
# imported original community table
# omit dimnames, class and plot id

df.attr <- as.data.frame(attributes(x)[-c(1:3)])
rownames(df.attr) <- colnames(x)
# reorder by plot
df.attr <- df.attr[match(rownames(dta), rownames(df.attr)), ]
# give names and assign
dta$block <- df.attr$"block"
dta$ph <- as.character(df.attr$"pH..10..1.")
dta$ph[dta$ph == ".."] <- 0
dta$ph <- as.numeric(dta$ph) /10
dta$expo <- toupper(gsub("[[:punct:]]", "", as.character(df.attr$Exposition)))
dta$slope <- df.attr$Hangneigung
dta$elevation <- df.attr$"Seehöhe...100." * 100
dta$block <- df.attr$Block
dta$altitude <- df.attr$Seehöhe

rm <- ls()
isda1986 <- dta
rm(list = rm)
rm(rm)

save(isda1986, file = "~/Documents/vegsoup-data/isda1986/isda1986.rda")
