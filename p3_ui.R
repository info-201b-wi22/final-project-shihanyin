library(ggplot2)
library(plotly)
library(bslib)

introdction <- tabPanel(
  "Introduction",
  fluidPage(theme = bs_theme(primary = "#9370DB", font_scale = NULL, bootswatch = "cerulean"),
            h4("Major Questions"),
            p("...")
  )
)


# Plot 1
plot_sidebar1 <- sidebarPanel(
  selectInput(
    inputId = "user_category",
    label = h5("Select County: "),
    choices = wa$county,
    selected = "King",
    multiple = TRUE)
  
)

plot_main1 <- mainPanel(
  plotlyOutput(outputId = "Plot1" ),
  p("By looking at this chart, we can get a glance about trend of covid cases among counties.")
)

plot_1 <- tabPanel(
  "Plot 1",
  sidebarLayout(
    plot_sidebar1,
    plot_main1
  )
)


# Plot 2
plot_2 <- tabPanel(
  "Plot 2", 
    sidebarPanel(
      radioButtons(
        inputId = "plot_type",
        label = h5("Different Distribution of Crimes"),
        choices = list("Personal Crime" = 1, "Property Crime" = 2, "Society Crime" = 3), 
        selected = 1),
      ),
    mainPanel(
      plotlyOutput("Plot2", width = "65%", height = "650px"),
      p("This chart displays the number of incidents per Crime Type. Switch between categories to see the distribution from 2019 to 2020.")
    )
)


# Plot 3
plot_sidebar3 <- sidebarPanel(
  selectInput(
    inputId = "Year",
    label = h5("Select Year: "),
    choices = king_county_total_crimes$Year,
    selected = "2020",
    multiple = TRUE),
)

plot_main3 <- mainPanel(
  tabsetPanel(
    tabPanel("Plot", plotlyOutput(outputId = "Plot3"),   
    p("This chart displays the total number of crimes in King County. 
    Select years to compare the data from 2018 to 2020.")),
    tabPanel("Summary", textOutput(outputId = "Plot3Summary"))
  )
)

plot_3 <- tabPanel(
  "Plot 3",
  sidebarLayout(
    plot_sidebar3,
    plot_main3
  )
)


conclusion <- tabPanel(
  "Conclusion",
  h4("Takeaways"),
  p("The three major takeaways are about covid cases, the crime number, and crime types."), 
  p("The trend of the number of covid cases in each county in Washington State has been shown in 
     the first plot. It can be clearly seen that covid-19 has been in Washington state since around 
     February 2020, and there has been a linear increase in cases since then. By January next year, 
     there has been an exponential increase in cases. It can be inferred that the delta variant, 
     which is more infectious, started entering Washington state and became a major contributor to 
     covid cases. The rate of increase slowed down in early February because more and more people are 
     vaccinated and good anti-epidemic measures by local government. Among all the counties, King 
     County has the highest number of covid cases due to its high county population."),
                    
  h4("Insights"),
  p("Generally speaking, there is a light positive correlation between covid cases and crime numbers, 
     though this correlation may be caused by the differences in total number of populations."),
  p("There are some regions which do not show this positive correlation: they have low covid cases 
     but relatively high crime numbers, or have high crime numbers but with relatively low covid 
     cases. Other social factors exist to influence these two variables."),
  p("The correlation between crime and covid still needs to be further explored."),
                      
  h4("Implications"),
  p("The seriousness of the pandemic can be served as the degree to measure the effectiveness of the 
     public health system. By looking at our graphs in covid cases distribution, administrators in 
     public health system can have a more general idea of the condition about the covid spread as 
     well as the security measures. Also, crime rates could be served as a standard to test the 
     management of government. We are expecting to find a result of a clear correlation between crime 
     rates and covid cases. To be more specific, we are expecting to find a positive relationship 
     between crime rates and covid cases, which means covid facilities the crimes. In this way, in 
     order to decrease crime rate in a region, policymakers can start with controlling the spread of 
     covid. They can control the crime rate as well as the spread of covid, and maybe cooperate with 
     the public health system.")

)


ui <- navbarPage(
  "P03",
  introdction,
  plot_1,
  plot_2,
  plot_3,
  conclusion
)

