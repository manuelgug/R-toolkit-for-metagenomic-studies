#set working directory
setwd("")

library(vegan)
library(ggplot2)
library(reshape2)
library(RColorBrewer)

#Import data----

##import species and subsystems count tables
species_count<-read.csv("species_count.csv", sep =",", header = T, row.names= 1, stringsAsFactors = F)
subsystems_count<-read.csv("subsystems_count.csv", sep =",", header = T, row.names= 1)

#import sites
sites<-as.data.frame(read.csv("sites.csv", header=F, as.is = T))

####-----SPECIES (taxonomic analysis)########
#species richness----
barplot(specnumber(species_count)) #samples
barplot(tapply(specnumber(species_count), sites$V2,	 FUN=mean)) #sites
#pairwise.wilcox.test un-paired: species richness
species_count_specnumber<-specnumber(species_count, sites$V1)
species_count_specnumber_wilcox<-pairwise.wilcox.test(species_count_specnumber,sites$V2,"BH", paired=F, exact =F)
species_count_specnumber_wilcox$p.value
#krustal wallis for multiple comparisons: species richness
kruskal.test(species_count_specnumber, as.factor(sites$V2))

#input for ggplot2
species_count_specnumber<-as.data.frame(species_count_specnumber)
species_count_specnumber_melted<-cbind(species_count_specnumber,sites$V2)

#boxplot
n <- length(unique(sites$V2))
qual_col_pals <- brewer.pal.info[brewer.pal.info$category == 'qual',]
col_vector <- unlist(mapply(brewer.pal, qual_col_pals$maxcolors, rownames(qual_col_pals)))

ggplot(as.data.frame(species_count_specnumber_melted), aes(x=sites$V2, y=species_count_specnumber)) +
  geom_boxplot(aes(fill=sites$V2))+
  theme(axis.text.x = element_text(angle = 45, size = 12, colour = "black", vjust = 1, hjust = 1), 
        axis.title.y = element_text(size = 16, face = "bold"), legend.title = element_text(size = 16, face = "bold"), 
        legend.text = element_text(size = 7, colour = "black"), 
        axis.text.y = element_text(colour = "black", size = 10, face = "bold")) + 
  labs(x = "", y = "Species richness", fill = "Sites")+ 
  scale_fill_manual(values=col_vector)+
  guides(fill=guide_legend(ncol=1))+
  guides(fill=FALSE)+
  stat_summary(fun="mean", color="black", size =0.75, shape=4)

#Shannon's diversity index----
barplot(diversity(species_count, "shannon")) #samples
barplot(tapply(diversity(species_count, "shannon"), sites$V2,	 FUN=mean)) #sites
#pairwise.wilcox.test un-paired: Shannon's
species_shannon_specnumber<-diversity(species_count, "shannon")
species_shannon_specnumber_wilcox<-pairwise.wilcox.test(species_shannon_specnumber,sites$V2,"BH", paired=F, exact =F)
species_shannon_specnumber_wilcox$p.value
#krustal wallis for multiple comparisons: Shannon's
kruskal.test(species_shannon_specnumber, as.factor(sites$V2))

#input for ggplot2
species_shannon_specnumber<-as.data.frame(species_shannon_specnumber)
species_shannon_specnumber_melted<-cbind(species_shannon_specnumber,sites$V2)

#boxplot
n <- length(unique(sites$V2))
qual_col_pals <- brewer.pal.info[brewer.pal.info$category == 'qual',]
col_vector <- unlist(mapply(brewer.pal, qual_col_pals$maxcolors, rownames(qual_col_pals)))

ggplot(as.data.frame(species_shannon_specnumber_melted), aes(x=sites$V2, y=species_shannon_specnumber)) +
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
barplot(diversity(species_count, "simpson"))
barplot(tapply(diversity(species_count, "simpson"), sites$V2,	 FUN=mean))
#pairwise.wilcox.test un-paired: Simpson's
species_simpson_specnumber<-diversity(species_count, "simpson")
species_simpson_specnumber_wilcox<-pairwise.wilcox.test(species_simpson_specnumber,sites$V2,"BH", paired=F, exact =F)
species_simpson_specnumber_wilcox$p.value
#krustal wallis for multiple comparisons: Simpson's
kruskal.test(species_simpson_specnumber, as.factor(sites$V2))

#input for ggplot2
species_simpson_specnumber<-as.data.frame(species_simpson_specnumber)
species_simpson_specnumber_melted<-cbind(species_simpson_specnumber,sites$V2)

#boxplot
n <- length(unique(sites$V2))
qual_col_pals <- brewer.pal.info[brewer.pal.info$category == 'qual',]
col_vector <- unlist(mapply(brewer.pal, qual_col_pals$maxcolors, rownames(qual_col_pals)))

