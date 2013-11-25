library(vegsoup)

file <- "~/Documents/vegsoup-data/fuschl dta/species.csv"
X <- species(file, sep = ";")[, 1:4]

file <- "~/Documents/vegsoup-data/fuschl dta/sites.csv"
Y <- sites(read.csv2(file))

file <- "~/Documents/vegsoup-standards/austrian standard list 2008/austrian standard list 2008.csv"
# promote to class "SpeciesTaxonomy"
XZ <- SpeciesTaxonomy(X, file.y = file)

# promote to class "Vegsoup"
fu <- Vegsoup(XZ, Y, coverscale = "braun.blanquet")

save(fu, file = "~/Documents/vegsoup-data/fuschl dta/fu.rda")
rm(X, Y, XZ, file)
