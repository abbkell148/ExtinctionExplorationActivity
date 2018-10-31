#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

# Define UI for application that draws a histogram
shinyUI(navbarPage("Diversity and Extinction", 
    tabPanel("Part1",
      fluidPage(titlePanel("Diversity and Extinction Through Time"),
        # Sidebar with a slider input for number of bins 
        sidebarLayout(
          sidebarPanel(
            checkboxGroupInput("group", "Taxa to plot", choices = group_names),
            checkboxInput('select','All/None')
            ),
          # Show a plot of the generated distribution
          mainPanel(tabsetPanel(
              tabPanel("Standardized Diversity", plotOutput("standard_diversity_plot")),
              tabPanel("Raw Diversity", plotOutput("raw_diversity_plot"))
              ))
          )
        )),
    
    tabPanel("Part2", 
      fluidPage(titlePanel("Selectivity at the Permo-Triassic"),
        sidebarLayout(
          sidebarPanel(
            selectInput("hypothesis", "Select a Hypothesis:", 
                        choices = hypotheses, selected = "latitude")
            ),
          mainPanel(plotOutput("selectivity_plot"))
          ))
    )
))
