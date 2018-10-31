library(shiny)

 #load the data
setwd("/Users/abigailkelly/Desktop/Teaching\ Geoscience/THEGREATDYING/ExtinctionExplorationApp/ExtinctionExploration")

 diversityDF <- read.csv("./data/diversity_data.csv")
 selectivityDF <- read.csv("./data/selectivity.csv")
 
# #group names for checkbox labels
 group_names <- levels(read.csv("./data/diversity_data.csv")$group)
 hypotheses  <- levels(read.csv("./data/selectivity.csv")$comparison)
