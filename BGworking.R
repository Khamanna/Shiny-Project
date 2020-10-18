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


bg1=bg %>% 
  select(name, minplaytime, maxplaytime, minage, usersrated, average, boardgamehonor,boardgamecategory, description,boardgamefamily)


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


#Top Ten BoardGame Categories by average, dependent on populatiry of the BGcategory
top_ten = categories %>% 
  group_by(boardgamecategory) %>% 
  summarise(count=n(), avg_rating = mean(average)) %>% 
  mutate(score = log(count)*avg_rating) %>% 
  arrange(desc(score)) %>% 
  slice_max(order_by = score, n=10)


description = categories$description
description=categories %>% 
  select(name,description) %>% 
  distinct()
write.csv(description,file="description.csv")
description=read.csv("description.csv")


# categories %>% 
#   group_by(boardgamecategory) %>%
#   summarise(top_ave=mean(average)) %>% 
#   arrange(desc(top_ave)) %>% 
#   slice_max(order_by = top_ave, n=10) %>% 
#   ggplot(aes(x=boardgamecategory,y=top_ave,fill=boardgamecategory))+geom_col(position="dodge")+
#   theme_bw() +
#   theme(legend.key=element_blank(), legend.position="bottom")+
#   coord_flip()


#Categories by age
# categories %>% 
#   select(name, boardgamecategory, minage) %>% 
#   group_by(minage) %>% 
#   distinct(boardgamecategory) 
