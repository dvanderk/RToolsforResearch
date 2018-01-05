# PSYC 350 Lat/Long Problem
# Heat Map Version
# Dee van der Knaap
# Last modified: 10/13/2017
data<-(read.csv("/Users/deevanderknaap/Desktop/Organized/Wellesley 2017-2018/Classes - Fall/PSYC 350/RTools/MapTools/SERP_Data.csv", header = TRUE))[-1,]
install.packages("leaflet")
install.packages("maps")
library(leaflet)
library(maps)

#read in data file
data<-(read.csv("data.csv", header = TRUE))[-1,]
#select onlyt the ID, Latitude, Longitude
idlatlong <- subset(data, select=c("ID", "Latitude", "Longitude")) 
#remove NaN values
idlatlong <-na.omit(idlatlong)

#create vectors of latitutde and longitude for ease of use
lon <- idlatlong$Longitude
lat <- idlatlong$Latitude
df <- as.data.frame(cbind(lon,lat))

# #create map with lat and long dataframe
# worldmap = data(worldMapEnv)
# m <- leaflet(df) %>%
#   #add default view to see map
#   addTiles(m) %>%
#   #create circles objetc
#   addCircles(m) %>%
#   #add our longitutde and latitude to the map
#   addCircles(lng = ~lon, lat = ~lat, radius = 30) #radius in meters, changes as user zooms
# #display map
# m

# #create map with lat and long dataframe
worldmap = data(worldMapEnv)
m <- leaflet(data =df)
#add tiles to view the map
m <- addTiles(m, urlTemplate = 'http://{s}.basemaps.cartocdn.com/light_all/{z}/{x}/{y}.png')
#create circles object
m <- addCircles(m) #create circles object
#add our longitutde and latitude to the map
m <- addCircles(m, lng = ~lon, lat = ~lat, radius = 30) #radius in meters, changes as user zooms
#display map
m



