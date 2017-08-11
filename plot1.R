# Read data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
pngFileName <- "plot1.png"

# Aggregation
aggEmi <- aggregate(Emissions ~ year, NEI, sum)

barplot(aggEmi$Emissions/1000,
        names.arg = aggEmi$year,
        main = expression('Total Emission of PM'[2.5]),
        xlab = 'Year',
        ylab = expression(paste('PM', ''[2.5], ' in Kilotons')))

dev.copy(png, file = pngFileName)
dev.off()