library(shiny)
library(tidyverse)
load("/Users/home/Documents/MSSP Fall 2019/MA615/MA615_midterm/Clean_WB_data.RData")

ui <- dashboardPage(
  dashboardHeader(title = "World Bank Data Viewer"), 
  dashboardSidebar(
    sidebarMenu(
      menuItem("Dashboard", tabName = "dashboard", icon = icon("dashboard")), 
      menuItem("Country", tabName = "country", icon = icon("globe-americas"), 
               selectInput(inputId = "country", label = "Country", 
                           choices = wb_data$country))
    )
  ), 
  dashboardBody(
    fluidRow(
      box(selectInput(inputId = "xvar", label = "X-Variable", 
                  choices = c("Date" = "date", 
                              "CO2 Emission" = "co2", 
                              "GDP" = "gdp", 
                              "Infant Mortality" = "infant", 
                              "Life Expectancy" = "life", 
                              "N2O Emission" = "n2o", 
                              "Nurses/Midwives per 1000" = "nurses", 
                              "Physicians per 1000" = "phys", 
                              "Under 5 Mortality per 1000" = "under5", 
                              "Urban Population" = "urbanpop", 
                              "Urban Population Growth %" = "urbanpop_pct"))),
      box(selectInput(inputId = "yvar", label = "Y-Variable", 
                  choices = c("Date" = "date", 
                              "CO2 Emission" = "co2", 
                              "GDP" = "gdp", 
                              "Infant Mortality" = "infant", 
                              "Life Expectancy" = "life", 
                              "N2O Emission" = "n2o", 
                              "Nurses/Midwives per 1000" = "nurses", 
                              "Physicians per 1000" = "phys", 
                              "Under 5 Mortality per 1000" = "under5", 
                              "Urban Population" = "urbanpop", 
                              "Urban Population Growth %" = "urbanpop_pct"))),
      box(title = "Scatterplot",
        plotOutput("plot1", height = 400))
    )
  )
)

# server <- function(input, output) {
#   
#   output$plot1 <- renderPlot({
#     p <- ggplot(data = reactdata()) +
#     geom_bar(aes(x = )) +
#     labs(title = "Plot with Selected Variables",
#          x = NULL,
#          y = NULL) +
#     theme_bw() 
#   print(p)
#   })
# }

server <- function(input, output) { 

  output$distPlot <- renderPlot({   
    if(input$xvar=='date'){i <- 1}   
    if(input$xvar=='co2'){i <- 2}
    if(input$xvar=='gdp'){i <- 3}    
    if(input$xvar=='infant'){i <- 4}  
    if(input$xvar=='life'){i <- 5}   
    if(input$xvar=='n2o'){i <- 6}
    if(input$xvar=='nurses'){i <- 7}    
    if(input$xvar=='phys'){i <- 8}
    if(input$xvar=='under5'){i <- 9}   
    if(input$xvar=='urbanpop'){i <- 10}
    if(input$xvar=='urbanpop_pct'){i <- 11}    
    
    if(input$yvar=='date'){j <- 1}   
    if(input$yvar=='co2'){j <- 2}
    if(input$yvar=='gdp'){j <- 3}    
    if(input$yvar=='infant'){j <- 4}  
    if(input$yvar=='life'){j <- 5}   
    if(input$yvar=='n2o'){j <- 6}
    if(input$yvar=='nurses'){j <- 7}    
    if(input$yvar=='phys'){j <- 8}
    if(input$yvar=='under5'){j <- 9}   
    if(input$yvar=='urbanpop'){j <- 10}
    if(input$yvar=='urbanpop_pct'){j <- 11}  
    
    plotdata <- read.csv("/Users/home/Documents/MSSP Fall 2019/MA615/MA615_midterm/Clean_WB_data.RData")
    x-variable <- plotdata[, i]    
    y-variable <- plotdata[, j]     
    plot(x-variable, y-variable)   
  }) 
}


shinyApp(ui, server)
