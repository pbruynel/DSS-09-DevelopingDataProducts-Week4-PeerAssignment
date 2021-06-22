library(shiny)
library(ggplot2)


# Define server logic required to draw a histogram
server <- function(input, output) {
    df <- prepareData()
    
    # yAxis <- reactive({input$y})
    
    output$distPlot <- renderPlot({
        # generate bins based on input$bins from ui.R
        # x    <- faithful[, 2]
        # bins <- seq(min(x), max(x), length.out = input$bins + 1)

        # draw the histogram with the specified number of bins
        # hist(x, breaks = bins, col = 'darkgray', border = 'white')

        # df %>%
        #     ggplot(aes(x=Date_of_report, y=input$y, group=Province, color=Province)) +
        #     geom_line()
        df <- df %>%
                filter(Date_of_report >= as.POSIXct(input$dateRange[1]) & Date_of_report <= as.POSIXct(input$dateRange[2]))

        df %>%
            ggplot(aes_string(x = df$Date_of_report, y = input$y)) +
            geom_line()

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
    
    output$yValue <- renderText({
        paste0("Y-axis = ", input$y)
    })
}