#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
   
  output$distPlot <- renderPlot({
    
    # generate bins based on input$bins from ui.R
    x    <- rnorm(100)
    y    <- 3*x
    
    
    # draw the histogram with the specified number of bins
    plot(y~x, main = paste(input$group))
    
  })
  
  output$distPlot2 <- renderPlot({
    
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
