
# PSYC 350 Lat/Long Problem Version 2

install.packages("maps")
install.packages("ggmap")
install.packages("ggplot2")
library(maps)
library(ggplot2)
library(ggmap)

#read in data file
data<-(read.csv("/Users/dvanderknaap/Desktop/Organized/Wellesley 2017-2018/Classes - Fall/PSYC 350/RTools/MapTools/SERP_Data.csv", header = TRUE))[-1,]
#select onlyt the ID, Latitude, Longitude
idlatlong <- subset(data, select=c("ID", "Latitude", "Longitude")) 

#clean data, removing lines with NaN values
#idlatlong<-idlatlong[complete.cases(idlatlong), ]
idlatlong <-na.omit(idlatlong)

lon <- idlatlong$Longitude
lat <- idlatlong$Latitude
#lon <- idlatlong$V13
#$lat <- idlatlong$V12
df <- as.data.frame(cbind(lon,lat))

#finds what zoom measure to use for the map
mapzoom <- calc_zoom(lon, lat, df, f = 0.05)

##create new map
maplonglat <- get_map(location = c(mean(lon), mean(lat)), zoom = 3, 
                      maptype = "satellite", scale = 1)

#first load the map
ggmap(maplonglat)
# plot the map with some points on it
pointsmap <- ggmap(maplonglat) + 
  geom_point(data = df, aes(x = lon, y = lat, fill = "red", alpha = 1), size = 2, shape = 21) + 
  guides(fill=FALSE, alpha=FALSE, size=FALSE)
pointsmap


