library(vegit)

path <- "~/Documents/vegsoup-data/dullnig1989"

#	format OCR table transcript for table 1
file <- file.path(path, "Dullnig1989Tab1OCR.csv")
csv2txt(file, 10, width = 5, vertical = FALSE, overwrite = F)

#	format OCR table transcript for table 4
file <- file.path(path, "Dullnig1989Tab4OCR.csv")
m <- csv2txt(file, 10, width = 5, vertical = FALSE, overwrite = F)