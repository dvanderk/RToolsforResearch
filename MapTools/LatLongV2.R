
# PSYC 350 Lat/Long Problem Version 2

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
#idlatlong <-na.omit(idlatlong)

lon <- idlatlong[2:7,]$V13
lat <- idlatlong[2:7,]$V12
#lon <- idlatlong$V13
#$lat <- idlatlong$V12
df <- as.data.frame(cbind(lon,lat))

#finds what zoom measure to use for the map
mapzoom <- calc_zoom(lon, lat, df, f = 0.05)

##create new map
maplonglat <- get_map(location = c(mean(lon), mean(lat)), zoom = mapzoom - 1, 
                      maptype = "satellite", scale = 1)

# plot the map with some points on it
pointsmap <- ggmap(maplonglat) + 
  geom_point(data = df, aes(x = lon, y = lat, fill = "red", alpha = 1), size = 2, shape = 21) + 
  guides(fill=FALSE, alpha=FALSE, size=FALSE)

pointsmap


