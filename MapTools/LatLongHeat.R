# PSYC 350 Lat/Long Problem
# Heat Map Version
# Dee van der Knaap
# Last modified: 10/13/2017

#read in data file
data<-(read.csv("/Users/dvanderknaap/Desktop/Organized/Wellesley 2017-2018/Classes - Fall/PSYC 350/SERP_Data.csv", header = TRUE))[-1,]
#select onlyt the ID, Latitude, Longitude
idlatlong <- subset(data, select=c("ID", "Latitude", "Longitude")) 
#remove NaN values
idlatlong <-na.omit(idlatlong)

#create world map
world <- get_map(location = c(lon = 0, lat = 0), 
                 zoom = 1, scale = 10, maptype = c("terrain"))
#ggmap(world)

#find frequencies
sum(idlatlong[2:3] >  0)

