# plot 6 for JHU Exploratory Data Analysis Assignment 2: Compare emissions 
# from motor vehicle sources in Baltimore City with emissions from motor 
# vehicle sources in Los Angeles County, California (fips == "06037"). Which 
# city has seen greater changes over time in motor vehicle emissions?

library(dplyr)
library(ggplot2)

#read in the raw data
data <- readRDS("summarySCC_PM25.rds")
codes <- readRDS("Source_Classification_Code.rds")

# subset Baltimore and LA data
baltData <- filter(data, fips == "24510")
baltData$City <- "Baltimore, MD"
laData <- filter(data, fips == "06037")
laData$City <- "Los Angeles, CA"
bothData <- rbind(baltData, laData)

# search for "veh" in codes and use results to create subset of data
veh <- grepl(".*[Vv]eh.*", codes$Short.Name)
vehCodes <- codes[c(veh),]
bothVehData <- filter(bothData, bothData$SCC %in% vehCodes$SCC)

# group data of interest by year and city
bothVehEmissions <- summarize(group_by(bothVehData, City, year), 
                              Year = unique(year),  
                              Emissions = sum(Emissions))

# to prevent plot() from using scientific notation on the y axis
options(scipen=5)
#par(mar=c(5,5,4,2))

# to save the resulting plot to a PNG file
png(file = "plot6.png",
    width = 800, height = 600, units = "px")

# generate barplot
g <- ggplot(bothVehEmissions, aes(factor(year), Emissions,
                                  fill=City, label=round(Emissions,0)))+
    geom_col()+
    facet_grid(City~., scales="free")+
    xlab("Year")+
    geom_label(color="white", size=3)+
    ggtitle("Baltimore vs. Los Angeles Vehicle Emissions (in tons)")
print(g)

# close PNG device
dev.off()
