# Mapping based on Lat and Long data for Researchers
# Dee van der Knaap
# Last modified: 10/30/17
#To run on Dee's computer: runApp("/Users/deevanderknaap/Desktop/Organized/Wellesley 2017-2018/Classes - Fall/PSYC 350/RTools/MapTools")

library(leaflet)
library(maps)
library(shiny)

shinyServer(function(input, output) {
  
  output$latlongmap <- renderLeaflet({
    # Else
    inFile <- input$file1 # Grab uploaded file
    c <-
      read.csv(inFile$datapath,
               header = input$header,
               sep = input$sep) # Read the csv into a variable
    idlatlong <-
      subset(c, select = c("ID", "Latitude", "Longitude"))  # Select the three columns with relevant data
    idlatlong <- na.omit(idlatlong) # remove NaN values
    
    lon <- idlatlong$Longitude
    lat <- idlatlong$Latitude
    df <- as.data.frame(cbind(lon, lat))
    
    leaflet(df)
    
    # Create map with lat and long dataframe
    output$mymap <- renderLeaflet({
      leaflet() %>%
        leaflet(df) %>%
        #add default view to see map
        addTiles() %>%
        #create circles objetc
        addCircles() %>%
        #add our longitutde and latitude to the map
        addCircles(lng = ~lon, lat = ~lat, radius = 30) #radius in meters, changes as user zooms
    })
    
  })
})



# # Save as 'filename' the 'content'
# output$down <- downloadHandler(
#   filename =  function() {
#     paste("mymap", input$filetype, sep = ".")
#   },
#
#   # content is a function with argument file. content writes the plot to the device
#   content = function(file) {
#     if (input$filetype == "png")
#       png(file) # open the png device
#     else
#       pdf(file) # open the pdf device
#
#     worldmap = data(worldMapEnv)
#     m <- leaflet(df) # add default view to see map
#     m <- addTiles(m) # add default view to see map
#     m <- addCircles(m) # create circles object
#     # add our longitutde and latitude to the map
#     m <-
#       addCircles(m,
#                  lng = ~ lon,
#                  lat = ~ lat,
#                  radius = 30) #  radius in meters, changes as user zooms
#     m # display map
#     dev.off()  # turn the device off
#   }
# )
