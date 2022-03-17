library(ggplot2)
library(plotly)
library(dplyr)
library(stringr)
library(tidyverse)


# Plot 1
county_cases <- read.csv("https://raw.githubusercontent.com/nytimes/covid-19-data/master/us-counties.csv")
wa <- county_cases %>%
  filter(state == "Washington") %>%
  summarise(date, county, cases)

Jan <- wa %>%
  filter(date == date[date <= "2020-01-31"]) %>%
  group_by(county) %>%
  filter(date == max(date))

Feb <- wa %>%
  filter(date == date[date <= "2020-02-30"]) %>%
  group_by(county) %>%
  filter(date == max(date))

March <- wa %>%
  filter(date == date[date <= "2020-03-31"]) %>%
  group_by(county) %>%
  filter(date == max(date))

April <- wa %>%
  filter(date == date[date <= "2020-04-30"]) %>%
  group_by(county) %>%
  filter(date == max(date))

May <- wa %>%
  filter(date == date[date <= "2020-05-31"]) %>%
  group_by(county) %>%
  filter(date == max(date))

June <- wa %>%
  filter(date == date[date <= "2020-06-30"]) %>%
  group_by(county) %>%
  filter(date == max(date))

July <- wa %>%
  filter(date == date[date <= "2020-07-31"]) %>%
  group_by(county) %>%
  filter(date == max(date))

Aug <- wa %>%
  filter(date == date[date <= "2020-08-31"]) %>%
  group_by(county) %>%
  filter(date == max(date))

Sep <- wa %>%
  filter(date == date[date <= "2020-09-30"]) %>%
  group_by(county) %>%
  filter(date == max(date))

Oct <- wa %>%
  filter(date == date[date <= "2020-10-31"]) %>%
  group_by(county) %>%
  filter(date == max(date))

Nov <- wa %>%
  filter(date == date[date <= "2020-11-30"]) %>%
  group_by(county) %>%
  filter(date == max(date))

Dec <- wa %>%
  filter(date == date[date <= "2020-12-31"]) %>%
  group_by(county) %>%
  filter(date == max(date))

wa <- list(Jan, Feb, March, April, May, June, July, Aug, Sep, Oct, Nov, Dec) %>%
  reduce(full_join, by=c('date', "cases", "county"))

wa$date <- gsub("2020-", "", wa$date)
wa$date <- gsub("-.*", "", wa$date)
  
# Plot 2
criminal_data_type <- read.csv("https://raw.githubusercontent.com/info-201b-wi22/final-project-shihanyin/main/criminal_data_type.csv?token=GHSAT0AAAAAABQJINNTGY2ZTRUVZ7GVQJASYR4FYAQ")
personal_crime <- criminal_data_type[c(1:14, 37:50), ]
property_crime <- criminal_data_type[c(16:27, 52:63), ]
society_crime <- criminal_data_type[c(29:35, 65:71), ]

# Plot 3
king_county_total_crimes <- read.csv("https://raw.githubusercontent.com/info-201b-wi22/final-project-shihanyin/main/crimes_in_King_Country_by_month%20copy.csv?token=GHSAT0AAAAAABQJINNSKBSLYVVOZPVGILN4YR4FXJA")
king_county_total_crimes$Year <- as.character(king_county_total_crimes$Year)
str(king_county_total_crimes)

server <- function(input, output) {
  
  # Plot 1
  output$Plot1 <- renderPlotly({
    
    wa_counties <- wa %>% filter(county %in% input$county)
    
    plot1 <- ggplot(data = wa_counties) + 
      geom_line(mapping = aes(x = date, y = cases, color = county, group = 1)) +
      labs(title = "Trend of Covid Cases for All Counties in Washington State in 2020", 
           x = "Month", y = "Number of Cases",
           Color = "County")
    
    Plot1 <- ggplotly(plot1)
    
    return(Plot1)
    
  })

  
  # Plot 2
  output$Plot2 <- renderPlotly({
    
    if (input$plot_type == 1) {
      ggplot(personal_crime) + 
        geom_col(aes(x = year, y = Incidents, fill = Offense)) +
        labs(title = "Personal Crime Incidences", subtitle = "2019-2020", x = "Year", y = "Incidents") 
    } else if (input$plot_type == 2) {
      ggplot(property_crime) +
        geom_col(aes(x = year, y = Incidents, fill = Offense)) +
        labs(title = "Property Crime Incidences", subtitle = "2019-2020", x = "Year", y = "Incidents") 
    }
    else if (input$plot_type == 3) {
      ggplot(society_crime) +
        geom_col(aes(x = year, y = Incidents, fill = Offense)) +
        scale_fill_brewer(palette = 2)+
        labs(title = "Society Crime Incidences", subtitle = "2019-2020", x = "Year", y = "Incidents") 
    }
    
  })
  
  
  # Plot 3
  output$Plot3 <- renderPlotly({
    
    king_county_total_crimes <- king_county_total_crimes %>%
      filter(Year %in% input$Year)
    
    plot3 <- ggplot(data = king_county_total_crimes) +
      geom_line(mapping = aes(x = Month, y = Total_Crimes, color = Year)) +
      geom_point(mapping = aes(x = Month, y = Total_Crimes, color = Year)) +
      labs(title = "Trends of Crimes in King County from 2018 to 2020",
           x = "Month", y = "Numbers of Crimes",
           color = "Year")
    
    plotly_plot3 <- ggplotly(plot3) %>%
      style(hoverlabel = list(bgcolor = "white"))
    
    return(plotly_plot3)
    
  })
  
  output$Plot3Summary <- renderText({
    
    return("I found that crimes in Washington state has mostly occurred in King County in the recent years, thus 
           I decided use King County as typical case to analyze. The reason I chose to plot these line chart and 
           scatter plot was line chart can clearly show the trend that total number of crimes change during the 
           year and scatter plot can intuitively show the difference in the total number of crimes in each month 
           of different years. It can be seen from the chart that the total number of crimes in King County in 2020
           does less than that in 2018 and 2019 to some extent, thus we can infer that Covid-19 does have an impact 
           on the total number of crimes in King County.")
    
  })
  
}



