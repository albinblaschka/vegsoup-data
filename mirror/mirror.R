#	this is build script for all available data set
#	data sets referncing to to https://github.com/kardinal-eros/vegsoup-standards/tree/master/austrian%20standard%20list%202008

library(vegsoup)
library(RefManageR)
library(knitr)

#	
path <- "~/Documents/vegsoup-data"

x <- list.files(path)

ii <- c(
#	other files
	"CHANGES.md",
	"README.md",
	"README.png",	
	"mirror",
#	unfished data sets	
	"dirnböck1999",
	"dunzendorfer1980",
	"ewald2013",
	"greimler1996",
	"greimler1997",
	"grims1982",
	"hohewand fence dta",
	"hohewand transect dta",
	"jakubowsky1996",
	"monte negro dta",
	"nußbaumer2000",
	"pflugbeil2012",
	"prebersee dta",
	"ruttner1994",
	"schwarz1989",
	"stadler1991",
	"stadler1992",
	"surina2004",
	"urban1992",
	"urban2008",
#	independent taxonomy
	"crete dta",
	"javakheti dta",
	"cape hallet lichen dta",
	"salzkammergut lichen dta",
	"kalkalpen lichen dta",
#	turboveg taxonomy (keep in sync with mirror dev.R)
	"aspro dta",
	"donauauen dta",
	"enzersfeld dta",
	"fischamend dta",	
	"hainburg dta",
	"kirchdorf and steyr-land dta",
	"mountain hay meadows dta",
	"nackter sattel dta",
	"neusiedlersee dta",
	"pilgersdorf dta",
	"ravine forest dta",	
	"reichraming dta",
	"sankt margarethen dta",
	"seekirchen dta",	
	"südburgenland dta",
	"vorarlberg dta",
	"wien dta",
	"wienerwald dta",
	"witzelsdorf dta"
)

x <- x[-match(ii, x)]

#	update
sapply(file.path(path, x, "MakeVegsoup.R"), function (x) {
	cat(x, "\n")
	source(x)
	} )

#	biblographic entities	
x <- sapply(file.path(path, x), function (x) {
	ReadBib(file.path(x, "references.bib"))	
}, simplify = FALSE)

#	write bibliography
b <- do.call("c", x)

f <- names(x)
k <- sapply(x, function (x) x[[1]]$key)
n <- sapply(x, function (x) x[[1]]$title)
a <- sapply(x, function (x) x[[1]]$author)
a <- sapply(a, function (x) {
	l <- length(x)
	if (l > 1)
		paste(paste(x[1:l - 1], collapse = ", "), x[l], sep = " & ")
	else
		as.character(x)})

#	load objects
for (i in seq_along(f)) {
	load(file.path(f[i], paste0(k[i], ".rda")))
	ii <- get(k[i])
	ii$key = k[i]
	ii$author = a[i]
	ii$title = n[i]
	assign(k[i], ii)
}

sapply(sapply(mget(k), coverscale), slot, "name")
l <- sapply(mget(k), function (x) compress(x, retain = c("author", "title", "accuracy", "observer")))

X <- do.call("bind", l)

save(X, file = file.path(path, "mirror", "mirror.rda"))

x <- data.frame(coordinates(X), Sites(X))
coordinates(x) <- ~longitude + latitude
proj4string(x) <- CRS("+init=epsg:4326")
dsn <- file.path(path.expand(path), "mirror")
writeOGR(x, dsn, "mirror_dev.shp", driver = "ESRI Shapefile", overwrite_layer = TRUE)

#	literature data
length(grep(":", rownames(X), fixed = TRUE))

#	own data
nrow(X) - length(grep(":", rownames(X), fixed = TRUE))

#	test sites consitency
#test <- X$accuracy
#write.csv2(cbind(plot = rownames(X), test)[is.na(test), ],
#	"foo.csv", quote = FALSE, row.names = FALSE)
