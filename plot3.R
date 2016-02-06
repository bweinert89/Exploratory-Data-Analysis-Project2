#Of the four types of sources indicated by the type
#(point, nonpoint, onroad, nonroad) variable,
#which of these four sources have seen decreases 
#in emissions from 1999-2008 for Baltimore City?

library(ggplot2)

# Load the NEI & SCC data frames.
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Subset the data for only Baltimore City
bcNEI <-subset(NEI,fips=="24510")

#Create Total as dataset
bcTotalNEI<-aggregate(Emissions ~ year+type, bcNEI,sum)

#Use ggplot to create a line graph with one panel to compare
qplot(year,Emissions,data=bcTotalNEI, color = type, geom="line",main="Total PM2.5 Emissions in Baltimore City, MD",
     xlab="Year", ylab="PM2.5 Emissions (Tons)")

#Write histogram to png with Width and Height = 480
dev.copy(png,file="plot3.png",width=480,height=480)
dev.off()