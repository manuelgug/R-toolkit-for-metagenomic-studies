#set working directory
setwd("")

#some parts of this script were based on jkzorz's tutorials (https://github.com/jkzorz/jkzorz.github.io)

library(vegan)
library(reshape2)
library(ggplot2)
library(data.table)
library(RColorBrewer)

#Import data----

##import species and subsystems count tables
species_count<-read.csv("species_count.csv", sep =",", header = T, row.names= 1)
subsystems_count<-read.csv("subsystems_count.csv", sep =",", header = T, row.names= 1)

#import sites
sites<-as.data.frame(read.csv("sites.csv", header=F, as.is = T))


####-----SPECIES (taxonomic analysis)####
##Data checking----

#normalization (relative abundance calculation)
spc_relabun<-decostand(species_count,"total")

#braycurtis dissimilarity matrix of relative abundances calculation
spc_BC<-vegdist(spc_relabun, "bray")

#anova of beta dispersion: p > 0.05 means sites are comparable
anova(betadisper(spc_BC, sites$V2, type = c("median")))


###Statistical comparison----

#are there statistically significant differences between sites?
#permanova
adonis_species <- adonis(species_count ~ sites$V2, permutations=1000, method="bray"); adonis_species
#anosim
anosim_species <-anosim(spc_relabun, sites$V2, distance = "bray", permutations = 9999); anosim_species

####Visualization through Non-metric Multi Dimensional Scaling----

#NMDS of species Bray-Curtis dissimilarity matrix
NMDS_species <-metaMDS(spc_relabun, k=2, distance = "bray", trymax=1000)

#Validation of NMDS through stress score: < 0.05 = excellent; < 0.1 = great; < 0.2 = ok,  > 0.3 = poor
NMDS_species$stress
stressplot(NMDS_species)

#plot NMDS
NMDS_species_SCORES<-as.data.frame(scores(NMDS_species))
NMDS_species_SCORES$treat<-sites$V2

ggplot(NMDS_species_SCORES, aes(x = NMDS1, y = NMDS2))+
  geom_point(size = 5.5, aes(color = sites$V2))+
  scale_colour_manual(values=c(colorRamps::primary.colors(length(sites$V1),2, T)))+
  ggtitle("Species NMDS") + labs(fill = "Sites")

#add sample labels
ggplot(NMDS_species_SCORES, aes(x = NMDS1, y = NMDS2, label=sites$V1))+
  geom_point(size = 3.5, aes(color = sites$V2))+ 
  geom_text(aes(label=sites$V1),hjust=0, vjust=0)+
  scale_colour_manual(values=c(colorRamps::primary.colors(length(sites$V1),2, T)))+
  ggtitle("Species NMDS") + labs(fill = "Site")


####-----SUBSYSTEMS (functional analysis)########
##Data checking----

#normalization (relative abundance calculation)
sub_relabun<-decostand(subsystems_count,"total")

#braycurtis dissimilarity matrix of relative abundances calculation
sub_BC<-vegdist(sub_relabun, "bray")

#anova of beta dispersion: p > 0.05 means sites are comparable
anova(betadisper(sub_BC, sites$V2, type = c("median")))


###Statistical comparison----

#are there statistically significant differences between groups?
#permanova
adonis_subsystems <- adonis(subsystems_count ~ sites$V2, permutations=1000, method="bray"); adonis_subsystems
#anosim
anosim_subsystems <-anosim(sub_relabun, sites$V2, distance = "bray", permutations = 9999); anosim_subsystems

####Visualization through Non-metric Multi Dimensional Scaling----

#NMDS of subsystems Bray-Curtis dissimilarity matrix
NMDS_subsystems <-metaMDS(sub_relabun, k=2, distance = "bray", trymax=1000)

#Validation of NMDS through stress score: < 0.05 = excellent; < 0.1 = great; < 0.2 = ok,  > 0.3 = poor
NMDS_subsystems$stress
stressplot(NMDS_subsystems)

#plot NMDS
NMDS_subsystems_SCORES<-as.data.frame(scores(NMDS_subsystems))
NMDS_subsystems_SCORES$treat<-sites$V2

ggplot(NMDS_subsystems_SCORES, aes(x = NMDS1, y = NMDS2))+
  geom_point(size = 5.5, aes(color = sites$V2))+
  scale_colour_manual(values=c(colorRamps::primary.colors(length(sites$V1),2, T)))+
  ggtitle("subsystems NMDS") + labs(fill = "Site")

#add sample labels
ggplot(NMDS_subsystems_SCORES, aes(x = NMDS1, y = NMDS2, label=sites$V1))+
  geom_point(size = 3.5, aes(color = sites$V2))+ 
  geom_text(aes(label=sites$V1),hjust=0, vjust=0)+
  scale_colour_manual(values=c(colorRamps::primary.colors(length(sites$V1),2, T)))+
  ggtitle("subsystems NMDS") + labs(fill = "Site")


