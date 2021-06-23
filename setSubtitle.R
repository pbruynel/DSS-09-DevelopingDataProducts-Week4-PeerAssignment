setSubtitle <- function(yAxis, fromDate, toDate, df) {
    fromDate <- format(fromDate, "%d-%m-%Y")
    toDate <- format(toDate, "%d-%m-%Y")
    if (yAxis=="Total_reported") {
        max <- max(df$Total_reported)
        min <- min(df$Total_reported)
    } else if (yAxis=="Hospital_admission") {
        max <- max(df$Hospital_admission)
        min <- min(df$Hospital_admission)
    } else {
        max <- max(df$Total_deceased)
        min <- min(df$Total_deceased)
    }
    subtitle <- paste("Between ", fromDate, " and ", toDate, ": ", (max - min), sep = "")
    return(subtitle)
}
