library(ggplot2)
library(plotly)
library(dplyr)

county_cases <- read_csv("https://raw.githubusercontent.com/nytimes/covid-19-data/master/us-counties.csv")
wa <- county_cases %>% filter(state == "Washington")

server <- function(input, output) {
  
  output$Plot1 <- renderPlotly({
    
    wa <- wa %>%  filter(county %in% input$user_category)
    
    Plot1 <- ggplot(data = wa) + geom_line(mapping = aes(x = date, y = cases, color= county))
    
    plotly_Plot1 <- ggplotly(Plot1)
    
    return(plotly_Plot1)
  })
}
