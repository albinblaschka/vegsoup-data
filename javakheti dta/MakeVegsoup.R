library(vegsoup)

file <- "~/Documents/vegsoup-data/javakheti dta/species.csv"
# promote to class "Species"

X <- species(file, sep = ";")
X <- X[, 1:4]

file <- "~/Documents/vegsoup-data/javakheti dta/sites.csv"

# promote to class "Sites"
Y <- sites(read.csv2(file))

file <- "~/Documents/vegsoup-data/javakheti dta/taxonomy.csv"
# promote to class "SpeciesTaxonomy"
XZ <- SpeciesTaxonomy(X, file.y = file)
# promote to class "Vegsoup"
jk <- Vegsoup(XZ, Y, coverscale = "braun.blanquet")

save(jk, file = "~/Documents/vegsoup-data/javakheti dta/jk.rda")
rm(X, Y, XZ, file)
