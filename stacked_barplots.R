
#setwd("") #set working directory

library(reshape2)
library(ggplot2)
library(RColorBrewer)

#Import data----

##import species and subsystems count tables
abund<-read.csv("abundance_table.csv", sep =",", header = T, row.names= 1)
#remove columns that sum 0 (taxa or function is absent)
abund<-abund[, colSums(abund != 0) > 0]

#import sites
sites<-as.data.frame(read.csv("sites.csv", header=F, as.is = T))

##Data checking----

#normalization (relative abundance calculation)
relabun<-decostand(abund,"total")

######Species (taxonomic) stacked bar plot----

names<-rownames(abund)
relabun2<- cbind(names, relabun)

#sort columns as in sites$V1 and keep their factor levels to visualize them grouped by site 
relabun2$rowsnames<-rownames(relabun2)
new_order <- sapply(sites$V1, function(x,relabun2){which(relabun2$rowsnames == x)}, relabun2=relabun2)
relabun2 <- relabun2[new_order,]
relabun2 <-relabun2[,-length(colnames(relabun2))]
relabun2$names <- factor(relabun2$names,levels = relabun2$names)

#melt
relabun2_melted <- melt(relabun2, id = c("names"))

#subset to species with minimum relative abundance of 0.005 (adjust to personal preference)
relabun2_melted_subset<-subset(relabun2_melted, relabun2_melted$value > 0.005)

#color randomizer for better visualization
n <- length(relabun2_melted_subset$value)
qual_col_pals <- brewer.pal.info[brewer.pal.info$category == 'qual',]
col_vector <- unlist(mapply(brewer.pal, qual_col_pals$maxcolors, rownames(qual_col_pals)))

#plot
ggplot(relabun2_melted_subset, aes(x = names, fill = variable, y = value)) + 
  geom_bar(stat = "identity", colour = "black") + 
  theme(axis.text.x = element_text(angle = 90, size = 10, colour = "black", vjust = 0.5, hjust = 1), 
        axis.title.y = element_text(size = 16, face = "bold"), legend.title = element_text(size = 16, face = "bold"), 
        legend.text = element_text(size = 7, colour = "black"), 
        axis.text.y = element_text(colour = "black", size = 12, face = "bold")) + 
  scale_y_continuous(expand = c(0,0)) + 
  labs(x = "", y = "Relative Abundance", fill = "> 0.5% relative abundance")+ 
  scale_fill_manual(values=col_vector)+
  guides(fill=guide_legend(ncol=3)) #adjust number of columns for the legends
