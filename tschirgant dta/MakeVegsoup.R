#	recodes plot identifier tg (alias for totes gebirge) to tsg
library(vegsoup)

file <- "~/Documents/vegsoup-data/tschirgant dta/species.csv"
# promote to class "Species"

X <- species(file, sep = ";")
X <- X[, 1:4]
file <- "~/Documents/vegsoup-data/tschirgant dta/sites.csv"

# promote to class "Sites"
Y <- sites(read.csv2(file))

file <- "~/Documents/vegsoup-standards/austrian standard list 2008/austrian standard list 2008.csv"
# promote to class "SpeciesTaxonomy"
XZ <- SpeciesTaxonomy(X, file.y = file)
# promote to class "Vegsoup"
tsg <- Vegsoup(XZ, Y, coverscale = "braun.blanquet")

rownames(tsg) <- gsub("tg", "tsg", rownames(tg))
save(tsg, file = "~/Documents/vegsoup-data/tschirgant dta/tsg.rda")
rm(list = ls()[-grep("tsg", ls(), fixed = TRUE)])