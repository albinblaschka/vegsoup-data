library(vegsoup)
library(RefManageR)

path <- "~/Documents/vegsoup-data"

x <- list.files(path)

ii <- c(
#	other files
	"CHANGES.md",
	"README.md",
	"mirror",
#	unfished data sets	
	"dirnböck1999",
	"dunzendorfer1980",
	"ewald2013",
	"greimler1996",
	"grims1982",
	"hohewand fence dta",
	"hohewand transect dta",
	"jakubowsky1996",
	"monte negro dta",
	"nußbaumer2000",
	"oberndorf dta",
	"pflugbeil2012",
	"prebersee dta",
	"rinnkogel dta",
	"ruttner1994",
	"schwarz1989",
	"stadler1991",
	"stadler1992",
	"stadler2011",
	"surina2004",
	"urban1992",
	"urban2008",
#	independent taxonomy
	"crete dta",	
	"cape hallet lichen dta",
	"javakheti dta",
	"salzkammergut lichen dta",
	"kalkalpen lichen dta"	
)

x <- x[-match(ii, x)]

x <- sapply(file.path(path, x), function (x) {
	ReadBib(file.path(x, "references.bib"))	
}, simplify = FALSE)

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

for (i in seq_along(f)) {
	load(file.path(f[i], paste0(k[i], ".rda")))
	ii <- get(k[i])
	ii$key = k[i]
	ii$author = a[i]
	ii$title = n[i]
	assign(k[i], ii)
}

sapply(sapply(mget(k), coverscale), slot, "name")
l <- sapply(mget(k), function (x) compress(x, retain = c("author", "title", "accuracy")))

X <- do.call("bind", l)
