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
            p("Now it's your turn! Explore the diversity of a group (or groups) of your choice. Go to the Paleobiology Database data downloader site:"),
            a(href="https://paleobiodb.org/classic/displayDownloadGenerator", "Paleobiology Database", target="_blank"),
            p("In the 'What do you want to download?' panel, select 'Diversity over time'. Then, select your chosen criteria in the lower drop-down options (e.g., 'Mammalia' and '(paleo) Latitude between 40 and 90'). When you are finished, copy and paste the link generated (above the 'Test' and 'Download' buttons) here:"),
            wellPanel(
              textInput("pbdbURL1", "Copy and paste PBDB URL here ('group1'):", 
                        value = "https://paleobiodb.org/data1.2/occs/diversity.csv?datainfo&rowcount&base_name=mammalia&count=genera&latmin=40&latmax=90", width = '100%'),
              textInput("pbdbURL2", "PBDB URL for group2 (optional):", 
                        placeholder = "https://paleobiodb.org/data1.2/occs/diversity.csv?datainfo&rowcount&base_name=dinosauria&count=genera&latmin=40&latmax=90", width = '100%')
            ),
            tags$b("It will take a litle while to load, as this website's server queries the PBDB server..."),
            p("If you continue to see an error message, double check that the link you pasted is for 'Diversity over time.'"),
            plotOutput("design_plot")
            #DT:: dataTableOutput("design_table")
        )))
))
