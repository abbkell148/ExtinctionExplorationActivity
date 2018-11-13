#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

#library(shiny)
#library(cowplot)
#library(data.table)

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
      yminv=0
      yscale = max(diversity_output$relN, na.rm=T)/12
    
      #make the plot
      (ggplot(diversity_output, aes(x = min_ma, y = relN, color = group))
        +geom_vline(xintercept = c(252), color = "gray70", size = 2)
        +geom_vline(xintercept = c(444, 65, 201), color = "gray90", size = 1)
        +annotate("rect", xmax=372.2, xmin = 359, ymin=-Inf, ymax= Inf, fill ="gray90")
        +geom_point()+geom_line()
        +ylab("Standardized Diversity \n(Percentange of Total Genera in Group)")
        +xlab("Geologic Time (Ma)")
        
        +theme(legend.position="bottom", axis.text.x = element_text(size=10))+ labs(color="")
        
        +scale_x_reverse(breaks = round(rev(timescale$min_ma),1))
        +annotate("rect", xmin=timescale$min_ma, xmax=timescale$max_ma, 
                  ymin=(yminv - .5*yscale), ymax=(yminv - 1.5*yscale),
                  fill="gray80",
                  size=.25,colour="black",alpha=1) 
        +annotate("text", x=timescale$mid_ma,y=(yminv - 1*yscale),label=timescale$period,size=4)
      )
    })
  
    output$raw_diversity_plot <- renderPlot({
      #modify the dataframe according to selected groups
      diversity_output <- diversityDF[diversityDF$group %in% input$group,] 
      yminv=0
      yscale = max(diversity_output$N, na.rm=T)/12
      
      #make the plot
      (ggplot(diversity_output, aes(x = min_ma, y = N, color = group))
        +geom_vline(xintercept = c(252), color = "gray70", size = 2)
        +geom_vline(xintercept = c(444, 65, 201), color = "gray90", size = 1)
        +annotate("rect", xmax=372.2, xmin = 359, ymin=-Inf, ymax= Inf, fill ="gray90")
        +geom_point()+geom_line()
        +ylab("Diversity: Genera in Bin")
        +xlab("Geologic Time (Ma)")
        +theme(legend.position="bottom", axis.text.x = element_text(size=10))+ labs(color="")
        
        +scale_x_reverse(breaks = round(rev(timescale$min_ma),1))
        +annotate("rect", xmin=timescale$min_ma, xmax=timescale$max_ma, 
                  ymin=(yminv - .5*yscale), ymax=(yminv - 1.5*yscale),
                  fill="gray80",
                  size=.25,colour="black",alpha=1) 
        +annotate("text", x=timescale$mid_ma,y=(yminv - 1*yscale),label=timescale$period,size=4)
        )
    })
    
    output$ext_org_plot <- renderPlot({

      diversity_output <- diversityDF[diversityDF$group %in% input$group[1],]
      diversity_output <- diversity_output[diversity_output$max_ma > 1,]
      title <- input$group[1]
      yminv  <- -max(diversity_output$bL / (diversity_output$max_ma - diversity_output$min_ma), na.rm=T)
      ymaxv  <-  max(diversity_output$Ft / (diversity_output$max_ma - diversity_output$min_ma), na.rm=T)
      yscale <-  (abs(yminv) + ymaxv )/30
      
      (ggplot(diversity_output)
        +geom_vline(xintercept = c(252), color = "gray70", size = 2)
        +geom_vline(xintercept = c(444, 65, 201), color = "gray90", size = 1)
        +annotate("rect", xmax=372.2, xmin = 359, ymin=-Inf, ymax= Inf, fill ="gray90")
        +geom_hline(yintercept = c(0), color = "gray70", size = .2)
        +annotate("rect", xmax=Inf, xmin = -Inf, ymin=yminv, ymax= -Inf, fill ="white")
        +geom_segment(aes(x=560, y = yscale/3, xend=560, yend=3*yscale), color = "green", size =1, arrow = arrow(ends = "last"))
        +geom_segment(aes(x=560, y = -yscale/3, xend=560, yend=-3*yscale), color = "red", size =1, arrow = arrow(ends = "last"))
        +annotate(geom="text", x=560, y = 3.5*yscale, label = "Origination", color = "green")
        +annotate(geom="text", x=560, y = -3.5*yscale, label = "Extinction", color = "red")
        +geom_line(aes(x = min_ma, y= -bL/(max_ma-min_ma)), color = "red")
        +geom_line(aes(x = min_ma, y = Ft/(max_ma-min_ma)), color = "green")
        +geom_point(aes(x = min_ma, y = (yminv - yscale), fill = (Ft-bL)), shape = 22, color = "white", size = 3, alpha = .8)
        +scale_fill_gradient2(low = "red", high = "green", name = "Net change", na.value="white")
        +ggtitle(title)
        +ylab("Extinction and Origination Rate (Genera/Ma)")
        +xlab("Geologic Time (Ma)")
        
        +theme(axis.text.x = element_text(size=10))
        +scale_x_reverse(breaks = round(rev(timescale$min_ma),1))
        +annotate("rect", xmin=timescale$min_ma, xmax=timescale$max_ma, 
                  ymin=(yminv - 1.5*yscale), ymax=(yminv - 3.5*yscale),
                  fill="gray80",
                  size=.25,colour="black",alpha=1) 
        +annotate("text", x=timescale$mid_ma,y=(yminv - 2.5*yscale),label=timescale$period,size=4)
      )
      
    })
    
    output$selectivity_plot <- renderPlot({
      #modify the dataframe according to selected groups
      selectivity_output <- selectivityDF[selectivityDF$comparison == input$hypothesis,] 
      #selectivity_output <- selectivityDF[selectivityDF$comparison == "Terrestrial vs. Marine",]
      

      #make the plot
      (ggplot(selectivity_output, aes(x = min_ma, y = relN, color = group))
        +geom_vline(xintercept = c(252.2), color = "gray70", size = 2)
        +geom_point()+geom_line()
        +ylab("Diversity (Standardized)")
        +xlab("Geologic Time (Ma)")
       # +ggtitle(input$hypothesis) 
        
        +theme(axis.text.x = element_text(size=10), legend.title=element_blank())
        +scale_x_reverse(breaks = (round(rev(unique(selectivity_output$max_ma)),1)))        
      )
    }) 
    
    output$design_plot <- renderPlot({
      #read the data
      pbdb_data1<-fread(input$pbdbURL1,skip = 20 )
      
      #pbdb_data1<-fread("https://paleobiodb.org/data1.2/occs/diversity.csv?datainfo&rowcount&base_name=mammalia&count=genera",skip = 20 )
      #input <- list()
      #input$pbdbURL2 <- "https://paleobiodb.org/data1.2/occs/diversity.csv?datainfo&rowcount&base_name=dinosauria&count=genera"
      
      pbdb_data1$group <- input$group1n
      if(input$pbdbURL2 != "") {pbdb_data2<-fread(input$pbdbURL2,skip = 20)}
      if(input$pbdbURL2 != "") {pbdb_data2$group <- input$group2n}
      if(input$pbdbURL2 != "") {pbdb_data <- rbind(pbdb_data1, pbdb_data2)}  
      
      if(input$pbdbURL2 == "") {pbdb_data <- pbdb_data1}  
      
      pbdb_data$N <- pbdb_data$X_Ft + pbdb_data$X_bL + pbdb_data$X_FL + pbdb_data$X_bt  
      pbdb_data$relN <- pbdb_data$N[pbdb_data$group == input$group1n] / max(pbdb_data$N[pbdb_data$group == input$group1n], na.rm=T)
      if(input$pbdbURL2 != "") {pbdb_data$relN[pbdb_data$group == input$group2n] <- pbdb_data$N[pbdb_data$group == input$group2n] / max(pbdb_data$N[pbdb_data$group == input$group2n], na.rm=T)}
      
      if(input$pbdbURL2 == "") {yaxist <- "total genera"} else {yaxist <- "standardized diversity"}
      
      pbdb_data$plot <- pbdb_data$N
      if(input$pbdbURL2 != "") {pbdb_data$N <- pbdb_data$relN}
      
      xscale <- timescale$min_ma
      xscale <- xscale[xscale >= min(pbdb_data$min_ma)-3]
      xscale <- xscale[xscale < max(pbdb_data$min_ma)]
      xscale <- rev(round(xscale,1))
     
     #make the plot
      (ggplot(pbdb_data, aes(x = max_ma, y = N, color = group))
        +geom_point()+geom_line()
        +scale_x_reverse( breaks = xscale)
        +ylab(yaxist)
        +xlab("Geologic Time (Ma)")
        +theme(legend.title=element_blank())
      )
    }) 
    
    #output$design_table <- DT::renderDataTable({ fread(input$pbdbURL,skip = 20 ) })

})
