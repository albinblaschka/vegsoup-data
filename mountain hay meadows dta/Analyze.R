library(vegsoup)

setwd("~/Documents/vegsoup-data/mountain hay meadows dta")

load("Staudinger027_028.rda")

x <- Staudinger027_028

#	set up object
decostand(x) <- "total"
vegdist(x) <- "bray"

#	authors classification in alliance
#	groome levels
levels(x$verband)[levels(x$verband) == "Calthion (incl. Filipendulion)"] <- "Calthion"
levels(x$orig_diag)[levels(x$orig_diag) == "Astrantio-Tristetum"] <- "Astrantio-Trisetetum" 
levels(x$orig_diag)[levels(x$orig_diag) == "Poo-Tristetetum"] <- "Poo-Trisetetum"
levels(x$orig_diag)[levels(x$orig_diag) == "Festuco-Cynocuretum"] <- "Festuco-Cynosuretum"

p0 <- VegsoupPartition(x, clustering = "verband")
as.table(p0, "verband")
d0 <- as.dendrogram(p0, labels = "verband")
plot(d0, main = "Apriori classification into alliance")

#	we subset Arrhenatherion (2), Cynosurion (5) and Trisetion (7) for this analysis
x1 <- do.call("bind", sapply(c(2,5,7), function (x) partition(p0, x)))
plot(as.dendrogram(x1, labels = "verband"))
as.table(x1, "verband")

#	OptimClass for k = 20, will take a while () to complete
#os <- OptimStride(x1, k = 20, fast = TRUE)
plot(os)
print(os)
# higher is better
boxplot(t(optimclass1(os)))
boxplot(t(apply(optimclass1(os), 2, rank, ties = "first")))

#	alliances
p0 <- VegsoupPartition(x1, clustering = "verband")
Latex(fidelity(p0, "TCR"), file = "./tex/selected alliances", template = TRUE, stat.min = 0.1, taxa.width = "70mm")

#	select candidate, fuzzy c-means
p <- VegsoupPartition(x1, k = 7, method = "FCM")
#	try to optimize
pp <- optsil(p)

confusion(p, pp)
as.table(p, "verband")
as.table(pp, "verband")
as.table(p, "orig_diag")
as.table(pp, "orig_diag")

#	results
Latex(fidelity(p, "TCR"), file = "./tex/FCM TCR k7", template = TRUE, stat.min = 0.1, taxa.width = "70mm")
Latex(fidelity(pp, "TCR"), file = "./tex/FCM TCR k7 optsil", template = TRUE, stat.min = 0.1, taxa.width = "70mm")

#	reorder to dendrogram
ppp <- p
dp <- sapply(cut(as.dendrogram(ppp), 0)$lower, function (x) dendrapply(x, function (n) attr(n, "label")))
k <- factor(partitioning(ppp))
l <- cbind(k = levels(k), dp)
levels(k) <- dp
ppp@part <- as.numeric(as.character(k))

Latex(fidelity(ppp, "TCR"), file = "./tex/FCM TCR k7 order", template = TRUE, stat.min = 0.1, taxa.width = "70mm")
