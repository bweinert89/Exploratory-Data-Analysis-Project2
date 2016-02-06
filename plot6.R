#Compare emissions from motor vehicle sources in Baltimore City 
#with emissions from motor vehicle sources in Los Angeles County

# Load the NEI & SCC data frames.
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Fine Motor Vehicle Sources in SCC
vSCC<-SCC[grep("Vehicle",SCC$EI.Sector,ignore.case=TRUE),]

#Now match bcNEI with SCC for baltimore and la
vbcNEI<-subset(NEI,NEI$SCC %in% vSCC$SCC & fips=="24510")
vlaNEI<-subset(NEI,NEI$SCC %in% vSCC$SCC & fips=="06037")

#Add city column and then bind by row
vbcNEI$city="Baltimore City"
vlaNEI$city="Los Angeles County"

vNEI<-rbind(vbcNEI,vlaNEI)
vTotalNEI<-aggregate(Emissions~year+city,vNEI,sum)

qplot(year,Emissions,data=vTotalNEI,color=city,
      main="PM2.5 Emissions from Motor Vehicles",
      xlab="Year",
      ylab="Motor Vehicle-Related PM2.5 Emissions (Tons)",
      geom="line")

#Write histogram to png with Width and Height = 480
dev.copy(png,file="plot6.png",width=480,height=480)
dev.off()
