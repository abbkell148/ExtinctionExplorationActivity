library(shiny)
library(data.table)
library(curl)
library(cowplot)

#load the data
#setwd("/Users/abigailkelly/Desktop/Teaching\ Geoscience/THEGREATDYING/ExtinctionExplorationApp/ExtinctionExploration")

 diversityDF <- read.csv("./data/diversity_data.csv")
 diversityDF$mid_ma <- (diversityDF$max_ma + diversityDF$min_ma)/2
 selectivityDF <- read.csv("./data/selectivity.csv")
 selectivityDF$mid_ma <- (selectivityDF$max_ma + selectivityDF$min_ma)/2
 
 
# #group names for checkbox labels
 group_names <- c('Animals (all)','Ammonites',  'Arthropods', 'Arthropods: insects', 'Arthropods: trilobites', 'Brachiopods', 'Bryozoans', 'Corals (all)', 'Corals: rugose', 'Corals: scleractinian', 'Corals: tabulate', 'Echinodermata (all)', 'Echinodermata: crinoids', 'Echinodermata: sea stars', 'Echinodermata: sea urchins', 'Fish: bony', 'Fish: cartilaginous', 'Molluscs (all)', 'Molluscs: bivalves', 'Molluscs: gastropods')

 hypotheses  <- levels(read.csv("./data/selectivity.csv")$comparison)
 
 timescale <- unique(diversityDF[ ,c("max_ma","min_ma", "period") ])
 timescale1 <- aggregate(data=timescale, min_ma~ period, FUN=min)
 timescale2 <- aggregate(data=timescale, max_ma~ period, FUN=max)
 timescale <- merge(timescale1, timescale2)
 timescale$mid_ma <- (timescale$min_ma + timescale$max_ma)/2
 timescale <- timescale[order(timescale$min_ma),]
 
 