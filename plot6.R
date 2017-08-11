# Load library
library(plyr)
library(ggplot2)

# Read data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
pngFileName <- "plot6.png"

motorScc <- SCC[grepl('vehicle', SCC$SCC.Level.Two, ignore.case=T), ]
mergeData <- merge(x = NEI, y = motorScc, by = "SCC")
motorBalEmi <- subset(mergeData, mergeData$fips == "24510" )
motorLaEmi <-  subset(mergeData, mergeData$fips == "06037")
motorBalEmi$city <- "Baltimore"
motorLaEmi$city <- "Los Angeles"
motorMergeEmi <- rbind(motorBalEmi, motorLaEmi)

aggData <- aggregate(Emissions ~ year + city, motorMergeEmi, sum)

ggplot(aggData, aes(year, Emissions, color = city)) +
  xlab("Year") +
  ylab(expression("Total PM"[2.5]*" Emission (Kilo-Tons)")) +
  geom_line() +
  ggtitle("Total Emissions from motor vehicle in Baltimore & LA")

dev.copy(png, filename = pngFileName)
dev.off ()