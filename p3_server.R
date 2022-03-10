library(ggplot2)
library(plotly)
library(dplyr)
library(stringr)
library(readr)

county_cases <- read_csv("https://raw.githubusercontent.com/nytimes/covid-19-data/master/us-counties.csv")
wa <- county_cases %>% filter(state == "Washington")

#plot2
criminal_data_type<- read_csv("https://raw.githubusercontent.com/info-201b-wi22/final-project-shihanyin/main/criminal_data_type.csv?token=GHSAT0AAAAAABQW2MUKKXLPSEX4VDP3TLRMYRSWGNQ")
personal_crime <- criminal_data_type[c(1:14, 37:50), ]
property_crime <- criminal_data_type[c(16:27, 52:63), ]
society_crime <- criminal_data_type[c(29:35, 65:71), ]

server <- function(input, output) {
  
  output$Plot1 <- renderPlotly({
    
    wa <- wa %>%  filter(county %in% input$user_category)
    
    Plot1 <- ggplot(data = wa) + geom_line(mapping = aes(x = date, y = cases, color= county))
    
    plotly_Plot1 <- ggplotly(Plot1)
    
    return(plotly_Plot1)
  })

  output$Plot2 <- renderPlotly({ 
    if (input$plot_type == 1) {
      ggplot(personal_crime) + 
        geom_col(aes(x=year, y=Incidents, fill = Offense))+
        labs(title = "Personal Crime Incidences", subtitle = "2019-2020",x = "Year", y = "Incidents") 
    } else if (input$plot_type == 2) {
      ggplot(property_crime) +
        geom_col(aes(x=year, y=Incidents, fill = Offense))+
        labs(title = "Property Crime Incidences", subtitle = "2019-2020",x = "Year", y = "Incidents") 
    }
    else if (input$plot_type == 3) {
      ggplot(society_crime) +
        geom_col(aes(x=year, y=Incidents, fill = Offense)) +
        scale_fill_brewer(palette = 2)+
        labs(title = "Society Crime Incidences", subtitle = "2019-2020",x = "Year", y = "Incidents") 
    }
  })
}



