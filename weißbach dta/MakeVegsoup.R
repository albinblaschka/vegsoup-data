library(vegsoup)

file <- "~/Documents/vegsoup-data/weißbach dta/species.csv"
# promote to class "Species"

X <- species(file, sep = ";")
X <- X[, 1:4]

file <- "~/Documents/vegsoup-data/weißbach dta/sites wide.csv"

# promote to class "Sites"
Y <- stackSites(file = file)

file <- "~/Documents/vegsoup-standards/austrian standard list 2008/austrian standard list 2008.csv"

# promote to class "SpeciesTaxonomy"
XZ <- SpeciesTaxonomy(x = X, file.y = file)


# promote to class "Vegsoup"
wb <- Vegsoup(XZ, Y, coverscale = "braun.blanquet")

save(wb, file = "~/Documents/vegsoup-data/weißbach dta/wb.rda")
rm(list = ls()[-grep("wb", ls(), fixed = TRUE)])
