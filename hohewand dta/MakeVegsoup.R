library(vegsoup)

file <- "~/Documents/vegsoup-data/hohewand dta/species.csv"
X <- species(file, sep = ";")
X <- X[, c(1:4, grep("voucher", names(species(X))))]

file <- "~/Documents/vegsoup-data/hohewand dta/sites.csv"
Y <- sites(read.csv2(file))

file <- "~/Documents/vegsoup-standards/austrian standard list 2008/austrian standard list 2008.csv"
# promote to class "SpeciesTaxonomy"
XZ <- SpeciesTaxonomy(X, file.y = file)

# promote to class "Vegsoup"
hw <- Vegsoup(XZ, Y, coverscale = "braun.blanquet")

save(hw, file = "~/Documents/vegsoup-data/hohewand dta/hw.rda")
rm(X, Y, XZ, file)
