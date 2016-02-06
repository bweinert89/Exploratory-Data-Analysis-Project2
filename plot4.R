#Across the United States, how have emissions 
#from coal combustion-related sources changed from 1999-2008?

library(ggplot2)

# Load the NEI & SCC data frames.
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Find Coal Combustion in SCC
ccSCC<-SCC[grep("Fuel Comb - [a-zA-Z //  --]* - Coal",SCC$EI.Sector),]

#Now match NEI with SCC
ccNEI<-subset(NEI,NEI$SCC %in% ccSCC$SCC)

#Create Total as dataset by type and year
ccTotalTypeNEI<-aggregate(Emissions ~ year+type, ccNEI,sum)


qplot(year,Emissions,data=ccTotalTypeNEI,color=type,geom="line",
      main ="Total Coal-Related PM2.5 Emissions", 
      xlab="Year",ylab="Coal-Related PM2.5 Emissions (Tons)") + 
 stat_summary(fun.y = "sum", fun.ymin = "sum", fun.ymax = "sum",color="black",aes(shape="total"),geom="line") +
 geom_line(aes(size="total", shape = NA))

#Write histogram to png with Width and Height = 480
dev.copy(png,file="plot4.png",width=480,height=480)
dev.off()
