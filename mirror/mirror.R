library(vegsoup)

path <- "~/Documents/vegsoup-data"

x <- list.files(path)

#	unfished data sets
ii <- c(
	"CHANGES.md",
	"README.md",
	"mirror",
	
	"dirnböck1999",
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
	"salzkammergut lichen dta",
	"schwarz1989",
	"stadler1991",
	"stadler1992",
	"stadler2011",
	"surina2004",
	"urban1992",
	"urban2008"
)

x <- x[-match(ii, x)]

file.path(path, x)


#	unique rownames
rownames(obj) <- paste(key, "Tab1", sprintf("%02d", as.numeric(rownames(obj))), sep = ":")