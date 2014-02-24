library(vegsoup)
require(rgdal)

file <- "~/Documents/vegsoup-data/berchtesgaden dta/species.csv"
# promote to class "Species"

X <- species(file, sep = ";")
X <- X[, 1:4]

file <- "~/Documents/vegsoup-data/berchtesgaden dta/sites.csv"
# promote to class "Sites"
Y <- sites(file, sep = ";")
Y$value <- gsub(",", ".", Y$value)

file <- "~/Documents/vegsoup-standards/austrian standard list 2008/austrian standard list 2008.csv"
# promote to class "SpeciesTaxonomy"
XZ <- SpeciesTaxonomy(X, file.y = file)
# promote to class "Vegsoup"
bg <- Vegsoup(XZ, Y, coverscale = "domin")

#	add coordinates from polygon
pg <- readOGR("/Users/roli/Documents/vegsoup-data/berchtesgaden dta/",
	"sites", stringsAsFactors = FALSE)
r <- rep(1:nrow(pg), each = 10)
pt <- coordinates(pg)[r, ]
plots <-  paste(pg$SITE[r], sprintf("%02d", 1:10), sep = "-")
pt <- pt[match(rownames(bg), plots), ]

bg$longitude <- pt[, 1]
bg$latitude <-  pt[, 2]
	
coordinates(bg) <- ~longitude+latitude
proj4string(bg) <- CRS("+init=epsg:4326")

bg@taxonomy <- Taxonomy(bg)[, c(1,2,4)]

bg$plsx <- 2
bg$plsy <- 2

save(bg, file = "~/Documents/vegsoup-data/berchtesgaden dta/bg.rda")
rm(list = ls()[-grep("bg", ls(), fixed = TRUE)])

#	vegsoup test data
#	berchtesgaden <- bg
#	save(barmstein, file = "berchtesgaden.rda")


