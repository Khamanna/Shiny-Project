function(input, output) { 
  

  output$top_ten_games = renderPlotly({
    categories %>% 
      filter(boardgamecategory == input$top_ten) %>% 
      select(average, name) %>%
      slice_max(order_by = average, n=10) %>%
      arrange(desc(average)) %>% 
      ggplot(aes(x=average, y=reorder(name, average), fill=name)) + geom_bar(stat='identity') +
      ylab('Title of BoardGame') + xlab('Average Rating') + ggtitle(paste('Top 10 Games in', input$top_ten))
  })
  
  output$summary = renderPlotly({
    categories %>%
    filter(boardgamecategory %in% top_ten$boardgamecategory) %>% 
    group_by(boardgamecategory) %>%
    summarise(count=n(), avg_rating = mean(average)) %>%
    mutate(score = log(count)*avg_rating) %>%
    arrange(desc(score)) %>%
    slice_max(order_by = score, n=10)%>%
    ggplot(aes(x=avg_rating, y=reorder(boardgamecategory, avg_rating), fill=boardgamecategory)) + geom_bar(stat='identity') +
    ylab('BoardGame Category') + xlab('Average Rating') + ggtitle(paste('Top 10 Categories Ranked'))
    
  })
  
  output$maxnum_of_playtime = renderPlot({
    categories %>%
      filter(boardgamecategory %in% top_ten$boardgamecategory) %>% 
      select(boardgamecategory, maxplaytime) %>%
      ggplot(aes(x=maxplaytime,y=boardgamecategory)) +
      geom_boxplot(outlier.shape = NA, fill="red", alpha=0.1) +
      ylab('BoardGame Category') + xlab('Play Time in minutes') +
      ggtitle(paste('Maximum Play Time per Category'))+
      scale_x_log10() 
    
  })
  
  output$minnum_of_playtime = renderPlot({
    categories %>%
      filter(boardgamecategory %in% top_ten$boardgamecategory) %>% 
      select(boardgamecategory, minplaytime) %>%
      ggplot(aes(x=(minplaytime), y=boardgamecategory)) +
      geom_boxplot(outlier.shape=NA, fill="red", alpha=0.1) +
      ylab('BoardGame Category') + xlab('Play Time in minutes') +
      ggtitle(paste('Minimum Play Time per Category'))+
      scale_x_log10()
    
  })
  # working on a description column
  # output$description = renderTable({
  #  
  #   a=categories %>% 
  #     filter(boardgamecategory == input$top_ten) %>% 
  #     select(average, name) %>%
  #     slice_max(order_by = average, n=10) %>%
  #     arrange(desc(average))
  #   paste0(a,description$description)
  # 
  # })
  
  output$Glossary = renderTable(
  Glossary
  )
  
}