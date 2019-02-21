#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(igraph)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Twitter Hashtag search"),
  
  # Some text input
  textInput("hashtag", "Enter Hashtag here", ""),
    
    # Show a plot of the network
    mainPanel(
       plotOutput("NetworkPlot")
    )
  )
<<<<<<< HEAD
))

=======
)
>>>>>>> 371beb3b320a168d82baed93849aa6e6f724b092
