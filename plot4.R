# Read data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
pngFileName <- "plot4.png"

# Subset and merge two dataset
coalScc <- SCC[grepl('Coal', SCC$Short.Name, fixed = T), ]
mergeData <- merge(x = NEI, y = coalScc, by = "SCC")

# Aggregation
aggCoalEmi <- aggregate(Emissions ~ year, mergeData, sum)

ggplot(data = aggCoalEmi, aes(x = year, y = Emissions)) +
  xlab("Year") +
  ylab("Emissions (tons)") +
  geom_line() +
  geom_text(aes(label=Emissions), vjust=1) +
  geom_point(size = 4, shape = 21, fill = "white") +
  ggtitle(expression('Total Emissions of PM'[2.5]))

dev.copy(png, file = pngFileName)
dev.off()