prepareData <- function(fromDate=NULL, toDate=NULL) {
    library(lubridate)
    library(tidyr)
    library(dplyr)
    library(ggplot2)
    
    # url <- "https://data.rivm.nl/covid-19/COVID-19_aantallen_gemeente_cumulatief.csv"
    # df <- read.csv2(url)
    df <- read.csv2("COVID-19_aantallen_gemeente_cumulatief.csv")
    
    df$Date_of_report <- as.Date(ymd_hms(df$Date_of_report))
    if (is.null(fromDate)) {
        fromDate <- min(df$Date_of_report)
    }
    if (is.null(toDate)) {
        toDate <- max(df$Date_of_report)
    }
    
    df["Province"][df["Province"] == "Fryslân"] <- "Friesland"
    # Remove empty Provinces
    df <- df[df$Province!="",]
    # df <- df %>%
    #     select(c(Date_of_report, Province, Total_reported, Hospital_admission, Deceased)) %>%
    #     arrange(Date_of_report, Province, Total_reported) %>%
    #     group_by(Date_of_report, Province) %>%
    #     summarise(Total_reported = sum(Total_reported), Hospital_admission=sum(Hospital_admission), Total_deceased=sum(Deceased))
    # ungroup(df)
    df1 <- df %>%
        group_by(Date_of_report) %>%
        summarise(Total_reported = sum(Total_reported), Hospital_admission=sum(Hospital_admission), Total_deceased=sum(Deceased))
    ungroup(df1)
    # df %>%
    #     ggplot( aes(x=Date_of_report, y=Total_Deceased, group=Province, color=Province)) +
    #     geom_line()
    return(df1)
}
