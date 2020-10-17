library(tidyverse)
library(dplyr)
library(tidyr)
library(stringr)
library(ggplot2)

bg=read.csv('boardgames1.csv')

bg <- bg %>% arrange(desc(totalvotes)) %>% 
  filter(usersrated>100) %>%
  arrange(desc(average)) %>% 
  filter(average>6) %>% 
  top_n(1000)


bg1=bg1 %>% 
  select(name, yearpublished, minplayers, maxplayers, minplaytime, maxplaytime, minage, usersrated, average, avgweight, boardgamehonor,boardgamecategory, description,boardgamefamily)


bg1 <- bg1[-c(4, 350, 527, 872, 748, 148, 762, 627, 984, 874, 886, 599), ]
bg1 = bg1[-c(1:37), ]

category_split = function(categories){
  require(stringr)
  return(lapply(str_split(str_remove_all(categories,'[\\[\\]\']'),','),str_trim))
}

bg1$boardgamecategory = sapply(bg1$boardgamecategory,category_split)

categories = bg1 %>% 
  unnest(boardgamecategory)


write.csv(categories,file="CategoriesBG.csv")
categories=read.csv("CategoriesBG.csv", stringsAsFactors = F)

categories$boardgamecategory 

#Top Ten BoardGame Categories by average
categories %>% 
  group_by(boardgamecategory) %>%
  summarise(top_ave=mean(average)) %>% 
  arrange(desc(top_ave)) %>% 
  slice_max(order_by = top_ave, n=10) %>% 
  ggplot(aes(x=boardgamecategory,y=top_ave,fill=boardgamecategory))+geom_col(position="dodge")+
  theme_bw() +
  theme(legend.key=element_blank(), legend.position="bottom")+
  coord_flip()



#Categories by age
categories %>% 
  select(name, boardgamecategory, minage) %>% 
  group_by(minage) %>% 
  distinct(boardgamecategory) 
 
                          
                          description="minplayer - minumum number of players per the publishers
                            maxplayers - maximum number of players per the publishers
                            minplaytime - minimum playtime required per the publishers
                            maxplaytime - maximum playtime per the publishers
                            minage - minimum age requiremnet per the publishers
                            totalvotes - total number of community vote
                            playerage - minimum age requirement per the community
                            userrated - number of users that have rated the game
                            average - user average rating from 1-10
                            stddev - average standard deviation of a rating
                            boardgamefamily_cnt - game family count
                            boardgamehonor - list of awards
                            boardgamecategory - list of categories
                            boardgameexpansion - a list of expansions
                            boardgamefamily - a list of boardgames family
                            description - full text description of game)"

                          write.csv(description,file="Glossary.csv")
                          Glossary=read.csv("Glossary.csv", stringsAsFactors = F)
                          
glossary_df = read.csv(file = 'Glossary_metrics.csv')

#Graphics of Wargame category
Wargame=categories %>% 
  filter(boardgamecategory=="Wargame") %>% 
  top_n(10) %>% 
  ggplot(aes(x=name,y=average,fill=name))+geom_col(position="dodge")+
  theme_bw() +
  theme(legend.key=element_blank(), legend.position="bottom")+
  coord_flip()
Wargame


categories %>% 
  group_by(boardgamecategory) %>%
  summarise(top_ave=mean(average)) %>% 
  arrange(desc(top_ave)) %>% 
  slice_max(order_by = top_ave, n=10)

top_ten = categories %>% 
  group_by(boardgamecategory) %>% 
  summarise(count=n(), avg_rating = mean(average)) %>% 
  mutate(score = log(count)*avg_rating) %>% 
  arrange(desc(score)) %>% 
  slice_max(order_by = score, n=10)

categories %>% 
  filter(boardgamecategory == input$top_ten) %>% 
  select(average, name) %>%
  slice_max(order_by = average, n=10) %>%
  arrange(desc(average)) %>% 
  ggplot(aes(x=average, y=reorder(name, average))) + geom_bar(stat='identity') +
  ylab('Game Title') + xlab('Average Rating') + ggtitle(paste('Top 10 Games in', input$top_ten))

