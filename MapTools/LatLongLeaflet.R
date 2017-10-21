# PSYC 350 Lat/Long Problem
# Heat Map Version
# Dee van der Knaap
# Last modified: 10/13/2017

install.packages("leaflet")
install.packages("maps")
library(leaflet)
library(maps)

#read in data file
data<-(read.csv("/Users/dvanderknaap/Desktop/Organized/Wellesley 2017-2018/Classes - Fall/PSYC 350/RTools/MapTools/SERP_Data.csv", header = TRUE))[-1,]
#select onlyt the ID, Latitude, Longitude
idlatlong <- subset(data, select=c("ID", "Latitude", "Longitude")) 
#remove NaN values
idlatlong <-na.omit(idlatlong)

#create vectors of latitutde and longitude for ease of use
lon <- idlatlong$Longitude
lat <- idlatlong$Latitude
df <- as.data.frame(cbind(lon,lat))

#create map with lat and long dataframe
worldmap = data(worldMapEnv)
m <- leaflet(df)
#add default view to see map
m <- addTiles(m) 
#create circles objetc
m <- addCircles(m) #create circles objetc
#add our longitutde and latitude to the map
m <- addCircles(m, lng = ~lon, lat = ~lat, radius = 30) #radius in meters, changes as user zooms
#display map
m 




