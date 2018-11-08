#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

#library(shiny)
library(cowplot)
library(data.table)

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
        +ylab("total genera")
        +xlab("Geologic Time (Ma)")
        +theme(legend.position="bottom")+ labs(color="")
        )
    })
    
    output$selectivity_plot <- renderPlot({
      #modify the dataframe according to selected groups
      selectivity_output <- selectivityDF[selectivityDF$comparison == input$hypothesis,] 
      
      #make the plot
      (ggplot(selectivity_output, aes(x = max_ma, y = relN, color = group))
        +geom_vline(xintercept = c(252.2), color = "gray70", size = 2)
        +geom_point()+geom_line()
        +scale_x_reverse()
        +ylab("percent total genera\n(within group)")
        +xlab("Geologic Time (Ma)")
        +ggtitle(input$hypothesis) 
      )
    }) 
    
    output$design_plot <- renderPlot({
      #read the data
      #pbdb_data<-fread(input$pbdbURL,skip = 20 )
      pbdb_data<-fread("https://paleobiodb.org/data1.2/occs/diversity.csv?datainfo&rowcount&base_name=mammalia&count=genera",skip = 20 )
    
      
      #prep the data
      pbdb_data$diversity <- pbdb_data$X_Ft + pbdb_data$X_bL + pbdb_data$X_FL + pbdb_data$X_bt
      #make the plot
      (ggplot(pbdb_data, aes(x = max_ma, y = diversity))
        +geom_point()+geom_line()
        +scale_x_reverse()
        +ylab("total genera\n(within group)")
        +xlab("Geologic Time (Ma)")
      )
    }) 

})
