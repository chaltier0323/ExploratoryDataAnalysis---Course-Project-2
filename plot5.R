# Load library
library(plyr)
library(ggplot2)

# Read data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
pngFileName <- "plot5.png"

motorScc <- SCC[grepl('vehicle', SCC$SCC.Level.Two, ignore.case = T), ]
mergeData <- merge(x = NEI, y = motorScc, by = "SCC")

motorBalEmi <- subset(mergeData, mergeData$fips == "24510")

ggplot(motorBalEmi, aes(factor(year), Emissions)) +
  geom_bar(stat = "identity", fill = "grey", width = 0.75) +
  theme_bw() + 
  guides(fill = FALSE) +
  labs(x = "Year", y = expression("Emissions (thousands of tons)")) + 
  labs(title = expression("Baltimore Emissions from Motorcycle"))

dev.copy(png, filename = pngFileName)
dev.off ()
