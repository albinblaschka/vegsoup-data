library(vegsoup)

file <- "~/Documents/vegsoup-data/fallbichl dta/species.csv"
X <- species(file, sep = ";")[, 1:4]

file <- "~/Documents/vegsoup-data/fallbichl dta/sites wide.csv"
Y <- stack.sites(file = file, csv2 = TRUE)

file <- "~/Documents/vegsoup-standards/austrian standard list 2008/austrian standard list 2008.csv"
# promote to class "SpeciesTaxonomy"
XZ <- SpeciesTaxonomy(X, file.y = file)

# promote to class "Vegsoup"
fb <- Vegsoup(XZ, Y, coverscale = "braun.blanquet")

save(fb, file = "~/Documents/vegsoup-data/fallbichl dta/fb.rda")
rm(X, Y, XZ, file)
