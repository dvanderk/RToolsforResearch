# PSYC 350 Lat/Long Problem
install.packages("maps")
install.packages("ggmap")
install.packages("ggplot2")
library(maps)
library(ggplot2)
library(ggmap)

#read in the file and get column names
latlongheader<-head(read.csv("/Users/dvanderknaap/Desktop/Organized/Wellesley 2017-2018/Classes - Fall/PSYC 350/SERP_Data.csv", header = FALSE), 1)
latlong<-read.csv("/Users/dvanderknaap/Desktop/Organized/Wellesley 2017-2018/Classes - Fall/PSYC 350/SERP_Data.csv", skip = 2, header = FALSE)
#change column names to real headers
#colnames(latlong) <- as.vector(latlongheader) #not working, not sure why

#keep only ID, latitude, and longitude
idlatlong <- subset(latlong, select=c("V1", "V12", "V13")) #change to ID, Latitude, Longitude when colnames is working

#clean data, removing lines with NaN values
#idlatlong<-idlatlong[complete.cases(idlatlong), ]
idlatlong <-na.omit(idlatlong)

longs <- idlatlong$V13
lats <- idlatlong$V12
df <- as.data.frame(cbind(longs,lats))

worldmap<-map_data("world")
worldmap

#Creat a base plot with gpplot2
p <- ggplot() + coord_fixed() +
  xlab("") + ylab("")

#Add map to base plot
base_world_messy <- p + geom_polygon(data=worldmap, aes(x=long, y=lat, group=group), 
                                     colour="white", fill="black")
cleanup <- 
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(), 
        panel.background = element_rect(fill = 'white', colour = 'white'), 
        axis.line = element_line(colour = "white"), legend.position="none",
        axis.ticks=element_blank(), axis.text.x=element_blank(),
        axis.text.y=element_blank())

base_world <- base_world_messy + cleanup
base_world

map_data <- base_world +
  geom_point(data = df, aes(x = longs, y = lats, fill = "red", alpha = 0.1), size = 1, shape = 21) + 
  guides(fill=FALSE, alpha=FALSE, size=FALSE)
map_data
