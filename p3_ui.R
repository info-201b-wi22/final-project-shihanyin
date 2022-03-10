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

plot_sidebar2 <- sidebarPanel(
  radioButtons(
    inputId = "plot_type",
    label = h3("Different Distribution of Crimes"),
    choices = list("Personal Crime" = 1, "Property Crime" = 2, "Society Crime" = 3), 
    selected = 1),
  
  plotOutput("Plot2")
  )
  
plot_main <- mainPanel(
  plotlyOutput(outputId = "Plot1" ),
  plotlyOutput(outputId = "Plot2" ),
  p("By looking at this chart, we can get a glance about trend of covid cases among counties.")
)
  

plot_1 <- tabPanel(
  "Plot 1",
  sidebarLayout(
    plot_sidebar1,
    plot_main
  )
)

plot_2 <- tabPanel(
  "Plot 2", 
  sidebarLayout(
    plot_sidebar2,
    plot_main
  )
)

ui <- navbarPage(
  "P03",
  plot_1,
  plot_2
)

