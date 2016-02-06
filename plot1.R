#Using the base plotting system, 
#make a plot showing the total PM2.5 emission from all sources 
#for each of the years 1999, 2002, 2005, and 2008.

# Load the NEI & SCC data frames.
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Calculate the total 
totalPM25yr <- tapply(NEI$Emissions, NEI$year, sum)

#Make a bar plot
barplot(totalPM25yr,main="Total PM2.5 Emissions in the US",ylab = "PM2.5 Emissions (Tons)",
        xlab="year")

#Write histogram to png with Width and Height = 480
dev.copy(png,file="plot1.png",width=480,height=480)
dev.off()