ggplot(as.data.frame(species_simpson_specnumber_melted), aes(x=sites$V2, y=species_simpson_specnumber)) +
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


####-----SUBSYSTEMS (functional analysis)####----
#subsystems richness----
barplot(specnumber(subsystems_count)) #samples
barplot(tapply(specnumber(subsystems_count), sites$V2,	 FUN=mean)) #sites
#pairwise.wilcox.test un-paired: subsystems richness
subsystems_count_specnumber<-specnumber(subsystems_count, sites$V1)
subsystems_count_specnumber_wilcox<-pairwise.wilcox.test(subsystems_count_specnumber,sites$V2,"BH", paired=F, exact =F)
subsystems_count_specnumber_wilcox$p.value
#krustal wallis for multiple comparisons: subsystems richness
kruskal.test(subsystems_count_specnumber, as.factor(sites$V2))

#input for ggplot2
subsystems_count_specnumber<-as.data.frame(subsystems_count_specnumber)
subsystems_count_specnumber_melted<-cbind(subsystems_count_specnumber,sites$V2)

#boxplot
n <- length(unique(sites$V2))
qual_col_pals <- brewer.pal.info[brewer.pal.info$category == 'qual',]
col_vector <- unlist(mapply(brewer.pal, qual_col_pals$maxcolors, rownames(qual_col_pals)))

ggplot(as.data.frame(subsystems_count_specnumber_melted), aes(x=sites$V2, y=subsystems_count_specnumber)) +
  geom_boxplot(aes(fill=sites$V2))+
  theme(axis.text.x = element_text(angle = 45, size = 12, colour = "black", vjust = 1, hjust = 1), 
        axis.title.y = element_text(size = 16, face = "bold"), legend.title = element_text(size = 16, face = "bold"), 
        legend.text = element_text(size = 7, colour = "black"), 
        axis.text.y = element_text(colour = "black", size = 10, face = "bold")) + 
  labs(x = "", y = "subsystems richness", fill = "Sites")+ 
  scale_fill_manual(values=col_vector)+
  guides(fill=guide_legend(ncol=1))+
  guides(fill=FALSE)+
  stat_summary(fun="mean", color="black", size =0.75, shape=4)

#Shannon's diversity index----
barplot(diversity(subsystems_count, "shannon")) #samples
barplot(tapply(diversity(subsystems_count, "shannon"), sites$V2,	 FUN=mean)) #sites
#pairwise.wilcox.test un-paired: Shannon's
subsystems_shannon_specnumber<-diversity(subsystems_count, "shannon")
subsystems_shannon_specnumber_wilcox<-pairwise.wilcox.test(subsystems_shannon_specnumber,sites$V2,"BH", paired=F, exact =F)
subsystems_shannon_specnumber_wilcox$p.value
#krustal wallis for multiple comparisons: Shannon's
kruskal.test(subsystems_shannon_specnumber, as.factor(sites$V2))

#input for ggplot2
subsystems_shannon_specnumber<-as.data.frame(subsystems_shannon_specnumber)
subsystems_shannon_specnumber_melted<-cbind(subsystems_shannon_specnumber,sites$V2)

#boxplot
n <- length(unique(sites$V2))
qual_col_pals <- brewer.pal.info[brewer.pal.info$category == 'qual',]
col_vector <- unlist(mapply(brewer.pal, qual_col_pals$maxcolors, rownames(qual_col_pals)))

ggplot(as.data.frame(subsystems_shannon_specnumber_melted), aes(x=sites$V2, y=subsystems_shannon_specnumber)) +
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
barplot(diversity(subsystems_count, "simpson"))
barplot(tapply(diversity(subsystems_count, "simpson"), sites$V2,	 FUN=mean))
#pairwise.wilcox.test un-paired: Simpson's
subsystems_simpson_specnumber<-diversity(subsystems_count, "simpson")
subsystems_simpson_specnumber_wilcox<-pairwise.wilcox.test(subsystems_simpson_specnumber,sites$V2,"BH", paired=F, exact =F)
subsystems_simpson_specnumber_wilcox$p.value
#krustal wallis for multiple comparisons: Simpson's
kruskal.test(subsystems_simpson_specnumber, as.factor(sites$V2))

#input for ggplot2
subsystems_simpson_specnumber<-as.data.frame(subsystems_simpson_specnumber)
subsystems_simpson_specnumber_melted<-cbind(subsystems_simpson_specnumber,sites$V2)

#boxplot
n <- length(unique(sites$V2))
qual_col_pals <- brewer.pal.info[brewer.pal.info$category == 'qual',]
col_vector <- unlist(mapply(brewer.pal, qual_col_pals$maxcolors, rownames(qual_col_pals)))

ggplot(as.data.frame(subsystems_simpson_specnumber_melted), aes(x=sites$V2, y=subsystems_simpson_specnumber)) +
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

