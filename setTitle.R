setTitle <- function(yAxis) {
    # Prepare the y label
    if (yAxis=="Total_reported") {
        title <- "Total reported number of positively tested people"
    } else if (yAxis=="Hospital_admission") {
        title <- "Total number of hospital admissions"
    } else {
        title <- "Total number of deceased"
    }
    return(title)
}
