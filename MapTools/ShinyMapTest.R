# Mapping based on Lat and Long data for Researchers
# Dee van der Knaap
# Last modified: 10/30/17

library(leaflet)
library(maps)
library(shiny)

ui <- fluidPage(leafletOutput("map1"))

server <- function(input, output, session) {
  output$map1 <- renderLeaflet({
    leaflet() %>% addCircleMarkers(lng = runif(10), lat = runif(10), 
                                   layerId = paste0("marker", 1:10))
  })
  
  observeEvent(input$map1_marker_click, {
    leafletProxy("map1", session) %>% removeMarker(input$map1_marker_click$id)
  })
}

shinyApp(ui, server)