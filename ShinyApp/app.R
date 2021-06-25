library(shiny)
library(ggplot2)

source('ui.R', local = TRUE)
source('server.R')
source('prepareData.R')

df <- prepareData()

shinyApp(
    ui = ui,
    server = server
)