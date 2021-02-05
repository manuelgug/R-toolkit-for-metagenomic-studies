# R Toolkit for Metagenomic Studies

This repository contains 4 scripts for easy processing and visualization of metagenomic data. All scripts have the necessary data import and formatting commands so they can be used independently of each other.

To correctly use any of the scripts you will need: 
* An abundance (count) table of OTUs or any taxonomic or functional annotation.
* A table indicating the sites/treatment or any other higher category to which each sample belongs.

### Example inputs

Abundance table: 

| Samples       | OTU1          | OTU2  | etc |
| ------------- |:-------------:| -----:| --: |
| sample1       | 50            | 6     | ... |
| sample2       | 77            | 99    | ... |
| sample3       | 103           | 5     | ... |
| sample4       | 10            | 53    | ... |
| ...           | ...           | ...   | ... |

Sites/treatment table (*note this table does not have headers*): 

|               |               |
| ------------- |:-------------:|
| sample1       | earwax        |
| sample2       | earwax        |
| sample3       | armpit_sweat  |
| sample4       | armpit_sweat  |
| ...           | ...           |

___________________________________________________________________________

For the example images, a data set of species from North Pacif
___________________________________________________________________________
## diversity.R
This script provides richness as well Shannon and Simpson alpha diversity metrics as calculated by vegan 2.5-6 package (Oksanen et al., 2019).

#### Dependencies
* _ggplot2_
* _reshape2_
* _vegan_
* _RColorBrewer_

#### Steps
1. Import data
2. Richness calculation 
3. Shannon's diversity index calculation 
4. Simpson's diversity index calculation

   ->each step creates a barplot of individual samples, pairwise Wilcox test, Kruskal-Wallis test for multiple comparisons and boxplot of sites/treatments signaling the mean

#### Example outputs

_____________________________

## non-metric_multidimensional_scaling.R
Non-Metric Multidimensional Scaling (NMDS) is an non-marametric ordination analysis widely (but not exclusively) used in microbial ecology. It uses a dissimilarity matrix to arrange samples into a 2D plane depending on its taxonomic or functional composition. Although there are  many dissimilarity matrices for many different purposes (see _vegan_ documentation), Bray-Curtis dissimilarity matrix is the most used for microbial ecology studies.

#### Dependencies
* _ggplot2_
* _reshape2_
* _vegan_
* _RColorBrewer_
* _data.table_

#### Steps
1. Import data
2. Data checking (normalization, Bray-Curtis dissimilarity matrix calculation, anova of beta dispersion)
3. Statistical comparisons of sites/treatments (permanova, anosim)
4. NMDS (stress score calculation and plotting, NMDS plot)

#### Example outputs

_____________________________________

## stacked_barplots.R
For further visualization of the composition of different samples in terms of relative abundance. Minimum relative abundance threshold can be adjusted at will.

#### Dependencies
* _ggplot2_
* _reshape2_
* _RColorBrewer_

#### Steps
1. Import data
2. Data normalization
3. Threshold of minimum relative abundance (default: 0.005)
4. Plotting

#### Example outputs

_________________________________


## indicators.R
This script is based on the____

#### Dependencies
* _indicspecies_
* _ggplot2_
* _reshape2_
* _vegan_
* _data.table_

#### Steps
1. Import data
2. Data normalization
3. Indicator analysis
4. P-value correction (Benjamini-Hochberg)

#### Example outputs

_____________________________


# Credits
* Manuel García-Ulloa (https://github.com/manuelgug)
* Some parts of the diversity.R, non-metric_multidimensional_scaling.R and indicators.R scripts were based on jkzorz's tutorials (https://github.com/jkzorz/jkzorz.github.io)
* Sample data comes from publicly available Eastern Mediterranean 16s Survey project https://www.mg-rast.org/mgmain.html?mgpage=project&project=mgp10029

## References

Oksanen, J., Blanchet, F. G., Friendly, M., Kindt, R., Legendre, P., McGlinn, D., ... & Wagner, H. (2019). vegan: Community Ecology Package. R package version 2.5–6. 2019.
