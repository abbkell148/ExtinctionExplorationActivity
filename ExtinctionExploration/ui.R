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
  titlePanel("Diversity and Extinction Through Time"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
      checkboxGroupInput("group", "Taxa to plot", 
                   choices = group_names,
                   selected = c("animalia")),
                   
      checkboxInput('select','All/None')
),
    # Show a plot of the generated distribution
    mainPanel(tabsetPanel(
       tabPanel("Standardized Diversity", plotOutput("standard_diversity_plot")),
       tabPanel("Raw Diversity", plotOutput("raw_diversity_plot"))
    ))
  )
))
