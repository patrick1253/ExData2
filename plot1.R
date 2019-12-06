# plot 1 for JHU Exploratory Data Analysis Assignment 2: total PM2.5 emissions
# from all sources for each of the years 1999, 2002, 2005, and 2008.

library(dplyr)

#read in the raw data
data <- readRDS("summarySCC_PM25.rds")
codes <- readRDS("Source_Classification_Code.rds")

# group data of interest by year
totalEmissions <- summarize(group_by(data, year), Year = unique(year), Emissions = sum(Emissions))

# to prevent plot() from using scientific notation on the y axis
options(scipen=5)
par(mar=c(5,5,4,2))

# to save the resulting plot to a PNG file
png(file = "plot1.png",
    width = 480, height = 480, units = "px")

# generate barplot
with(totalEmissions, 
    barplot <- barplot(Emissions/1000~Year, 
        main="Total Emissions by Selected Year \n (1000's of tons)",
        xlab="Year",
        ylab=expression("Total PM "[2.5]*" Emissions"), 
        las=2,
        ylim=c(0,8000)
    )
)    

# close PNG device
dev.off()
