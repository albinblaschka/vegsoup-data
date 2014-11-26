library(vegsoup)
require(bibtex)

path <- "~/Documents/vegsoup-data/berchtesgaden dta"
key <- read.bib(file.path(path, "references.bib"), encoding = "UTF-8")$key

file <- file.path(path, "species.csv")
# promote to class "Species"

X <- species(file, sep = ";")
X <- X[, 1:4]

file <- file.path(path, "sites.csv")
# promote to class "Sites"
Y <- sites(file, sep = ";")
Y$value <- gsub(",", ".", Y$value)

file <- "~/Documents/vegsoup-standards/austrian standard list 2008/austrian standard list 2008.csv"
# promote to class "SpeciesTaxonomy"
XZ <- SpeciesTaxonomy(X, file.y = file)
# promote to class "Vegsoup"
obj <- Vegsoup(XZ, Y, coverscale = "domin")

#	add coordinates from polygon
pg <- readOGR("/Users/roli/Documents/vegsoup-data/berchtesgaden dta/",
	"sites", stringsAsFactors = FALSE)
r <- rep(1:nrow(pg), each = 10)
pt <- coordinates(pg)[r, ]
plots <-  paste(pg$SITE[r], sprintf("%02d", 1:10), sep = "-")
pt <- pt[match(rownames(obj), plots), ]

obj$longitude <- pt[, 1]
obj$latitude <-  pt[, 2]
	
coordinates(obj) <- ~longitude+latitude
proj4string(obj) <- CRS("+init=epsg:4326")

obj$plsx <- 2
obj$plsy <- 2

#	order layer
Layers(obj)	 <- c("sl", "hl")

#	assign result object
assign(key, obj)

#	richness
obj$richness <- richness(obj, "sample")

#	save to disk
do.call("save", list(key, file = file.path(path, paste0(key, ".rda"))))
write.verbatim(obj, file.path(path, "transcript.txt"), sep = "", add.lines = TRUE)

#	tidy up
rm(list = ls()[-grep(key, ls())])
