library(bslib)
library(shiny)
library(rsconnect)
source("p3_ui.R")
source("p3_server.R")

shinyApp(ui = ui, server = server)
