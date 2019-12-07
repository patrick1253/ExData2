# # plot 5 for JHU Exploratory Data Analysis Assignment 2: How have 
# emissions from motor vehicle sources changed from 1999–2008 in 
# Baltimore City? 

library(dplyr)
library(ggplot2)

#read in the raw data
data <- readRDS("summarySCC_PM25.rds")
codes <- readRDS("Source_Classification_Code.rds")

# subset Baltimore data
baltData <- filter(data, fips == "24510")

# search for "veh" in codes and use results to create subset of data
veh <- grepl(".*[Vv]eh.*", codes$Short.Name)
vehCodes <- codes[c(veh),]
vehData <- filter(baltData, baltData$SCC %in% vehCodes$SCC)

# group data of interest by year
baltVehEmissions <- summarize(group_by(vehData, year), 
                            Year = unique(year),
                            Emissions = sum(Emissions))

# to prevent plot() from using scientific notation on the y axis
options(scipen=5)
#par(mar=c(5,5,4,2))

# to save the resulting plot to a PNG file
png(file = "plot5.png",
    width = 800, height = 600, units = "px")

# generate barplot
g <- ggplot(baltVehEmissions, aes(factor(year), Emissions,
                              fill=year, label=round(Emissions,0)))+
    geom_col()+
    xlab("Year")+
    geom_label(color="white", size=3)+
    ggtitle("Baltimore Vehicle Emissions in Selected Years")
print(g)

# close PNG device
dev.off()
