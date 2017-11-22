library(dplyr)
library(tidyverse)
library(ggplot2)

server <- function(input, output) {
  
  bcl_data <- read.csv("Data/bcl-data.csv")
  
  shinyjs::onclick("toggleAdvanced",
                   shinyjs::toggle(id = "advanced", anim = TRUE))
  
  # input data need to reactive to user input
  country_data <- reactive({
    if(input$country == "All" ||is.null(input$country) || is.na(input$country)){
      bcl_data %>% 
        filter(Price >= input$priceIn[1],
               Price <= input$priceIn[2],
               Type %in% input$typeIn)
    }
    else{
      bcl_data %>% 
        filter(Price >= input$priceIn[1],
               Price <= input$priceIn[2],
               Type %in% input$typeIn,
               Country == input$country)
    }
  }) 
  price_data<-reactive({
    if(input$price){
      country_data()%>%
        arrange(Price)
    }
    else{
      country_data()
    }
  })
  sweetness_data<-reactive({
    if('WINE' %in% input$typeIn){
      if(input$sweetness == "Any" ||is.null(input$sweetness) || is.na(input$sweetness)){
          price_data()
      }
      else{
          price_data()%>%
            filter(Sweetness == input$sweetness)
      }
    }
    else{
      price_data()
    }
  })
  result_data<-reactive({
    if(input$subtype == "Any" ||is.null(input$subtype) || is.na(input$subtype)){
      sweetness_data()
    }
    else{
      sweetness_data()%>%
        filter(Subtype == input$subtype)
    }
  })
  
  output$country<-renderUI(
    selectInput("country", "Choose a country",
                choices = c("All",
                            unique(as.list(bcl_data$Country))
                            ))
  )
  output$sweetness<-renderUI(
    selectInput("sweetness", "Choose a sweetness value",
                choices = c("Any",
                            sort(na.omit(unique(bcl_data$Sweetness)))
                           ))
  )
  output$subtype<-renderUI(
    selectInput("subtype", "Choose a subtype",
                choices = c("Any",unique(bcl_data %>% filter(Type %in% input$typeIn)%>%select(Subtype))))
  )
  output$Hist_AlcCont <- renderPlot({
    validate(
      need(nrow(result_data()) > 0, "No data to plot!!")
    )
    result_data() %>%
      ggplot() +
      aes(x= Alcohol_Content)+
      geom_histogram(fill = input$col,binwidth = 3,color="white")
  })
  output$table1 <- DT::renderDataTable({
    validate(
      need(nrow(result_data()) > 0, "Selected Country has no entries")
    )
    result_data()#now filteredbc is a function
  })
  output$n_results <- renderText({
    validate(
      need(nrow(result_data()) > 0, "Selected Country has no entries")
    )
    paste("We found ", nrow(result_data()),"options for you")})
  
  output$downloadData <- downloadHandler(
    filename = function() {
      paste("results_data",gsub(":","-",Sys.time()), ".csv", sep="")
    },
    content = function(file) {
      write.csv(result_data(), file)
    }
  )
  output$downloadOrigdata <- downloadHandler(
    filename = function() {
      paste("bcl_data",gsub(":","-",Sys.time()), ".csv", sep="")
    },
    content = function(file) {
      write.csv(bcl_data, file)
    }
  )
}