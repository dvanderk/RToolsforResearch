# Mapping based on Lat and Long data for Researchers
# Dee van der Knaap
# Last modified: 10/30/17

library(leaflet)
library(maps)
library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(# Application title
  titlePanel("Map"),
  
  # Sidebar with a slider input for the number of bins
  sidebarLayout(
    sidebarPanel(
      fileInput(
        'file1',
        'Choose CSV File',
        accept = c('text/csv', 'text/comma-separated-values,text/plain',
                   '.csv')
      ),
      #h5("...or paste two columns of data from Excel, seperated by a comma (do not include variable name)"),
      tags$textarea(id = "myData", rows = 10, cols = 5, ""),
      tags$hr(),
      #sliderInput(inputId = "bins",
      #            label = "Number of bins:",
      #            min = 1,
      #            max = 100,
      #            value = 20),
      checkboxInput('header', 'Header', TRUE),
      radioButtons('sep', 'Separator', c(Comma = ','), ','),
      radioButtons(
        "filetype",
        label = "File type for download",
        choices = list("pdf", "png")
      ),
      #textInput("numbreaks", label = "Enter the number of bins", width = "50%", placeholder = "10"),
      textInput(
        "graphtitle",
        label = "Enter graph title",
        width = "50%",
        placeholder = "[Title]"
      )
      #textInput("xlabel", label = "Enter x axis title", width = "50%", placeholder = "[x label]"),
      #textInput("ylabel", label = "Enter y axis title", width = "50%", placeholder = "[y label]")
    ),
    
    # Show a plot of the generated distribution
    fluidPage(
      # Give the page a title
      titlePanel("Global TestMyBrainUsers"),
      mainPanel(leafletOutput("map"))
    )
  )))