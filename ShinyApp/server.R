# library(shiny)
# library(ggplot2)
# 
source('setYLabel.R')
source('setTitle.R')
source('setSubtitle.R')

# Define server logic required to draw the plot
server <- function(input, output) {
    df <- prepareData()

    output$distPlot <- renderPlot({
        # load data if necessary
        dataIsActual <- (Sys.Date() - ddays(2)) < max(df$Date_of_report)
        # if user wants latest data and data is not actual, then load latest data
        # else if user wants local data and data is actual then load local data
        # else no action required
        if (input$actualData & !dataIsActual){
            df <<- prepareData(update=TRUE)
            dataIsActual <- (Sys.Date() - ddays(2)) < max(df$Date_of_report)
        } else if (!input$actualData & dataIsActual) {
            df <<- prepareData(update=FALSE)
            dataIsActual <- (Sys.Date() - ddays(2)) < max(df$Date_of_report)
        }

        df <- df %>%
            filter(Date_of_report >= as.POSIXct(input$dateRange[1]) & Date_of_report <= as.POSIXct(input$dateRange[2]))
        
        yAxis <- input$y
        yLabel <- setYLabel(yAxis)
        
        plotTitle <- setTitle(yAxis)
        plotSubtitle <- setSubtitle(yAxis, input$dateRange[1], input$dateRange[2], df)
        plotCaption <- "Source: RIVM Netherlands (https://data.rivm.nl/covid-19/)"

        df %>%
            ggplot(aes_string(x = df$Date_of_report, y = input$y)) +
            geom_line() +
            labs(x = "Date", y = yLabel, title = plotTitle, subtitle = plotSubtitle, caption = plotCaption) +
            theme(
                plot.title = element_text(hjust = 0.5, size = 16),    # Center title position and size
                plot.subtitle = element_text(hjust = 0.5, size = 14),            # Center subtitle
                plot.caption = element_text(hjust = 0, face = "italic", size = 12)  # move caption to the left
            )
    })

}
