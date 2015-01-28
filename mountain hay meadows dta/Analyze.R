library(vegsoup)

setwd("~/Documents/vegsoup-data/mountain hay meadows dta")

load("Staudinger027_028.rda")

x <- Staudinger027_028

#	set up
decostand(x) <- "pa"
vegdist(x) <- "bray"

#	authors classification in alliance
p0 <- VegsoupPartition(x, clustering = "verband")
as.table(p0, "verband")
d0 <- as.dendrogram(p0)
plot(d0)

#	we subset Arrhenatherion (2), Cynosurion (5) and Trisetion (7)
x1 <- do.call("bind", sapply(c(2,5,7), function (x) partition(p0, x)))

#	os <- OptimStride(x1, k = 20, fast = TRUE)

p <- VegsoupPartition(x1, k = 11, method = "FCM")
pp <- optsil(p)

confusion(p, pp)
as.table(p, "verband")
as.table(pp, "verband")

Latex(fidelity(p, "TCR"), file = "table", template = TRUE, stat.min = 0.1)

p1.0 <- VegsoupPartition(x1, clustering = "verband")

Latex(fidelity(p1.0, "TCR"), file = "table2", template = TRUE, stat.min = 0.1)

plot(as.dendrogram(p1.0))
as.table(p1.0, "verband")
