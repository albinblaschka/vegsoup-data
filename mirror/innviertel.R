library(mapdata)

source("~/Documents/vegsoup-data/mirror/mirror.R")

z <- Taxonomy(X)
z$abbr <- gsub(".", " ", z$abbr, fixed = TRUE)

x <- as.data.frame(X)[c("abbr", "taxon", "family", "latitude", "longitude", "accuracy",
	"author", "title", "plot")]
x$abbr <- gsub(".", " ", x$abbr, fixed = TRUE)

coordinates(x) <- ~longitude+latitude
proj4string(x) <- CRS("+init=epsg:4326")

x1 <- x2 <- x

#	austrian mapping grid
y1 <- readOGR("/Users/roli/Dropbox/basemaps/dta/shp/pg_grd_aut",
	"pg_grd_aut_epsg4326", p4s = "+init=epsg:4326")

#	Innviertel flora project area mapping grid
y2 <- readOGR("/Users/roli/Dropbox/basemaps/dta/shp/pg_grd_innviertel",
	"pg_grd_innviertel_epsg4326", p4s = "+init=epsg:4326")

#	Austrian data, points outside are NA	
x1@data <- cbind(x1@data, over(x1, y1))
#	Innviertel data only
x2@data <- cbind(x2@data, over(x2, y2))
x2 <- x2[!is.na(x2$GRIDCELL), ]


writeOGR(x1, "/Users/roli/Dropbox/sabotag/res/shp/vegsoup-data",
	"pt_all", driver = "ESRI Shapefile",
	layer_options = "ENCODING=UTF-8", overwrite_layer = TRUE)
	
writeOGR(x2, "/Users/roli/Dropbox/sabotag/res/shp/vegsoup-data",
	"pt_inn", driver = "ESRI Shapefile",
	layer_options = "ENCODING=UTF-8", overwrite_layer = TRUE)
	
write.csv2(x1, "/Users/roli/Dropbox/sabotag/res/csv/vegsoup-data/all.csv",
	row.names = FALSE, quote = FALSE)
write.csv2(x2, "/Users/roli/Dropbox/sabotag/res/csv/vegsoup-data/inn.csv",
	row.names = FALSE, quote = FALSE)
	
write.csv2(z, "/Users/roli/Dropbox/sabotag/res/csv/vegsoup-data/std.csv",
	row.names = FALSE, quote = FALSE)		
	
	