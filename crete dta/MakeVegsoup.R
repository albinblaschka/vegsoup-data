library(vegsoup)

file <- "~/Documents/vegsoup-data/crete dta/species.csv"
# promote to class "Species"

X <- species(file, sep = ";")
X <- X[, 1:4]

file <- "~/Documents/vegsoup-data/crete dta/sites.csv"
# promote to class "Sites"
Y <- sites(read.csv2(file))

file <- "~/Documents/vegsoup-data/crete dta/taxonomy.csv"
# promote to class "SpeciesTaxonomy"
XZ <- SpeciesTaxonomy(X, file.y = file)
# promote to class "Vegsoup"
crete2011 <- Vegsoup(XZ, Y, coverscale = "braun.blanquet")

save(crete2011, file = "~/Documents/vegsoup-data/crete dta/crete2011.rda")
rm(list = ls()[-grep("crete2011", ls(), fixed = TRUE)])

