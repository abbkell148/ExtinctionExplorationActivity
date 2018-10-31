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

# Define server logic ...
shinyServer(function(input, output, session) {

 observe({
   updateCheckboxGroupInput(
     session, 'group', choices = group_names,
     selected = if (input$select) group_names
   )
 })
   
    output$standard_diversity_plot <- renderPlot({
      #modify the dataframe according to selected groups
      diversity_output <- diversityDF[diversityDF$group %in% input$group,] 
    
      #make the plot
      (ggplot(diversity_output, aes(x = max_ma, y = relN, color = group))
        +geom_vline(xintercept = c(252), color = "gray70", size = 2)
        +geom_vline(xintercept = c(444, 65, 201), color = "gray90", size = 1)
        +annotate("rect", xmax=376, xmin = 359, ymin=-Inf, ymax= Inf, fill ="gray90")
        +geom_point()+geom_line()
        +scale_x_reverse()
        +ylab("percent total genera\n(within group)")
        +xlab("Geologic Time (Ma)")
        +theme(legend.position="bottom") + labs(color="")
      )
    })
  
    output$raw_diversity_plot <- renderPlot({
      #modify the dataframe according to selected groups
      diversity_output <- diversityDF[diversityDF$group %in% input$group,] 
      
      #make the plot
      (ggplot(diversity_output, aes(x = max_ma, y = N, color = group))
        +geom_vline(xintercept = c(252), color = "gray70", size = 2)
        +geom_vline(xintercept = c(444, 65, 201), color = "gray90", size = 1)
        +annotate("rect", xmax=376, xmin = 359, ymin=-Inf, ymax= Inf, fill ="gray90")
        +geom_point()+geom_line()
        +scale_x_reverse()
        +ylab("percent total genera\n(within group)")
        +xlab("Geologic Time (Ma)")
        +theme(legend.position="bottom")+ labs(color="")
        )
    })
  
})
