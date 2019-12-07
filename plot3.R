# plot 3 for JHU Exploratory Data Analysis Assignment 2: Of the four 
# types of sources indicated by the type (point, nonpoint, onroad, nonroad) 
# variable, which of these four sources have seen decreases in emissions 
# from 1999–2008 for Baltimore City? Which have seen increases in 
# emissions from 1999–2008? 

library(dplyr)
library(ggplot2)

#read in the raw data
data <- readRDS("summarySCC_PM25.rds")
codes <- readRDS("Source_Classification_Code.rds")

# subset Baltimore date; group data of interest by year and type
baltimoreEmissions <- filter(data, fips == "24510")
totalEmissions <- summarize(group_by(baltimoreEmissions, year, type), Year = unique(year), Type = unique(type), Emissions = sum(Emissions))

# to prevent plot() from using scientific notation on the y axis
options(scipen=5)
#par(mar=c(5,5,4,2))

# to save the resulting plot to a PNG file
png(file = "plot3.png",
    width = 800, height = 600, units = "px")

# generate barplot
g <- ggplot(totalEmissions, aes(factor(Year), Emissions, fill=type, label=round(Emissions,0)))+
    geom_col()+
    facet_grid(.~type)+
    xlab("Year")+
    geom_text(color="black", check_overlap=TRUE, size=3)+
    ggtitle("Baltimore Emissions in Selected Years by Source")
print(g)

# close PNG device
dev.off()
