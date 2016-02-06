#Have total emissions from PM2.5 decreased in the Baltimore City,
#Maryland (fips == "24510") from 1999 to 2008?

# Load the NEI & SCC data frames.
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Subset the data for only Baltimore City
bcNEI <-subset(NEI,fips=="24510")

#Calculate the total
bcTotalPM25yr <- tapply(bcNEI$Emissions, bcNEI$year, sum)

#Make a bar plot
barplot(bcTotalPM25yr,main="Total PM2.5 Emissions in Baltimore City, MD",ylab = "PM2.5 Emissions (Tons)",
        xlab="year")

#Write histogram to png with Width and Height = 480
dev.copy(png,file="plot2.png",width=480,height=480)
dev.off()