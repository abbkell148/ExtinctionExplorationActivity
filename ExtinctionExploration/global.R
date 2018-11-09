library(shiny)
library(data.table)
library(curl)
library(cowplot)

#load the data
#setwd("/Users/abigailkelly/Desktop/Teaching\ Geoscience/THEGREATDYING/ExtinctionExplorationApp/ExtinctionExploration")

 diversityDF <- read.csv("./data/diversity_data.csv")
 selectivityDF <- read.csv("./data/selectivity.csv")
 
# #group names for checkbox labels
 group_names <- c('Animals (all)','Ammonites',  'Arthropods', 'Arthropods: insects', 'Arthropods: trilobites', 'Brachiopods', 'Bryozoans', 'Corals (all)', 'Corals: rugose', 'Corals: scleractinian', 'Corals: tabulate', 'Echinoids (all)', 'Echinoids: crinoids', 'Echinoids: sea stars', 'Echinoids: sea urchins', 'Fish: bony', 'Fish: cartilaginous', 'Molluscs (all)', 'Molluscs: bivalves', 'Molluscs: gastropods')

 hypotheses  <- levels(read.csv("./data/selectivity.csv")$comparison)
 
 #timescale <- unique(diversityDF[select = c(,"max_ma","min_ma", "period")])
