# Read data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
pngFileName <- "plot2.png"

NEI_Sampling <- subset(NEI, NEI$fips == "24510")

# Aggregation
aggEmi <- aggregate(Emissions ~ year, NEI_Sampling, sum)

barplot(aggEmi$Emissions/1000,
        names.arg = aggEmi$year,
        main = expression(paste('Total Emission of PM',''[2.5], ' in Baltimore City')),
        xlab = 'Year',
        ylab = expression(paste('PM', ''[2.5], ' in Kilotons')))
dev.copy(png, file = pngFileName)
dev.off()