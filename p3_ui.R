library(ggplot2)
library(plotly)
library(bslib)


plot_sidebar1 <- sidebarPanel(
  selectInput(
    inputId = "user_category",
    label = h4("Select County"),
    choices = wa$county,
    selected = "King",
    multiple = TRUE)
  
)


plot_main <- mainPanel(
  plotlyOutput(outputId = "Plot1" ),
  p("By looking at this chart, we can get a glance about trend of covid cases among counties.")
)
  

plot_1 <- tabPanel(
  "Plot 1",
  sidebarLayout(
    plot_sidebar1,
    plot_main
  )
)


ui <- navbarPage(
  "P03",
  plot_1
)
