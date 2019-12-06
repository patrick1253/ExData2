# plot 1 for JHU Exploratory Data Analysis Assignment 2: total PM2.5 emissions
# from all sources for each of the years 1999, 2002, 2005, and 2008.

library(dplyr)

data <- readRDS("summarySCC_PM25.rds")
codes <- readRDS("Source_Classification_Code.rds")

totalEmissions <- summarize(group_by(data, year), Year = unique(year), Emissions = sum(Emissions))

options(scipen=5)
par(mar=c(5,5,4,2))

png(file = "plot1.png",
    width = 480, height = 480, units = "px")

with(totalEmissions, 
    barplot <- barplot(Emissions/1000~Year, 
        main="Total Emissions by Selected Year \n (1000's of tons)",
        xlab="Year",
        ylab=expression("Total PM "[2.5]*" Emissions"), 
        las=2,
        ylim=c(0,8000)
    )
)    

dev.off()
