# R Toolkit for Metagenomic Studies

This repository contains 4 scripts for easy processing and visualization of metagenomic data. 

You will need: 
* An abundance table (OTUs or any taxonomic or functional annotation) of samples.
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

## diversity.R
This script provides richness as well Shannon and Simpson alpha diversity metrics as calculated by vegan 2.5-6 package (Oksanen et al., 2019).

#### Dependencies
* _ggplot2_
* _reshape2_
* _vegan_
* _RColorBrewer_

#### Example outputs


## References

Oksanen, J., Blanchet, F. G., Friendly, M., Kindt, R., Legendre, P., McGlinn, D., ... & Wagner, H. (2019). vegan: Community Ecology Package. R package version 2.5–6. 2019.
