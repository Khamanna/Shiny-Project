library(shiny)
library(dplyr)
library(ggplot2)
library(extrafont)
library(plotly)
library(cowplot)
#library(gapminder)


categories = read.csv('CategoriesBG.csv')
#Glossary=read.csv("Glossary.csv")

top_ten = categories %>% 
  group_by(boardgamecategory) %>% 
  summarise(count=n(), avg_rating = mean(average)) %>% 
  mutate(score = log(count)*avg_rating) %>% 
  arrange(desc(score)) %>% 
  slice_max(order_by = score, n=10)

