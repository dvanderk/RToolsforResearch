library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Scatterplot widget"),
  
  # Sidebar with a slider input for the number of bins
  sidebarLayout(
    sidebarPanel(
      fileInput('file1', 'Choose CSV File',
                accept=c('text/csv', 
                         'text/comma-separated-values,text/plain', 
                         '.csv')),
      tags$hr(),
      checkboxInput('header', 'Header', TRUE),
      radioButtons('sep', 'Separator',
                   c(Comma=',',
                     Semicolon=';',
                     Tab='\t'),
                   ','),
      #radioButtons("filetype", label = "File type for download", choices = list("png", "pdf")),
      textInput("graphtitle", label = "Enter graph title", width = "50%", placeholder = "[Title]"),
      radioButtons("filetype", label = "File type for download", choices = list("png", "pdf")),
      downloadButton(outputId = "down", label = "Download the plot")
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      plotOutput("distPlot")
      #radioButtons("filetype", label = "File type for download", choices = list("png", "pdf")),
      #downloadButton(outputId = "down", label = "Download the plot")
    )
  )
))