#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#
library(shiny)

shinyUI(fluidPage( 
  titlePanel("Sentiment Analysis"), #Title
  textOutput("currentTime"),   #Here, I show a real time clock
  h4("Tweets:"),   #Sidebar title
  sidebarLayout(
    sidebarPanel(
      dataTableOutput('tweets_table') #Here I show the users and the sentiment
    ),
      
      mainPanel(
        plotOutput("distPlot"), #Here I will show the bars graph
        sidebarPanel(
          plotOutput("positive_wordcloud") #Cloud for positive words
        ),
        sidebarPanel(
          plotOutput("negative_wordcloud") #Cloud for negative words
        ),
        sidebarPanel(
          plotOutput("neutral_wordcloud") #Cloud for neutral words
        )))))
