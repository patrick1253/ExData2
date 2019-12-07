# plot 4 for JHU Exploratory Data Analysis Assignment 2: Across the 
# United States, how have emissions from coal combustion-related sources 
# changed from 1999–2008? 

library(dplyr)
library(ggplot2)

#read in the raw data
data <- readRDS("summarySCC_PM25.rds")
codes <- readRDS("Source_Classification_Code.rds")

# subset data to just coal-combustion related sources
coal <- grepl(".*[Cc]oal.*", codes$Short.Name)
coalCodes <- codes[c(coal),]
coalData <- filter(data, data$SCC %in% coalCodes$SCC)

# group data of interest by year
coalEmissions <- summarize(group_by(coalData, year), 
                            Year = unique(year), 
                            Emissions = sum(Emissions))

# to prevent plot() from using scientific notation on the y axis
options(scipen=5)
par(mar=c(5,5,4,2))

# to save the resulting plot to a PNG file
png(file = "plot4.png",
    width = 800, height = 600, units = "px")

# generate barplot
g <- ggplot(coalEmissions, aes(factor(year), Emissions/1000,
                                  fill=year, label=round(Emissions,0)))+
    geom_col()+
    xlab("Year")+
    ylab(expression("Total PM "[2.5]*" Emissions"))+
    geom_label(color="white", size=3)+
    ggtitle("Coal-Sourced Emissions in Selected Years \n (1000's of tons)")
print(g)

# close PNG device
dev.off()
