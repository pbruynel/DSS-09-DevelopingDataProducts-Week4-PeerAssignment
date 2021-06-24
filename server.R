library(shiny)
library(ggplot2)

source('setYLabel.R')
source('setTitle.R')
source('setSubtitle.R')

# Define server logic required to draw a histogram
server <- function(input, output) {
    df <- prepareData()

    output$distPlot <- renderPlot({
        # load data if necessary
        dataIsActual <- (Sys.Date() - ddays(2)) < max(df$Date_of_report)
        # print(paste("max date =", max(df$Date_of_report)))
        # if user wants latest data and data is not actual, then load latest data
        # else if user wants local data and data is actual then load local data
        # else no action required
        if (input$actualData & !dataIsActual){
            # print("load actual data")
            df <<- prepareData(update=TRUE)
            dataIsActual <- (Sys.Date() - ddays(2)) < max(df$Date_of_report)
            # print(paste0("Update = ", input$actualData, 
            #              "; data is actual = ", dataIsActual, 
            #              "; max date =", max(df$Date_of_report)))
        } else if (!input$actualData & dataIsActual) {
            # print("load local data")
            df <<- prepareData(update=FALSE)
            dataIsActual <- (Sys.Date() - ddays(2)) < max(df$Date_of_report)
            # print(paste0("Update = ", input$actualData, 
            #              "; data is actual = ", dataIsActual, 
            #              "; max date =", max(df$Date_of_report)))
        } else {
            # print("no action required")
            # print(paste0("Update = ", input$actualData, 
            #              "; data is actual = ", dataIsActual, 
            #              "; max date =", max(df$Date_of_report)))
        }

        df <- df %>%
            filter(Date_of_report >= as.POSIXct(input$dateRange[1]) & Date_of_report <= as.POSIXct(input$dateRange[2]))
        
        yAxis <- input$y
        yLabel <- setYLabel(yAxis)
        
        plotTitle <- setTitle(yAxis)
        plotSubtitle <- setSubtitle(yAxis, input$dateRange[1], input$dateRange[2], df)
        plotCaption <- "Source: RIVM Netherlands (https://data.rivm.nl/covid-19/)"

        # df %>%
        #     ggplot(aes(x=Date_of_report, y=input$y, group=Province, color=Province)) +
        #     geom_line()

        # df %>%
        #     ggplot(aes_string(x = df$Date_of_report, y = input$y)) +
        #     geom_line() +
        #     labs(x = "Date", y = yLabel, title = plotTitle)
        
        df %>%
            ggplot(aes_string(x = df$Date_of_report, y = input$y)) +
            geom_line() +
            labs(x = "Date", y = yLabel, title = plotTitle, subtitle = plotSubtitle, caption = plotCaption) +
            theme(
                plot.title = element_text(hjust = 0.5, size = 16),    # Center title position and size
                plot.subtitle = element_text(hjust = 0.5, size = 14),            # Center subtitle
                plot.caption = element_text(hjust = 0, face = "italic", size = 12) # move caption to the left
            )
        
        # if (yAxis==Total_reported) {
        #     df %>% ggplot(aes(x=Date_of_report, y=Total_reported, group=Province, color=Province)) +
        #         geom_line()
        # } else if (yAxis==Hospital_admission) {
        #     ggplot(data = df, aes(x=Date_of_report, y=Hospital_admission, group=Province, color=Province)) +
        #         geom_line()
        # } else {
        #     ggplot(data = df, aes(x=Date_of_report, y=Total_deceased, group=Province, color=Province)) +
        #         geom_line()
        # }
    })

    output$summary <- renderText({
        input$actualData
        setSummary(input$y, input$dateRange[1], input$dateRange[2], df)
    })
    
    output$update <- renderText({
        paste0("Update = ", input$actualData, 
               "; max date =", max(df$Date_of_report))
    })
    

}
