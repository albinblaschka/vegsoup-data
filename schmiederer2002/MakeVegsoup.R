library(vegsoup)

file <- "~/Documents/vegsoup-data/schmiederer2002/species.csv"
# promote to class "Species"

X <- species(file, sep = ";")
X <- X[, 1:4]
file <- "~/Documents/vegsoup-data/schmiederer2002/sites.csv"

# promote to class "Sites"
Y <- sites(read.csv2(file))

file <- "~/Documents/vegsoup-standards/austrian standard list 2008/austrian standard list 2008.csv"
# promote to class "SpeciesTaxonomy"
XZ <- SpeciesTaxonomy(X, file.y = file)
# promote to class "Vegsoup"
schmiederer2002 <- Vegsoup(XZ, Y, coverscale = "braun.blanquet")

save(schmiederer2002, file = "~/Documents/vegsoup-data/schmiederer2002/schmiederer2002.rda")
rm(list = ls()[-grep("schmiederer2002", ls(), fixed = TRUE)])