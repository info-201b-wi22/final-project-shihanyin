library(ggplot2)
library(plotly)
library(bslib)

#I think this should be the basic structure of this project.

ui <- navbarPage(
  "P03",
  intro_tab,
  plot_1,
  plot_2,
  plot_3,
  sum_tab
)
