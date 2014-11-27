library(vegsoup)
library(bibtex)

path <- "~/Documents/vegsoup-data"

x <- list.files(path)


ii <- c(
#	other fieles
	"CHANGES.md",
	"README.md",
	"mirror",
#	unfished data sets	
	"dirnböck1999",
	"dunzendorfer1980",
	"ewald2013",
	"greimler1996",
	"grims1982",
	"hohewand fence dta",
	"hohewand transect dta",
	"ibmermoos dta",
	"jakubowsky1996",
	"kalkalpen lichen dta",
	"monte negro dta",
	"nußbaumer2000",
	"oberndorf dta",
	"pflugbeil2012",
	"prebersee dta",
	"rinnkogel dta",
	"ruttner1994",
	"salzkammergut lichen dta",
	"schwarz1989",
	"stadler1991",
	"stadler1992",
	"stadler2011",
	"surina2004",
	"urban1992",
	"urban2008",
#	lichens	
	"cape hallet lichen dta",
#	problematic
	"berchtesgaden dta"
)

x <- x[-match(ii, x)]

x <- sapply(file.path(path, x), function (x) {
	read.bib(file.path(x, "references.bib"), encoding = "UTF-8")$key[[1]]	
})

#	update
	sapply(file.path(names(x), "MakeVegsoup.R"), source)