#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(httpuv)
library(rtweet)
library(tidyverse)
library(igraph)
library(hrbrthemes)
library(ggraph)

create_token(
  insert token info here
) -> twitter_token

# Define server logic required to draw a network
shinyServer(function(input, output) {
  
  hashtag <- search_tweets(req(input$hashtag), n = 1500)
  
  filter(hashtag, retweet_count > 0) %>%
    select(screen_name, mentions_screen_name) %>%
    unnest(mentions_screen_name) %>%
    filter(!is.na(mentions_screen_name)) %>%
    graph_from_data_frame() -> rt_g
    V(rt_g)$node_label <- unname(ifelse(degree(rt_g)[V(rt_g)] > 20, names(V(rt_g)),''))
    V(rt_g)$node_size <- unname(ifelse(degree(rt_g)[V(rt_g)] > 20, degree(rt_g), 0))
  
  output$NetworkPlot <- renderPlot({
    
    ggraph(rt_g, layout = 'linear', circular = TRUE) + 
      geom_edge_arc(edge_width=0.125, aes(alpha=..index..)) +
      geom_node_label(aes(label=node_label, size=node_size),
                      label.size=0, fill="#ffffff66", segment.colour="springgreen",
                      color="slateblue", repel=TRUE, family=font_rc, fontface="bold") +
      coord_fixed() +
      scale_size_area(trans="sqrt") +
      labs(title="Retweet Relationships", subtitle="Most retweeted screen names labeled. Darkers edges == more retweets. Node size == larger degree") +
      theme_graph(base_family=font_rc) +
      theme(legend.position="none")
    
  })
  
})
