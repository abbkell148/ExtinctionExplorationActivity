#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(cowplot)

#load the data
directory <- getwd()
diversitypath <- paste(directory, "/data/diversity_data.csv", sep="")
diversityDF <- read.csv(diversitypath)

#group names for checkbox labels
group_names <- levels(diversityDF$group)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
   
  output$standard_diversity_plot <- renderPlot({
    
    #modify the dataframe according to selected groups
    diversity_output <- diversityDF[diversityDF$group %in% input$group,]
    #diversity_output <- diversityDF[diversityDF$group %in% c("animalia"),]
    
    
    #make the plot
    (ggplot(diversity_output, aes(x = max_ma, y = relN, color = group))
      +geom_vline(xintercept = c(252), color = "gray70", size = 2)
      +geom_vline(xintercept = c(444, 65, 201), color = "gray90", size = 1)
      +annotate("rect", xmax=376, xmin = 359, ymin=-Inf, ymax= Inf, fill ="gray90")
      +geom_point()+geom_line()
      +scale_x_reverse()
      +ylab("percent total genera\n(within group)")
      +xlab("Geologic Time (Ma)"))
    

    
  })
  
  output$raw_diversity_plot <- renderPlot({
    
    # generate bins based on input$bins from ui.R
    x    <- rnorm(100)
    y    <- x^2
    
    
    # draw the histogram with the specified number of bins
    plot(y~x, main = paste0(input$group, sep = " and "))
    
  })
 
 output$distPlot3 <- renderPlot({
   
   # generate bins based on input$bins from ui.R
   x    <- rnorm(100)
   y <- x 
   
   
   # draw the histogram with the specified number of bins
   plot(y~x)
   
 })
  
})
