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
              tabPanel("Raw Diversity",
                       tags$i('Gray vertical bars mark the "Big Five" Mass Extinctions: the end-Ordovician, the Late Devonian, the Permo-Triassic, the end-Triassic, and the Cretaceous-Paleogene.'),
                       plotOutput("raw_diversity_plot"),
                       p('This plot tallies the total number of genera (plural for "genus") in each time bin. However, since diversity varies widely between groups, Standardized Diversity (the second panel above) presents the data more clearly.')),
              tabPanel("Standardized Diversity",
                       tags$i('Gray vertical bars mark the "Big Five" Mass Extinctions: the end-Ordovician, the Late Devonian, the Permo-Triassic, the end-Triassic, and the Cretaceous-Paleogene.'),
                       plotOutput("standard_diversity_plot")),

              tabPanel("Extinction and Origination",
                       tags$i('Gray vertical bars mark the "Big Five" Mass Extinctions: the end-Ordovician, the Late Devonian, the Permo-Triassic, the end-Triassic, and the Cretaceous-Paleogene.'),
                       plotOutput("ext_org_plot"),
                       p("This plot tallies the number of new genera that originate (evolve) compared to the number of genera that go extinct in each time bin (standardized to taxa/million years). Both origination and extinction contribute to changes in total diversity!"),
                       tags$b("Note that only one taxonomic group is plotted! If you have selected more than one group, then only first the group will be plotted."))
              ))
          )
        )),
    
    tabPanel("Part2", 
      fluidPage(titlePanel("Selectivity at the Permo-Triassic"),
        fluidRow(sidebarLayout(position = "right",
          sidebarPanel(
            selectInput("hypothesis", "Select a Comparison:", 
                        choices = hypotheses, selected = "Terrestrial vs. Marine")
            ),
          mainPanel(plotOutput("selectivity_plot"))
          )),
        fluidRow(
          h4("Which groups were hit the hardest by the Permo-Triassic Extinction Event?"),
          p('The',a(href= 'https://en.wikipedia.org/wiki/Permian%E2%80%93Triassic_extinction_event', 'Permo-Triassic Mass Extinction', target = "_blank"), 'is thought to have impacted 99% of species on Earth. What caused this "Great Dying"? One way to answer this question is to assess the', tags$i('selectivity'), 'of the extinctions. In other words, by determining which groups of organisms were most vulnerable to extinction, and then assessing which traits where shared amongst those organisms, paleontologists can deduce the',  tags$i('kill mechanism'), 'of the extinction.'), 
          p('In this module, explore how the selectivity pattern differs between groups in each of three comparisons. Is there are clear difference? Are all groups affected similarly? What does this tell you about the potential kill mechanisms of the P-T extinction?'),
          h4("The comparisons:"),
          p(tags$b("1. Terrestrial vs. Marine:"), 'A broad comparison of fossil diversity from terrestrial environments compared to marine environments.'),
          p(tags$b("2. Acid Buffering Capacity:"), 'Many marine organisms build mineralized skeletons. These skeletons vary in the degree to which they are buffered, or resistant to acidic conditions. Organisms with a "High" buffering capacity are better equipped to survive acidic conditions than organisms with "Low" buffering capacity.'),
          p('(These groups are adapted from Knoll et al. 2007: "Paleophysiology and end-Permian mass extinction.")'),
          p(tags$b("3. Climatic Preferences:"), 'Organisms from higher paleolatitudes were presumably better adapted to cooler conditions, while organims from lower paleolatitudes were adapted to warmer conditions. This comparison shows how organisms of different climatic tolerances were affected by the Permo-Triassic extinction (in a very simplistic way).')
        )
      )
      ),
    
      tabPanel("Part3", 
        fluidPage(titlePanel("Design your own PBDB adventure!"),
          verticalLayout(
            p("Now it's your turn! Explore the diversity of a group (or groups) of your choice. Go to the Paleobiology Database data downloader site:", a(href="https://paleobiodb.org/classic/displayDownloadGenerator", "PBDB downloader", target="_blank")),
            p("In the 'What do you want to download?' panel, select 'Diversity over time'. Then, select your chosen criteria in the lower drop-down options (e.g., 'Mammalia' and 'Latitude between 40 and 90'). When you are finished, copy and paste the link generated (above the 'Test' and 'Download' buttons) here:"),
            wellPanel(fluidRow(
            column(8, 
              textInput("pbdbURL1", "Copy and paste PBDB URL here ('group1'):", 
                        value = "https://paleobiodb.org/data1.2/occs/diversity.csv?datainfo&rowcount&base_name=mammalia&count=genera&latmin=40&latmax=90", width = '100%'),
              textInput("pbdbURL2", "PBDB URL for group2 (optional):", 
                        placeholder = "https://paleobiodb.org/data1.2/occs/diversity.csv?datainfo&rowcount&base_name=dinosauria&count=genera&latmin=40&latmax=90", width = '100%'),
              actionButton("makeplots", "Make the Plot!")
            ), 
            column(4, 
                   textInput("group1n", "Group1 Name:", 
                             value = "Mammals HiLat", width = '100%'),
                   textInput("group2n", "Group2 Name:", 
                             value = "Group2", width = '100%')
            )
            )),
            tags$b("It will take a little while to load as this website's server queries the PBDB server..."),
            p("If you continue to see an error message, double check that the link you pasted is for 'Diversity over time.'"),
            plotOutput("design_plot")
            #DT:: dataTableOutput("design_table")
        )))
))
