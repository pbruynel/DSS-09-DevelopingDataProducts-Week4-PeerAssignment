# library(shiny)
source('prepareData.R')

df <- prepareData()
minDate <- min(df$Date_of_report)
maxDate <- Sys.Date()

# Define UI for application that draws a plot
ui <- fluidPage(
    # Application title
    titlePanel("Covid19 in the Netherlands"),
    
    # Sidebar with input elements
    sidebarLayout(
        sidebarPanel(
            HTML(paste0("Covid19 figures will be plotted.<br/> 
                 Pick dates between ", minDate, " and ", maxDate, ".")),
            br(), br(),
            
            dateRangeInput("dateRange", "Date range:", start ="2021-01-01", end =maxDate,
                           min = minDate, max = maxDate,
                           startview = "month"),
 
            selectInput(inputId = "y",
                        label = "Type of figures:",
                        choices = c("Total reported infections"="Total_reported",
                                    "Hospital admission"="Hospital_admission", 
                                    "Deceased"="Total_deceased"),
                        selected = "Total_reported"),

            checkboxInput("actualData", "Load latest data", value = FALSE)
            
        ),
        
        # Show tabs with instructions and a plot of the Covid19 figures.
        mainPanel(
            tabsetPanel(type = "tabs", 
                        tabPanel("Instructions", br(), 
                                 "Tab 'Covid19 figures' shows Covid19 related figures of the Netherlands over a period of time.",
                                 br(), br(),
                                 "On the sidebar panel you can specify the period you're interested in as well as the type of figures.",
                                 br(), br(),
                                 "The source of the data is ",
                                 a(href = "https://data.rivm.nl/covid-19/", "RIVM Netherlands"), ".",
                                 "The figures are updated on a daily basis by the RIVM. 
                                 This application is initially loading locally stored data however,
                                 for performance reasons. These locally stored data contain Covid19 figures up to June 17, 2021.
                                 You can load the latest figures by selecting the checkbox 'Load latest data'.
                                 Note that it can take some time (10 - 20 seconds) for the latest data to be loaded and the plot to be refreshed."
                                 ),
                        tabPanel("Covid19 figures", br(), plotOutput("distPlot")) 
            )
        )
    )
)
