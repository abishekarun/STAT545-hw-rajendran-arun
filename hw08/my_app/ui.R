ui <- fluidPage(theme = "bc_style.css",
  
  # Application title
  
  titlePanel("My Shiny app for BC liquor data"),
  
  sidebarPanel(shinyjs::useShinyjs(),
               a(id = "toggleAdvanced", "Show/hide price range"), 
               shinyjs::hidden
               (
                  div(id = "advanced", 
                    sliderInput("priceIn","Price of booze",
                               min = 0, max = 300,
                               value = c(0,100), pre = "CAD"))
               ),
               checkboxGroupInput("typeIn","what kind of booze?",
                                 choices = c("BEER","SPIRITS","WINE"),
                                 selected = "SPIRITS"),
               checkboxInput("price","Sort by price",FALSE),
               uiOutput("country"),
               uiOutput("subtype"),
               # Only show this panel if Custom is selected
               conditionalPanel(
                 condition="input.typeIn.indexOf('WINE') != -1",
                 uiOutput("sweetness")
               ),
               colourpicker::colourInput("col", "Select colour", value = "red"),
               textOutput("n_results"),
               downloadLink("downloadData", "Download Current Modified data"),
               div(id = "orig",
                 downloadLink("downloadOrigdata", " Download Original Wine data")
               ),
               p("Data Source:",a(href="https://www.opendatabc.ca/dataset/bc-liquor-store-product-price-list-current-prices","Opendatabc"))
               ),
 mainPanel( 
   # Output: Tabset w/ plot, summary, and table ----
   tabsetPanel(type = "tabs",
               tabPanel("Plot", plotOutput("Hist_AlcCont")),
               tabPanel("Table",DT::dataTableOutput("table1")),
               tabPanel("Source",
                        img(class="center",src= "liquor_store.jpg",width= 600,height=400),
                        h1("Source of the dataset"),
                        p('The dataset used for analysis in this shiny app is bc liquor data whose source 
                          is',
                        a(href="https://www.opendatabc.ca/dataset/bc-liquor-store-product-price-list-current-prices","opendatabc")
                        )
                        )
   )
 
)
)
