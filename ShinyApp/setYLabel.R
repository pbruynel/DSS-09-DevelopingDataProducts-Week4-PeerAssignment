# Composes the label of the y-axis.
setYLabel <- function(yAxis) {
    if (yAxis=="Total_reported") {
        yLabel <- "Total reported infections"
    } else if (yAxis=="Hospital_admission") {
        yLabel <- "Hospital admission"
    } else {
        yLabel <- "Deceased"
    }
    return(yLabel)
}
