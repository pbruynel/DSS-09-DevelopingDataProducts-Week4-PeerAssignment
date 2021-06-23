setYLabel <- function(yAxis) {
    # Prepare the y label
    if (yAxis=="Total_reported") {
        yLabel <- "Total reported"
    } else if (yAxis=="Hospital_admission") {
        yLabel <- "Hospital admission"
    } else {
        yLabel <- "Deceased"
    }
    return(yLabel)
}
