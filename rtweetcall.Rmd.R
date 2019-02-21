setwd("/Users/malinfiedler/Desktop/Uni/RSM/NetworkDataAnalytics/groupproject")
#```{r eval=FALSE}

library(httpuv)
library(rtweet)
library(tidyverse)
library(igraph)
library(hrbrthemes)
library(ggraph)

#creating token
create_token(
  app = "NDAgroup",
  consumer_key = "TOEpjCSVlUj7vMnCPnL9P94tm",
  consumer_secret = "IKkKuhx6MrOcNYNvfN1yri2QwNXb9XE74555nuxVplYxfLxPrs"
) -> twitter_token

Trump <- search_tweets("#Trump", n = 1500)

filter(Trump, retweet_count > 0) %>%
  select(screen_name, mentions_screen_name) %>%
  unnest(mentions_screen_name) %>%
  filter(!is.na(mentions_screen_name)) %>%
  graph_from_data_frame() -> rt_g

V(rt_g)$node_label <- unname(ifelse(degree(rt_g)[V(rt_g)] > 20, names(V(rt_g)),''))
V(rt_g)$node_size <- unname(ifelse(degree(rt_g)[V(rt_g)] > 20, degree(rt_g), 0))

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

