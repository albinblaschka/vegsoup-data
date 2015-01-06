vegsoup-data
============

This is our personal vegetation data base (spatial and temporal explicit species occurrence data). It contains a bunch of unpublished data sets (1469 releveés), as well as data taken from the literature (1890 releveés). The bibtex file `./references.bib` that is contained in each project folder gives citation information for a particular data set (see also section licence).

Data sets containing a file named `transcript.txt` are ready to be used with the available [**vegsoup** *R*-package](http://r-forge.r-project.org/projects/vegsoup/). Just download the corresponding `*.rda` file and load it into your *R* session. Most data sets link to a standard list ([see here)](https://github.com/kardinal-eros/vegsoup-standards/tree/master/austrian%20standard%20list%202008). A summary of all  data available is contained in the [./mirror](https://github.com/kardinal-eros/vegsoup-data/blob/master/mirror) folder.
=======
A repository of plant species co-occurrence data (vegetation data, phytosociological relevés).

About
-----

This is our personal vegetation data base (spatial and temporal explicit species co-occurrence data).
It can be viewed as an incubator area for the accumulation of vegetation-plot data.
Currently the repository contains a bunch of unpublished data sets (1545 relevés), as well as computerized data taken from the literature (1940 relevés), in sum 3485 relevés involving 2369 taxa (species).
The bibtex file `./refernces.bib` that is contained in each project folder gives citation information for a particular data set (see also section license).

How to access and use the data sets
-----------------------------------

Data sets containing a file named `transcript.txt` are ready to be used with the [**vegsoup** *R*-package](http://r-forge.r-project.org/projects/vegsoup/).
To install this package from within *R*, type:

```R
install.packages("vegsoup", repos="http://R-Forge.R-project.org", type = "source")
```

To load a data set it into an *R* session you may either download a particular `*.rda` file and attach it to your *R*-session (first navigate to the respective `*.rda` file, then right-click on the file, a further click on *View Raw* will download the file.), or load the data directly from inside an R session:

```R
library(vegsoup)
library(RCurl)  

URL <- paste0(
	"https://raw.githubusercontent.com/",  # to accesses the raw files
	"kardinal-eros/vegsoup-data/master/",  # this is the repository
	"barmstein%20dta/bs.rda"               # folder and *.rda file
)
load(rawConnection(getBinaryURL(URL)))
```

A condensed object containing all available data in this repository is contained in the [./mirror](https://github.com/kardinal-eros/vegsoup-data/blob/master/mirror) folder as `mirror.rda`.

Species designation and taxonomic concepts
------------------------------------------

All data sets link to a standard list ([for further details see here)](https://github.com/kardinal-eros/vegsoup-standards/tree/master/austrian%20standard%20list%202008).

![](README.png)

Licence
-------

<a rel="license" href="http://creativecommons.org/licenses/by-nc-sa/4.0/"><img alt="Creative Commons licnece" style="border-width:0" src="https://i.creativecommons.org/l/by-nc-sa/4.0/88x31.png" /></a><br />This work is licensed under a Craetive Commons licence <a rel="license" href="http://creativecommons.org/licenses/by-nc-sa/4.0/">Attribution - NonCommercial - ShareAlike 4.0 International</a>.



<!-- Please contact me (kardinal.eros at gmail.com) if you want to use any of the data sets in a publication.

Short note about formats
------------------------
Date format is in general IS0 8601.
Coordinates are given in decimal degree with 6 significant digits and refer to the WGS84 ellipsoid (EPSG code 4326). A field named `accuracy` is available for most data sets and quantifies coordinate uncertainty in meters.
-->

Sampling protocol and data standards
====================================

This is a brief summary of the sampling protocol and descriptive attributes collected with each sampling unit (plot or relevée) as available in the **vegsoup-data** repository. Of course, this does not apply to data sets taken from the literature.

Sampling procedure
------------------

Depending on the scope of a particular project, different sampling procedures are applied.

- *Landscape Sampling* uses area stratification. That means, a survey area is divided into strata (forest, meadow, mire, etc.) and samples within a stratum are replicated depending on the spatial extent of the stratum. We always aim to sample all vegetation types in a given survey area that are discernible in the field. The size of the landscape surveyed is typically in the range of 5 to 50 hectares.

- In *Type Specific Sampling* we search a coherent survey area as large as possible for a specific vegetation type (e.g. ravine forest or rock shrubery).

- In *Species Specific Sampling* we sample the vegetation where a particular (rare) species occurs.

- In *Rapid Biodiversity Sampling* we collect instances of (all) vegetation types in an area as we walk (strait) through the landscape. In this way we typically don't collect area-dependent replicates.

- *Rock Vegetation Sampling* is performed by using mountaineering equipment (rope and climbing harness), occasionally by free-climbing. Rock vegetation of any kind or forests of steep slopes are sampled using a rope along a vertical transect. Usually 3 to 4 plots are sampled along a 100 m long rope. The first plot is typically sampled just below the rope betray point. The last relevée is taken at the end of the rope. Depending on how long the rappelling (abseiling) needs to be, non overlapping plots are taken along this line, with gaps between sampling units of at least half the plot size applied.

- *Systematic sampling* is performed by using a rectangular grid or along a transect.


We don't (really) care about homogeneity or other subjective criteria concerning a sample plot and sampling locations
are typically randomly selected. In case of »Rock Vegetation Sampling« the location of the vertical transect is constrained by the presence of a suitable belay point that can be reached with reasonable effort. Additionally, danger by falling rocks is an issue. In this context, the sampled vegetation can not be subjectively chosen, and sampling can be considered random.


Estimation scales
-----------------

We typically apply the 9-point modification of the the classical 7-point Braun-Blanquet 
by Barkman et al. (1964). See Roberts & Peet (2013) for details.

Plot sizes
----------

We use strictly equal sized plots with edge lengths that are powers of 2 (e.g. 1 × 1, 2 × 2, 4 × 4, 8 × 8, 16 × 16).
Grasslands (including alpine vegetation and tundra), marshes, fens and mires are sampled using 16 m² area plots (4m × 4m); shrubs and rock shrubery with 64 m² plots (8m × 8m) and woodlands are sampled within plots of 256 m² (16m × 16m).
Spring vegetation is sampled using small plots of size 1 m² (1m × 1m).

When ever possible we use square plots. In some rare cases (e.g. forest on rock cliffs) it is necessary to switch to elongated plot forms (e.g. 10 × 26 m ≈ 256 m² instead of 16 × 16 m). We record both edge lengths of the plot instead of noting the plot area. The shape of non square plots can then be estimated by dividing *edge max* by *edge min*.


Attributes of the sampling units (relevées) that are recored in the field
------------------------------------------------------------------------

Basic standards for the phytosociological relevée follow Mucina et al. (2000).

**Data on field record**

> `plot` designation of sample plot (relevé)  
> `date` date of sampling (ISO 8601, yyyy-mm-dd)  
> `observer` name(s) of the author(s) of the relevé  
> `alliance` provisional classification into syntaxon  
> `association`  
> `plsx` edge length of plot, parallel to hillside  
> `plsy` edge length of plot, orthogonal to hillside  


**Geographic data**  

> `locality` topographic name  
> `expo` exposition, aspect  
> `slope` slope, inclination  

Other fields, such as country, province (district), nearest village, and altitude can be obtained with the `reverseGeocode` function.


**Geographic coordinates**  

> `latitude` coordinate of latitude in decimal degrees (decimal is ».«) based on the WGS 1984 ellipsoid (EPSG:4326), a minus sign or a padding letter »S« and »N« means south and north of the equator, respectively (e.g. 12.345678S or -12.345678).  
> `longitude` coordinate of latitude, a minus sign or padding letter »W« and »E» means west and east of the greenwich zero meridian, respectively  (eg. 87.654321W or -87.654321)  
> `accuracy` coordinate uncertainty (precision) in meters

**Data on vegetation**  

*Cover of vegetation*

We supply the stratum/layer notation as defined in Mucina et al. 2000 (E₀, E₁, E₂, E₃).

> `cov` total cover, total projection of standing vegetation  


*Cover of tree layer* in % (***E₃***)

> `tcov` cover of *tree* layer (***E₃***)  
> `t1cov` cover of *canopy* layer (***E₃ γ***)  
> `t2cov` cover of *sub-canopy* layer (***E₃ β***)  


*Cover of shrub layer* in % (***E₂***)

> `scov` cover of *shrub* layer (***E₂***)


*Cover of herb layer* in % (***E₁***)

> `hcov` cover of *herb* layer (***E₁***)  

*We don't estimate the cover of any sub-strata in the terrestrial herb layer (upper, middle and lower herb layer ***E₁ α***, ***E₁ β***, and ***E₁ γ***, respectively), but, we do so for aquatic vegetation:*

> `ncov` cover of *natant plants* (***E₁n***)  
> `ucov` cover of *submerged plants* (***E₁s***)  

<!--- *Cover of *emergent plants* (***E₁e***) equals `hcov` (***E₁***) -->


*Cover of cryptogam layer* in % (***E₀***)

> `mcov` cover of cryptogam layer (***E₀***)  


*Cover of non vegetated ground* in %

> `litter` cover of litter  
> `rock` cover of rocks  
> `bare` cover of bare soil  
> `soil` cover of debris  
> `water` cover of free water  


*Height of tree layer* in meters, woody plants over 6 m tall (***E₃***)

> `htl` height of tree layer (***E₃***)  
> `htl0` height of emergent layer (***E₃ δ***), woody plants with crowns towering above the canopy layer (e.g. a tall coniferous tree overtopping the canopy of decidous trees) *  
> `htl1` height of canopy layer (***E₃ γ***)  
> `htl2` height of  sub-canopy layer (***E₃ β***)  
> `htl3` height of lower tree layer (***E₃ α***) *  


*Height of shrub layer* in meters, woody plants ranging 0.5 - 6 m (***E₂***)
 
> `hsl` height of shrub layer (***E₂***), woody plants ranging 0.5 - 6 m.  s

We don't distinguish lower (***E₂ α***) and upper shrub layer (***E₂ β***)  


*Height of herb layer* in meters, non-woody phanerogams (***E₁***)

> `hhl` height of herb layer (***E₁***)  
> `hhl1` height of upper herb layer (***E₁ γ***)  
> `hhl2` height of lower herb layer (***E₁ α***)  

*We don't distinguish a middle herb layer (***E₁ β***)*  
*We include woody plants that compete with non-woody phanerogams in the herb layer (juvenile trees)*  
*We don't estimate the height of the cryptogam layer (***E₀***)*  


**Data on habitat and Notes**  

> `comment` optional notes  
> `geology` type of (bed-)rock  
> `hydrology` water regime  
> `soil` type and/or texture of soil  


References
==========

M Chytrý & Z Otýpková (2003). Plot sizes used for phytosociological sampling of european vegetation. Journal of Vegetation Science, 14(4):563–570.

L Mucina, J Schaminee, & J Rodwell (2000). Common data standards for recording relevés in field survey for vegetation classification. Journal of Vegetation Science, 11: 769-772.

RK Peet & DW Roberts (2013). Classification of natural and semi-natural vegetation. In Vegetation Ecology (E van der Maarel, & J Franklin, eds.). Wiley-Blackwell.