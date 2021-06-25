setSummary <- function(yAxis, fromDate, toDate, df) {
    df <- df %>%
        filter(Date_of_report >= as.POSIXct(fromDate) & Date_of_report <= as.POSIXct(toDate))
    fromDate <- format(fromDate, "%d-%m-%Y")
    toDate <- format(toDate, "%d-%m-%Y")
    if (yAxis=="Total_reported") {
        max <- max(df$Total_reported)
        min <- min(df$Total_reported)
        summary <- "Total reported number of positively tested people"
    } else if (yAxis=="Hospital_admission") {
        max <- max(df$Hospital_admission)
        min <- min(df$Hospital_admission)
        summary <- "Total number of hospital admissions"
    } else {
        max <- max(df$Total_deceased)
        min <- min(df$Total_deceased)
        summary <- "Total number of deceased"
    }
    summary <- paste(summary, " between ", fromDate, " and ", toDate, " is ", (max - min), ".", sep = "")
    return(summary)
}
