library(ggplot2)
library(plotly)
library(bslib)

introdction <- tabPanel(
  "Introduction",
  fluidPage(theme = bs_theme(primary = "#9370DB", font_scale = NULL, bootswatch = "cerulean"),
            h4("Major Questions"),
            p("Since the outbreak of Covid-19, the coronavirus pandemic seems to have brought nothing but disaster, and crime has always been a hot topic. We would like to see if there is a potential correlation between these two topics. Consequently, the major question we are seeking to answer is to figure out whether there is a correlation between incresed covid cases and the crime numbers as well as any changes in crime types. "),
            h4("Data set"),
            p("Here are the links to the data set we have used for our project: "),
            p("-1. https://raw.githubusercontent.com/nytimes/covid-19-data/master/us-counties.csv"),
            p("-2. https://kingcounty.gov/depts/health/covid-19/data/daily-summary.aspx"),
            p("By looking and comparing these data set, we are able to seek out the trend of covid cases, the change of crime numbers on crime types, and the crime condition we looking specifically into King county, since it is the county with the highest covid cases as well as highest crime numbers due to its high population"),
            h5("Source"),
            p("The first data set is from our previous class, when we were introduced to the covid data. The second data set is from King County's website."),
            h5("Limitations & Ethical problems"),
            p("There are many additional factors that need to be considered when looking at the correlation between covid and crimes. Just because patterns and trends can be seen within the datasets does not necessarily mean a direct correlation or hypothesis can be drawn from it. This is a general disclaimer about our project that needs to be addressed, any visualization we produce that displays the relationship between covid and crimes should not be seen as causations of one another whether positive or negative. There are challenges that come with dealing with such two big datasets, one of them is not being able to include every possible factor that could affect these data points. These challenges limit our project for any distinct conclusion to be drawn, however, this project can still be used to get the big idea of what is going on in our world and make educated inferences about society."),
            img(src="https://www.clevelandclinic.org/healthinfo/ShowImage.ashx?PIC=4480")
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
  p("By looking at this chart, we can get a glance about trend of covid cases among counties in the year of 2020.")
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
  p("The three major takeaways are about covid cases, the crime types, and crime number."), 
  p("The trend of the number of covid cases in each county in Washington State has been shown in 
     the first plot. It can be clearly seen that covid-19 has been in Washington state since around 
     February 2020, and there has been a linear increase in cases since then. By January next year, 
     there has been an exponential increase in cases. It can be inferred that the delta variant, 
     which is more infectious, started entering Washington state and became a major contributor to 
     covid cases. The rate of increase slowed down in early February because more and more people are 
     vaccinated and good anti-epidemic measures by local government. Among all the counties, King 
     County has the highest number of covid cases due to its high county population. It reaches 62582 cases."),
  p("Our analysis has divided crime types into three categories: personal crime, property crime and social crime. 
    It can be clearly seen from the comparison of the number of crime incidents from 2019-2020 that property crime (+51005) 
    in Washington State. The personal crime has decreased (-2732), as well as social crime (-5783). However, the results of 
    overall crime number trend have been surprising. As the county with both the highest number of covid-19 cases and highest 
    number of crime cases, King County is the subject that we intend to take a closer look at. By comparing the number of 
    crimes from 2018, 2019 and 2020, the trends show that changes in crime rates seem to be random and irregular. 
    However, it is worth noting that the crime figures for 2020 are basically smaller than the figures for last tow years. 
    The highest monthly crime number is 670 in October 2019, while the lowest one is 342 in June 2020."),
                    
  h4("Insights"),
  p("Generally speaking, there is a light positive correlation between covid cases and crime numbers, 
     if only consider a county's covid cases and crime number. However, when taking a closer look at the
    situation of a county, the crime number seems to show a negative correlation with covid cases."),
  p("During the pandemic, work/study-from-home policy has forced many residents to stay at home, thereby reducing
    overall crime. However, the epidemic has also forced many stores to close and some people probably lose their jobs or even
    live on the streets, which may explain the increased distribution of property crime in Washington state."),
  p("The correlation between crime and covid is very light and many other factors can exist to influence these two variables.
    Further exploration is still needed."),
                      
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

