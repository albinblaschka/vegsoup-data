library(vegsoup)
library(bibtex)

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
	"ibmermoos dta",
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
	read.bib(file.path(x, "references.bib"), encoding = "UTF-8")$key[[1]]	
})

for (i in file.path(names(x), paste0(x, ".rda"))) {
	load(i)
}

sapply(sapply(mget(x), coverscale), slot, "name")
l <- sapply(mget(x), compress)

X <- do.call("bind", l)

