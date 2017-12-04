library(shiny)

shinyServer( # Function title (don't think this is necessary)
  
  function(input, output) { # Create the function
  
    output$distPlot <- renderPlot({ # Call Shiny function that makes the plot
  
      # Get the data
    if (is.null(input$file1)) { # If there's no csv file uploaded yet
      d=faithful[, 1:2] # Grab canned data set to plot
    } 
      else { # Else
      inFile <- input$file1 # Grab uploaded file
      c <- read.csv(inFile$datapath, header=input$header, sep=input$sep) # Read the csv into a variable
      d=c[, 1:2] # Take the first two columns of that variable
      }
      
    x=d[, 1] # Gets x value
    y=d[, 2] # Gets y value
    
     # Find good axis ranges
    xmin=min(x); xmax=max(x); ymin=min(y); ymax=max(y); # Finds min and max values
    xsd=sd(x) ; ysd=sd(y); # Finds SDs
    xsds=(xmax-xmin)/xsd; ysds=(ymax-ymin)/ysd; # Finds out how many SDs each variable spans
    
    if (xsds>ysds)  { # If X span is bigger...
      xlim=c(xmin-xsd*.25,xmax+xsd*.25) # Set X axis to range its actual range plus .25 SD cushion
      sdcush=(xsds-ysds)/2; # Find difference between SD ranges and divide by two (will add this as extra cushion to Y axis range)
      ylim=c(ymin-ysd*.25-ysd*sdcush,ymax+ysd*.25+ysd*sdcush) # Set Y axis range to the SD equivalent of X axis range (centered on Y axis range) plus .25 SD cushion
    } 
    else { # If Y span is bigger
      ylim=c(ymin-ysd*.25,ymax+ysd*.25) # Set Y axis to its actual range plus .25 SD cushion
      sdcush=(ysds-xsds)/2; # Find difference between SD ranges and divide by two (will add this as extra cushion to X axis range)
      xlim=c(xmin-xsd*.25-xsd*sdcush,xmax+xsd*.25+xsd*sdcush) # Set X axis range to the SD equivalent of Y axis range (centered on X axis range) plus .25 SD cushion
    }
    
  
    # Draw the scatterplot
    par(pty="s") # Forces the scatterplot to be square
    plot(x, y, main=input$graphtitle, # Plots data
         xlab="X label ", ylab="Y label ", pch=19, # pch selects symbol
         xlim=xlim, ylim=ylim) # xlim and ylim set the axis ranges
    abline(lm(y~x), col="red") # Draws least-squares line
  
    # Save as 'filename' the 'content'
    output$down <- downloadHandler(
      filename =  function() {
        paste("myplot", input$filetype, sep=".")
      },
      
      # content is a function with argument file. content writes the plot to the device
      content = function(file) {
        if(input$filetype == "png")
          png(file) # open the png device
        else
          pdf(file) # open the pdf device
        
        par(pty="s") # Forces the scatterplot to be square
        plot(x=x, y=y, main=input$graphtitle, # Plots data
             xlab="X label ", ylab="Y label ", pch=19, # pch selects symbol
             xlim=xlim, ylim=ylim) # xlim and ylim set the axis ranges
             abline(lm(y~x), col="red") # Draws least-squares line
        dev.off()  # turn the device off
      })
  })
})