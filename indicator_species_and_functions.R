
#setwd("") #set working directory

library(indicspecies)
library(vegan)
library(reshape2)
library(ggplot2)
library(data.table)

#Import data----

##import species and subsystems count tables
abund<-read.csv("abundance_table.csv", sep =",", header = T, row.names= 1)
#remove columns that sum 0 (taxa or function is absent)
abund<-abund[, colSums(abund != 0) > 0]

#import sites
sites<-as.data.frame(read.csv("sites.csv", header=F, as.is = T))

##Data checking----

#normalization (relative abundance calculation)
spc_relabun<-decostand(abund,"total")

#####Indicator Species Analysis----

indic <- multipatt(spc_relabun, sites$V2, func = "r.g", control = how(nperm=9999))
summary(indic) #this is without p-calue adjustment

##adjusted p-values with Benjamini-Hochberg correction
indic_sign<-as.data.table(indic$sign, keep.rownames=TRUE)
indic_sign[ ,p.value.bh:=p.adjust(p.value, method="BH")]
indic_sign_p_adj<-indic_sign[p.value.bh<=0.05, ]
indic_sign_p_adj #if table is empty, no indicators were found after p-value adjustment

