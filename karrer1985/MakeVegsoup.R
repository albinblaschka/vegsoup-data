library(vegsoup)

file <- "~/Documents/vegsoup-data/karrer1985/species.csv"
# promote to class "Species"

X <- species(file, sep = ";")
X <- X[, 1:4]
file <- "~/Documents/vegsoup-data/karrer1985/sites.csv"

# promote to class "Sites"
Y <- sites(read.csv2(file))

file <- "~/Documents/vegsoup-standards/austrian standard list 2008/austrian standard list 2008.csv"
# promote to class "SpeciesTaxonomy"
XZ <- SpeciesTaxonomy(X, file.y = file)
# promote to class "Vegsoup"
karrer1985 <- Vegsoup(XZ, Y, coverscale = "braun.blanquet")

save(karrer1985, file = "~/Documents/vegsoup-data/karrer1985/karrer1985.rda")
rm(list = ls()[-grep("karrer1985", ls(), fixed = TRUE)])