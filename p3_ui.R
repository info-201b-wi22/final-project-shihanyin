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

conclusion <- tabPanel(
  "Conclusion",
  h2("Takeaways"),
  p("The three major takeaways are about covid cases, the crime number, and crime types."), 
  p("The trend of the number of covid cases in each county in Washington State has been shown in the first plot. It can be clearly seen that covid-19 has been in Washington state since around February 2020, and there has been a linear increase in cases since then. By January next year, there has been an exponential increase in cases. It can be inferred that the delta variant, which is more infectious, started entering Washington state and became a major contributor to covid cases. The rate of increase slowed down in early February because more and more people are vaccinated and good anti-epidemic measures by local government. Among all the counties, King County has the highest number of covid cases due to its high county population. "),
  h2("Insights"),
  p("Generally speaking, there is a light positive correlation between covid cases and crime numbers, though this correlation may be caused by the differences in total number of populations."),
  p("There are some regions which do not show this positive correlation: they have low covid cases but relatively high crime numbers, or have high crime numbers but with relatively low covid cases. Other social factors exist to influence these two variables."),
  p("The correlation between crime and covid still needs to be further explored."),
  h2("Implications"),
  p("The seriousness of the pandemic can be served as the degree to measure the effectiveness of the public health system. By looking at our graphs in covid cases distribution, administrators in public health system can have a more general idea of the condition about the covid spread as well as the security measures. Also, crime rates could be served as a standard to test the management of government. We are expecting to find a result of a clear correlation between crime rates and covid cases. To be more specific, we are expecting to find a positive relationship between crime rates and covid cases, which means covid facilities the crimes. In this way, in order to decrease crime rate in a region, policymakers can start with controlling the spread of covid. They can control the crime rate as well as the spread of covid, and maybe cooperate with the public health system.")
)

ui <- navbarPage(
  "P03",
  plot_1,
  plot_2,
  conclusion
)

