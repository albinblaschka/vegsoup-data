require(vegsoup)

file <- "~/Documents/vegsoup-data/lambach dta/species wide.csv"
X <- stack.species(file = file)

file <- "~/Documents/vegsoup-data/lambach dta/sites wide.csv"
Y <- stack.sites(file = file)

file <- "~/Documents/vegsoup-standards/austrian standard list 2008/austrian standard list 2008.csv"
XZ <- SpeciesTaxonomy(x = X, file.y = file)

lb <- Vegsoup(XZ, Y, coverscale = "braun.blanquet2")

save(lb, file = "~/Documents/vegsoup-data/lambach dta/lb.rda")
rm(X, Y, XZ, file)
