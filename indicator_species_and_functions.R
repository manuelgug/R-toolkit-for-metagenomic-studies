#set working directory
setwd("")

#some parts of this script were based on jkzorz's tutorials (https://github.com/jkzorz/jkzorz.github.io)

library(indicspecies)
library(vegan)
library(reshape2)
library(ggplot2)
library(data.table)

#Import data----

##import species and subsystems count tables
species_count<-read.csv("species_count.csv", sep =",", header = T, row.names= 1)
subsystems_count<-read.csv("subsystems_count.csv", sep =",", header = T, row.names= 1)

#import sites
sites<-as.data.frame(read.csv("sites.csv", header=F, as.is = T))

##Data checking----

#normalization (relative abundance calculation)
spc_relabun<-decostand(species_count,"total")
sub_relabun<-decostand(subsystems_count,"total")


#####Indicator Species Analysis----

indic_spec <- multipatt(spc_relabun, sites$V2, func = "r.g", control = how(nperm=9999))
summary(indic_spec)

##adjusted p-values with Benjamini-Hochberg correction
indic_spec_sign<-as.data.table(indic_spec$sign, keep.rownames=TRUE)
indic_spec_sign[ ,p.value.bh:=p.adjust(p.value, method="BH")]
indic_spec_sign_p_adj<-indic_spec_sign[p.value.bh<=0.05, ]
dim(indic_spec_sign_p_adj) #no indicator species after correction in this case


#####Indicator Subsystems Analysis----

indic_spec <- multipatt(sub_relabun, sites$V2, func = "r.g", control = how(nperm=9999))
summary(indic_spec)

##adjusted p-values with Benjamini-Hochberg correction
indic_spec_sign<-as.data.table(indic_spec$sign, keep.rownames=TRUE)
indic_spec_sign[ ,p.value.bh:=p.adjust(p.value, method="BH")]
indic_spec_sign_p_adj<-indic_spec_sign[p.value.bh<=0.05, ]
dim(indic_spec_sign_p_adj) #no indicator subsystems after correction in this case


