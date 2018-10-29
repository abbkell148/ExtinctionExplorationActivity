#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Diversity and Extinction Through Time\n(This is dummmy data!"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
      checkboxGroupInput("group",
                   "Taxa to plot", 
                   choices = c("Animalia","Plantae","Corals","Echinodermata","Brachiopoda"),
                   selected = c("Animalia"))
    ),
    
    # Show a plot of the generated distribution
    mainPanel(tabsetPanel(
       tabPanel("Standardized", plotOutput("distPlot")),
       tabPanel("Not Standardized", plotOutput("distPlot2"))
    ))
  )
))
