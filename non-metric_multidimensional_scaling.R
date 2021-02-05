
#setwd("") #set working directory

library(vegan)
library(reshape2)
library(ggplot2)
library(data.table)
library(RColorBrewer)

#Import data----

##import abundance/count table
abund<-read.csv("abundance_table.csv", sep =",", header = T, row.names= 1)
#remove columns that sum 0 (taxa or function is absent)
abund<-abund[, colSums(abund != 0) > 0]

#import sites
sites<-as.data.frame(read.csv("sites.csv", header=F, as.is = T))


##Data checking----

#normalization (relative abundance calculation)
relabun<-decostand(abund,"total")

#braycurtis dissimilarity matrix of relative abundances calculation
BC<-vegdist(relabun, "bray")

#anova of beta dispersion: p > 0.05 means sites are comparable
anova(betadisper(BC, sites$V2, type = c("median")))


###Statistical comparison----

#are there statistically significant differences between sites?
#permanova
adonis_abund <- adonis(abund ~ sites$V2, permutations=1000, method="bray"); adonis_abund
#anosim
anosim_relabun <-anosim(relabun, sites$V2, distance = "bray", permutations = 9999); anosim_relabun

####Visualization through Non-metric Multi Dimensional Scaling----

#NMDS of species Bray-Curtis dissimilarity matrix
NMDS <-metaMDS(relabun, k=2, distance = "bray", trymax=1000)

#Validation of NMDS through stress score: < 0.05 = excellent; < 0.1 = great; < 0.2 = ok,  > 0.3 = poor
NMDS$stress
png("stress_plot.png", units="in", width=5, height=5, res=300)
stressplot(NMDS)
dev.off()

#plot NMDS
NMDS_SCORES<-as.data.frame(scores(NMDS))
NMDS_SCORES$treat<-sites$V2

ggplot(NMDS_SCORES, aes(x = NMDS1, y = NMDS2))+
  geom_point(size = 5.5, aes(color = sites$V2))+
  scale_colour_manual(values=c(colorRamps::primary.colors(length(sites$V1),length(unique(sites$V2)), T)))+ 
  theme(legend.title = element_blank())

#add sample labels if needed
ggplot(NMDS_SCORES, aes(x = NMDS1, y = NMDS2, label=sites$V1))+
  geom_point(size = 3.5, aes(color = sites$V2))+ 
  geom_text(aes(label=sites$V1),hjust=0, vjust=0)+
  scale_colour_manual(values=c(colorRamps::primary.colors(length(sites$V1),length(unique(sites$V2)), T)))+
  ggtitle("Species NMDS") + 
  theme(legend.title = element_blank())

