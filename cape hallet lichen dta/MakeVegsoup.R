library(vegsoup)

file <- "~/Documents/vegsoup-data/cape hallet lichen dta/species wide.csv"
# promote to class "Species"

X <- stack.species(file = file, sep = ";")[, 1:4]

file <- "~/Documents/vegsoup-data/cape hallet lichen dta/sites wide.csv"
# promote to class "Sites"
Y <- stack.sites(file = file, sep = ";")

file <- "~/Documents/vegsoup-data/cape hallet lichen dta/taxonomy.csv"
# promote to class "SpeciesTaxonomy"
XZ <- SpeciesTaxonomy(X, file.y = file)
# promote to class "Vegsoup"
chl <- Vegsoup(XZ, Y, coverscale = "percentage")
coordinates(chl) <- ~x+y

save(chl, file = "~/Documents/vegsoup-data/cape hallet lichen dta/chl.rda")
rm(list = ls()[-grep("chl", ls(), fixed = TRUE)])

is.continuous(chl)