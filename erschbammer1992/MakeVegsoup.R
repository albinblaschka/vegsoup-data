require(vegsoup)

#	read digitized table 
file <- system.file("extdata", "Erschbammer1992Tab4.txt",
                    package = "vegsoup")
x <- read.verbatim(file, "Aufnahme Nr.")


# add species from table footer
file <- "~/Documents/vegsoup-data/erschbammer1992/Erschbammer1992Tab4Tablefooter.txt"
x <- read.verbatim.append(x, file, mode = "species")

# turn into long format
x.df <- data.frame(abbr = rownames(x), layer = "hl", comment = NA, x,
                   check.names = FALSE)
# promote to class "Species"
X <- stack.species(x.df)
# groome abundance scale codes to fit the standard
# of the extended Braun-Blanquet scale used in the original publication
X$cov <- gsub("m", "2m", X$cov)
X$cov <- gsub("a", "2a", X$cov)
X$cov <- gsub("b", "2b", X$cov)

#   sites data including coordinates
file <- "~/Documents/vegsoup-data/erschbammer1992/Erschbammer1992Tab4Locations.txt"
Y <- read.delim(file, colClasses = "character")
names(Y)[1] <- "plot"
# promote to class "Sites"
Y <- stack.sites(Y)

# taxonomy reference list
file <- "~/Documents/vegsoup-standards/austrian standard list 2008/austrian standard list 2008.csv"
XZ <- SpeciesTaxonomy(X, file.y = file)

# promote to class "Vegsoup"
eb92 <- Vegsoup(XZ, Y, coverscale = "braun.blanquet")

# assign header data stored as attributes in
# imported original community table
# omit dimnames, class and plot id
df.attr <- as.data.frame(attributes(x)[-c(1:4)])
rownames(df.attr) <- colnames(x)
# reorder by plot
df.attr <- df.attr[match(rownames(eb92), rownames(df.attr)), ] 

# give names and assign sites variables
eb92$block <- df.attr$Block
eb92$altitude <- df.attr$Seehöhe
eb92$expo <- df.attr$Exposition
eb92$cov <- df.attr$"Deckung...."
eb92$ph <- df.attr$"ph...10.2."

save(eb92, file = "~/Documents/vegsoup-data/erschbammer1992/eb92.rda")
rm(file, x, X, x.df, Y, df.attr)