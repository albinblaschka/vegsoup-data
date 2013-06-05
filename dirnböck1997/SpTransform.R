library(rgdal)

#	epsg 31259
crs <- "+proj=tmerc +lat_0=0 +lon_0=16.33333333333334 +k=1 +x_0=750000 +y_0=-5000000 +ellps=bessel +towgs84=577.326,90.129,463.919,5.137,1.474,5.297,2.4232 +units=m +no_defs"

df <- read.csv2("~/Dropbox/Dirnböck1997/Dirnböck1997Tab8p336-339.csv")

df2 <- df[,c(1,10,11)]
sel <- !is.na(df2[, 2])
df3 <- df2[sel,]

coordinates(df3) <- ~GK.x.wert+GK.y.Wert
proj4string(df3) <- CRS(crs)

df3 <- spTransform(df3, CRS("+init=epsg:4326"))

#	center of study area
df$Längengrad <- mean(coordinates(df3)[,1])
df$Breitengrad <- mean(coordinates(df3)[,2])
df$Unschärfe <- 1000

#	available coordiantes
df[sel, c("Längengrad", "Breitengrad")] <- coordinates(df3)
df$Unschärfe[sel] <- 20

#	format
df$Breitengrad <- paste0(as.character(
	format(round(df$Breitengrad, 6), digits = 8)), "E")
df$Längengrad <- paste0(as.character(
	format(round(df$Längengrad, 6), digits = 8)), "E")

write.table(df, "~/Dropbox/Dirnböck1997/Dirnböck1997Tab8Locations.txt",
	quote = FALSE, row.names = FALSE, sep = "\t")

#	select
tab3 <- c(2203, 2213, 2202, 2208, 2230, 2217, 2219, 2221,
	2222, 2114, 2223, 2226, 2139, 2145, 2136, 2108, 2106, 2115)
sel <- df[match(tab3, df[,1]),]

sel <- sel[, -c(10,11)]
write.table(sel, "~/Dropbox/Dirnböck1997/Dirnböck1997Tab3Locations.txt",
	quote = FALSE, row.names = FALSE, sep = "\t")
	
	