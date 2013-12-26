library(vegsoup)

file <- "~/Documents/vegsoup-data/windsfeld dta/species.csv"
# promote to class "Species"

X <- species(file, sep = ";")
X <- X[, 1:4]
file <- "~/Documents/vegsoup-data/windsfeld dta/sites wide.csv"

# promote to class "Sites"
Y <- stackSites(file = file)

file <- "~/Documents/vegsoup-standards/austrian standard list 2008/austrian standard list 2008.csv"
# promote to class "SpeciesTaxonomy"
XZ <- SpeciesTaxonomy(X, file.y = file)
# promote to class "Vegsoup"
wf <- Vegsoup(XZ, Y, coverscale = "braun.blanquet")

wf@sites <- wf@sites[, c(1:25)]

save(wf, file = "~/Documents/vegsoup-data/windsfeld dta/wf.rda")
rm(list = ls()[-grep("wf", ls(), fixed = TRUE)])

#	vegsoup testdata
#	windsfeld <- wf
#	windsfeld@taxonomy <- windsfeld@taxonomy[, c(1,2,4)]
#	windsfeld@taxonomy$taxon <- gsub("\u00D7", "×", windsfeld@taxonomy$taxon, fixed = TRUE)
#	save(windsfeld, file = "windsfeld.rda")



