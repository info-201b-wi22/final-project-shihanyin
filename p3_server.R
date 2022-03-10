library(ggplot2)
library(plotly)
library(dplyr)
library(stringr)
library(readr)

county_cases <- read.csv("https://raw.githubusercontent.com/nytimes/covid-19-data/master/us-counties.csv")
wa <- county_cases %>% filter(state == "Washington")

criminal_data_type_copy <- read_csv("criminal_data_type copy.csv")
personal_crime <- criminal_data_type_copy[c(1:14, 37:50), ]

server <- function(input, output) {
  
  output$Plot1 <- renderPlotly({
    
    wa <- wa %>%  filter(county %in% input$user_category)
    
    Plot1 <- ggplot(data = wa) + geom_line(mapping = aes(x = date, y = cases, color= county))
    
    plotly_Plot1 <- ggplotly(Plot1)
    
    return(plotly_Plot1)
  })
}
