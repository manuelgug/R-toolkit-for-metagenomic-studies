#set working directory
setwd("")

library(reshape2)
library(ggplot2)
library(RColorBrewer)

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

######Species (taxonomic) stacked bar plot----

names<-rownames(species_count)
spc_relabun2<- cbind(names, spc_relabun)
spc_relabun2_melted <- melt(spc_relabun2, id = c("names"))

#subset to species with minimum relative abundance of 0.005 (adjust to personal preference)
spc_relabun2_melted_subset<-subset(spc_relabun2_melted, spc_relabun2_melted$value > 0.005)

#color randomizer for better visualization
n <- length(spc_relabun2_melted_subset$value)
qual_col_pals <- brewer.pal.info[brewer.pal.info$category == 'qual',]
col_vector <- unlist(mapply(brewer.pal, qual_col_pals$maxcolors, rownames(qual_col_pals)))

#plot
ggplot(spc_relabun2_melted_subset, aes(x = names, fill = variable, y = value)) + 
  geom_bar(stat = "identity", colour = "black") + 
  theme(axis.text.x = element_text(angle = 90, size = 10, colour = "black", vjust = 0.5, hjust = 1), 
        axis.title.y = element_text(size = 16, face = "bold"), legend.title = element_text(size = 16, face = "bold"), 
        legend.text = element_text(size = 7, colour = "black"), 
        axis.text.y = element_text(colour = "black", size = 12, face = "bold")) + 
  scale_y_continuous(expand = c(0,0)) + 
  labs(x = "", y = "Relative Abundance (%)", fill = "Species > 0.5% relative abundance")+ 
  scale_fill_manual(values=col_vector)+
  guides(fill=guide_legend(ncol=3)) #adjust number of columns for the legends

######Subsystems (functional) Stacked bar plot----

names<-rownames(subsystems_count)
sub_relabun2<- cbind(names, sub_relabun)
sub_relabun2_melted <- melt(sub_relabun2, id = c("names"))

#subset to subsystems with minimum relative abundance of 0.005 (adjust to personal preference)
sub_relabun2_melted_subset<-subset(sub_relabun2_melted, sub_relabun2_melted$value > 0.005)

#color randomizer for better visualization
n <- length(sub_relabun2_melted_subset$value)
qual_col_pals <- brewer.pal.info[brewer.pal.info$category == 'qual',]
col_vector <- unlist(mapply(brewer.pal, qual_col_pals$maxcolors, rownames(qual_col_pals)))

#plot
ggplot(sub_relabun2_melted_subset, aes(x = names, fill = variable, y = value)) + 
  geom_bar(stat = "identity", colour = "black") + 
  theme(axis.text.x = element_text(angle = 90, size = 10, colour = "black", vjust = 0.5, hjust = 1), 
        axis.title.y = element_text(size = 16, face = "bold"), legend.title = element_text(size = 16, face = "bold"), 
        legend.text = element_text(size = 7, colour = "black"), 
        axis.text.y = element_text(colour = "black", size = 12, face = "bold")) + 
  scale_y_continuous(expand = c(0,0)) + 
  labs(x = "", y = "Relative Abundance (%)", fill = "Subsystems > 0.5% relative abundance")+ 
  scale_fill_manual(values=col_vector)+
  guides(fill=guide_legend(ncol=2)) #adjust number of columns for the legends
