# Load ggplot2 library
library(ggplot2)

# Read data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
pngFileName <- "plot3.png"

NEI_Sampling <- subset(NEI, NEI$fips == "24510")

# Aggregation
aggEmi <- aggregate(Emissions ~ year + type, NEI_Sampling, sum)

ggplot(data = aggEmi,aes(x = year, y = Emissions, group = type, color = type)) +
  xlab("Year") +
  ylab("Emissions (tons)") +
  geom_line() +
  geom_point(size = 4, shape = 21, fill = "white")
dev.copy(png, file = pngFileName)
dev.off()