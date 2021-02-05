
#setwd("") #set working directory

library(vegan)
library(ggplot2)
library(reshape2)
library(RColorBrewer)

#Import data----

##import species and subsystems count tables
abund<-read.csv("abundance_table.csv", sep =",", header = T, row.names= 1, stringsAsFactors = F)
#remove columns that sum 0 (taxa or function is absent)
abund<-abund[, colSums(abund != 0) > 0]

#import sites
sites<-as.data.frame(read.csv("sites.csv", header=F, as.is = T))

#color vector for boxplots
n <- length(unique(sites$V2))
qual_col_pals <- brewer.pal.info[brewer.pal.info$category == 'qual',]
col_vector <- unlist(mapply(brewer.pal, qual_col_pals$maxcolors, rownames(qual_col_pals)))

#Richness----
#pairwise.wilcox.test un-paired: richness
abund_richness<-specnumber(abund, sites$V1)
abund_richness_wilcox<-pairwise.wilcox.test(abund_richness,sites$V2,"BH", paired=F, exact =F)
abund_richness_wilcox$p.value
#krustal wallis for multiple comparisons: richness
kruskal.test(abund_richness, as.factor(sites$V2))

#input for ggplot2
abund_richness<-as.data.frame(abund_richness)
abund_richness_melted<-cbind(abund_richness,sites$V2)

#boxplot
ggplot(as.data.frame(abund_richness_melted), aes(x=sites$V2, y=abund_richness)) +
  geom_boxplot(aes(fill=sites$V2))+
  theme(axis.text.x = element_text(angle = 45, size = 12, colour = "black", vjust = 1, hjust = 1), 
        axis.title.y = element_text(size = 16, face = "bold"), legend.title = element_text(size = 16, face = "bold"), 
        legend.text = element_text(size = 7, colour = "black"), 
        axis.text.y = element_text(colour = "black", size = 10, face = "bold")) + 
  labs(x = "", y = "Richness", fill = "Sites")+ 
  scale_fill_manual(values=col_vector)+
  guides(fill=guide_legend(ncol=1))+
  guides(fill=FALSE)+
  stat_summary(fun="mean", color="black", size =0.75, shape=4)

#Shannon's diversity index----
#pairwise.wilcox.test un-paired: Shannon's
shannon<-diversity(abund, "shannon")
shannon_wilcox<-pairwise.wilcox.test(shannon,sites$V2,"BH", paired=F, exact =F)
shannon_wilcox$p.value
#krustal wallis for multiple comparisons: Shannon's
kruskal.test(shannon, as.factor(sites$V2))

#input for ggplot2
shannon<-as.data.frame(shannon)
shannon_melted<-cbind(shannon,sites$V2)

#boxplot
ggplot(as.data.frame(shannon_melted), aes(x=sites$V2, y=shannon)) +
  geom_boxplot(aes(fill=sites$V2))+
  theme(axis.text.x = element_text(angle = 45, size = 12, colour = "black", vjust = 1, hjust = 1), 
        axis.title.y = element_text(size = 16, face = "bold"), legend.title = element_text(size = 16, face = "bold"), 
        legend.text = element_text(size = 7, colour = "black"), 
        axis.text.y = element_text(colour = "black", size = 10, face = "bold")) + 
  labs(x = "", y = "Shannon", fill = "Sites")+ 
  scale_fill_manual(values=col_vector)+
  guides(fill=guide_legend(ncol=1))+
  guides(fill=FALSE)+
  stat_summary(fun="mean", color="black", size =0.75, shape=4)

#Simpson's diversity index----
#pairwise.wilcox.test un-paired: Simpson's
simpson<-diversity(abund, "simpson")
simpson_wilcox<-pairwise.wilcox.test(simpson,sites$V2,"BH", paired=F, exact =F)
simpson_wilcox$p.value
#krustal wallis for multiple comparisons: Simpson's
kruskal.test(simpson, as.factor(sites$V2))

#input for ggplot2
simpson<-as.data.frame(simpson)
simpson_melted<-cbind(simpson,sites$V2)

#boxplot
ggplot(as.data.frame(simpson_melted), aes(x=sites$V2, y=simpson)) +
  geom_boxplot(aes(fill=sites$V2))+
  theme(axis.text.x = element_text(angle = 45, size = 12, colour = "black", vjust = 1, hjust = 1), 
        axis.title.y = element_text(size = 16, face = "bold"), legend.title = element_text(size = 16, face = "bold"), 
        legend.text = element_text(size = 7, colour = "black"), 
        axis.text.y = element_text(colour = "black", size = 10, face = "bold")) + 
  labs(x = "", y = "Simpson", fill = "Sites")+ 
  scale_fill_manual(values=col_vector)+
  guides(fill=guide_legend(ncol=1))+
  guides(fill=FALSE)+
  stat_summary(fun="mean", color="black", size =0.75, shape=4)

