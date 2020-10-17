function(input, output) { 
  

  output$top_ten_games = renderPlot({
    categories %>% 
      filter(boardgamecategory == input$top_ten) %>% 
      select(average, name) %>%
      slice_max(order_by = average, n=10) %>%
      arrange(desc(average)) %>% 
      ggplot(aes(x=average, y=reorder(name, average), fill=name)) + geom_bar(stat='identity') +
      ylab('Game Title') + xlab('Average Rating') + ggtitle(paste('Top 10 Games in', input$top_ten))
  })
  
  
  output$summary = renderPlot({
    categories %>%
    filter(boardgamecategory %in% top_ten$boardgamecategory) %>% 
    group_by(boardgamecategory) %>%
    summarise(count=n(), avg_rating = mean(average)) %>%
    mutate(score = log(count)*avg_rating) %>%
    arrange(desc(score)) %>%
    slice_max(order_by = score, n=10)%>%
    ggplot(aes(x=avg_rating, y=reorder(boardgamecategory, avg_rating), fill=boardgamecategory)) + geom_bar(stat='identity') +
    ylab('Category Title') + xlab('Average Rating') + ggtitle(paste('Top 10 Categories in', input$top_ten))
  })
  
  output$num_of_players = renderPlot({
    categories %>%
      filter(boardgamecategory %in% top_ten$boardgamecategory) %>% 
      group_by(boardgamecategory) %>%
      summarise(avg_ppl_num = mean(maxplayers)) %>%
      arrange(desc(avg_ppl_num)) %>%
      slice_max(order_by = avg_ppl_num, n=10)%>%
      ggplot(aes(x=avg_ppl_num, y=reorder(boardgamecategory, avg_ppl_num), fill=boardgamecategory)) + geom_bar(stat='identity') +
      ylab('Category Title') + xlab('Average Number of People') + ggtitle(paste('Number of Players vs BoarGame Categories', input$top_ten))
  })
  
  output$Glossary = renderTable(
  Glossary
  )
  
}