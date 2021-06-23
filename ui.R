library(shiny)
source('prepareData.R')
df <- prepareData()
minDate <- min(df$Date_of_report)
#maxDate <- max(df$Date_of_report)
maxDate <- Sys.Date()


# Define UI for application that draws a histogram
ui <- fluidPage(
    # Application title
    titlePanel("Covid19 in the Netherlands"),
    
    # Sidebar with a slider input for number of bins 
    sidebarLayout(
        sidebarPanel(
            #textOutput(outputId = "yValue"),
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

            checkboxInput("actualData", "Update actual data", value = FALSE),
            
        ),
        
        # Show a plot of the generated distribution
        mainPanel(
            plotOutput("distPlot"),
            textOutput(outputId = "summary"),
            textOutput(outputId = "update")
        )
    )
)
