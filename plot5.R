#How have emissions from motor vehicle sources 
#changed from 1999-2008 in Baltimore City?

library(ggplot2)

# Load the NEI & SCC data frames.
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Subset the data for only Baltimore City
bcNEI <-subset(NEI,fips=="24510")

#Fine Motor Vehicle Sources in SCC
vSCC<-SCC[grep("Vehicle",SCC$EI.Sector,ignore.case=TRUE),]

#Now match bcNEI with SCC
vbcNEI<-subset(bcNEI,bcNEI$SCC %in% vSCC$SCC)

#Create Total as dataset
vbcTotalNEI<-aggregate(Emissions ~ year, vbcNEI,sum)

ggplot(vbcTotalNEI, aes(factor(year),Emissions)) +
   geom_bar(stat="identity",width=0.75) + 
   labs(title="PM2.5 Emissions by Motor Vehicles in Baltimore City, MD",
           x="Year",
           y="Motor Vehicle-Related PM2.5 Emissions (Tons)")

#Write histogram to png with Width and Height = 480
dev.copy(png,file="plot5.png",width=480,height=480)
dev.off()