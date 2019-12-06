# plot 2 for JHU Exploratory Data Analysis Assignment 2: Have total 
# emissions from PM2.5 decreased in the Baltimore City, Maryland 
# (fips == "24510") from 1999 to 2008? 

library(dplyr)

#read in the raw data
data <- readRDS("summarySCC_PM25.rds")
codes <- readRDS("Source_Classification_Code.rds")

# subset Baltimore date; group data of interest by year
baltimoreEmissions <- filter(data, fips == "24510")
totalEmissions <- summarize(group_by(baltimoreEmissions, year), Year = unique(year), Emissions = sum(Emissions))

# to prevent plot() from using scientific notation on the y axis
options(scipen=5)
par(mar=c(5,5,4,2))

# to save the resulting plot to a PNG file
png(file = "plot2.png",
    width = 480, height = 480, units = "px")

# generate barplot
with(totalEmissions, 
     barplot <- barplot(Emissions~Year, 
                        main="Total Emissions In Baltimore by Selected Year",
                        xlab="Year",
                        ylab=expression("Total PM "[2.5]*" Emissions"), 
                        las=2,
                        ylim=c(0,4000)
     )
)    

# close PNG device
dev.off()
