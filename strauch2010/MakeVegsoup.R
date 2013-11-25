require(vegsoup)

#	species
file = "~/Documents/vegsoup-data/strauch2010/Strauch2010SupplementTabT16-19-20-21.csv"
X <- stack.species(file = file)

#	sites
df <- read.delim("~/Documents/vegsoup-data/strauch2010/Strauch2010SupplementTabT16-19-20-21Locations.csv",
	header = TRUE, colClasses = "character")
	
df <- data.frame(df, t(sapply(df[,4], str2latlng, USE.NAMES = FALSE)))

df$slope <- round(unlist(lapply(strsplit(as.character(df$slope.str), "-", fixed = TRUE),
	function (x) mean(as.numeric(as.character(x))))), 0)
df$slope[is.na(df$slope)] <- NA

y <- pt <- df

y <- y[, -grep("slope.str", names(y))]
y <- y[, -grep("code", names(y))]
y <- y[, -grep("tms", names(y))]

Y <- stack.sites(y)

file <- "~/Documents/vegsoup-standards/austrian standard list 2008/austrian standard list 2008.csv"
XZ <- SpeciesTaxonomy(x = X, file.y = file)

strauch2010 <- Vegsoup(XZ, Y, coverscale = "braun.blanquet2")

rownames(strauch2010) <- paste("strauch2010", rownames(strauch2010), sep = ":")

save(strauch2010, file = "~/Documents/vegsoup-data/strauch2010/strauch2010.rda")

rm(list = ls()[-grep("strauch2010", ls())])
