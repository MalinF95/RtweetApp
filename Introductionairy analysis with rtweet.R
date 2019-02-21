#Analyzing Network data with the rtweet package
#In addition to the rtweet package we also use the tidyverse package
#as it provides efficient analysis of network data
#loads packages
library(rtweet)
library(tidyverse)
# we can get recent tweets by hashtag
# returns data from the last 6-9 days
rstats <- search_tweets("#rstats", n = 50)
# and also by account handle
ben <- search_tweets("BenInquiring", n = 50)
#Also can get specific information about an account
ben_profile <- search_users("BenInquiring")
ben_profile$name
ben_profile$description
ben_profile$location
#Since data collection is limited and costs data power for the server
#we can check the status on all limits with the rate_limit() function
rate_limit()
#sample followers of a user
my_followers <- get_followers("BenInquiring")
glimpse(my_followers)
