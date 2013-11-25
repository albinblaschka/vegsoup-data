library(vegsoup)
require(rgdal)

file <- "~/Documents/vegsoup-data/kalkalpen lichen dta/species.csv"
# promote to class "Species"

X <- species(file, sep = ";")
X <- X[, 1:4]
X$cov <- gsub(",", ".", X$cov, fixed = TRUE)
#X$plot <- sprintf("kal%03d", as.numeric(X$plot))

file <- "~/Documents/vegsoup-data/kalkalpen lichen dta/sites.csv"
# promote to class "Sites"
Y <- sites(read.csv2(file))
#Y$plot <- sprintf("kal%03d", as.numeric(Y$plot))

file <- "~/Documents/vegsoup-data/kalkalpen lichen dta/taxonomy.csv"
# promote to class "SpeciesTaxonomy"
XZ <- SpeciesTaxonomy(X, file.y = file)
# promote to class "Vegsoup"
kal <- Vegsoup(XZ, Y, coverscale = "percentage")
dim(kal)

save(kal, file = "~/Documents/vegsoup-data/kalkalpen lichen dta/kal.rda")
rm(list = ls()[-grep("kal", ls(), fixed = TRUE)])

