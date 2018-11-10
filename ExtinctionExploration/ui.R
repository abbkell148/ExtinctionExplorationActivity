#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

# Define UI
shinyUI(navbarPage("Diversity and Extinction", 
    tabPanel("Part1",
      fluidPage(titlePanel("Diversity and Extinction Through Time"),
        # Sidebar with a slider input for number of bins 
        sidebarLayout(
          sidebarPanel(
            checkboxGroupInput("group", "Taxa to plot", choices = group_names),
            checkboxInput('select','All/None')
            ),
          mainPanel(tabsetPanel(
              tabPanel("Standardized Diversity",
                       tags$i('Gray vertical bars mark the "Big Five" Mass Extinctions: the end-Ordovician, the Late Devonian, the Permo-Triassic, the end-Triassic, and the Cretaceous-Paleogene.'),
                       plotOutput("standard_diversity_plot")),
              tabPanel("Raw Diversity",
                       tags$i('Gray vertical bars mark the "Big Five" Mass Extinctions: the end-Ordovician, the Late Devonian, the Permo-Triassic, the end-Triassic, and the Cretaceous-Paleogene.'),
                       plotOutput("raw_diversity_plot")),
              tabPanel("Extinction and Origination",
                       tags$i('Gray vertical bars mark the "Big Five" Mass Extinctions: the end-Ordovician, the Late Devonian, the Permo-Triassic, the end-Triassic, and the Cretaceous-Paleogene.'),
                       plotOutput("ext_org_plot"),
                       p("Note that only one taxonomic group is plotted! If more than one group is selected, then only first the group will be plotted."))
              ))
          )
        )),
    
    tabPanel("Part2", 
      fluidPage(titlePanel("Selectivity at the Permo-Triassic"),
        sidebarLayout(
          sidebarPanel(
            selectInput("hypothesis", "Select a Hypothesis:", 
                        choices = hypotheses, selected = "Terrestrial vs. Marine")
            ),
          mainPanel(plotOutput("selectivity_plot"))
          ))),
    
      tabPanel("Part3", 
        fluidPage(titlePanel("Design your own PBDB adventure!"),
          verticalLayout(
            h6("This is the link to PBDB:"),
            a(href="https://paleobiodb.org/classic/displayDownloadGenerator", "PBDB"),
            h6("and this is more text explaining this part (which unfortunately doesn't work..."),
            wellPanel(
              textInput("pbdbURL", "Copy and paste PBDB url here:", 
                        placeholder = "e.g., https://paleobiodb.org/data1.2/occs/diversity.csv?datainfo&rowcount&base_name=mammalia&count=genera", width = '100%')
            ),
            plotOutput("design_plot")
            #DT:: dataTableOutput("design_table")
        )))
))
