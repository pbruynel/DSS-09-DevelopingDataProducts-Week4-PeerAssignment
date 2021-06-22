#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
source('prepareData.R')
df <- prepareData()
minDate <- min(df$Date_of_report)
maxDate <- max(df$Date_of_report)


# Define UI for application that draws a histogram
ui <- fluidPage(
    # Application title
    titlePanel("Covid19 in the Netherlands"),
    
    # Sidebar with a slider input for number of bins 
    sidebarLayout(
        sidebarPanel(
            HTML(paste0("Covid19 figures will be plotted. 
                 Pick dates between ", minDate, " and ", maxDate, ".")),
            
            br(), br(),
            dateRangeInput("dateRange", "Date range:", start ="2021-01-01", end =maxDate,
                           min = minDate, max = maxDate,
                           startview = "month"),
 
            selectInput(inputId = "y",
                        label = "Y-axis:",
                        choices = c("Total reported"="Total_reported",
                                    "Hospital admission"="Hospital_admission", 
                                    "Deceased"="Total_deceased"),
                        selected = "Total_reported"),

            sliderInput("bins",
                        "Number of bins:",
                        min = 1,
                        max = 50,
                        value = 10)
        ),
        
        # Show a plot of the generated distribution
        mainPanel(
            plotOutput("distPlot"),
            textOutput(outputId = "yValue")
        )
    )
)
