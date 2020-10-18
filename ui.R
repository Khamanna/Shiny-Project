fluidPage(
  tags$head(tags$style(
    HTML('
       # #sidebar {
            #background-color: #757272;
            color: white
        }
        #header {
          #padding: 20px;
          text-align: center;
          background: #4d5e55;
          color: white;
          font-size: 20px;
        }
        body, label, input, button, select {
          font: "Cambria";
          font-weight: bold;
        }
         ')
  )),
  
  br(),
  id="sidebar",
  width=3,
  selectizeInput(inputId = "top_ten",
                 label = "BoardGame Category",
                 choices = top_ten$boardgamecategory,
                 selected = top_ten$boardgamecategory[6]
  ),
  
  mainPanel(
    width=13,
    tabsetPanel(type = "tabs",
                tabPanel("Top Ten Games per Top Ten Category",br(),br(),
                         plotlyOutput("top_ten_games")),
                tabPanel("Top Ten Categories Ranked", br(),br(),
                         plotlyOutput("summary")),
                tabPanel("Play Hours",
                         plotOutput("maxnum_of_playtime"),
                         plotOutput("minnum_of_playtime")),
                tabPanel("Glossary",br(), h3("Glossary"),br(),
                                      h5('minplayer - minumum number of players per the publishers'),
                                      h5("maxplayers - maximum number of players per the publishers"),
                                      h5("minplaytime - minimum playtime required per the publishers"),
                                      h5("maxplaytime - maximum playtime per the publishers"),
                                      h5("minage - minimum age requiremnet per the publishers"),
                                      h5("totalvotes - total number of community vote"),
                                      h5("playerage - minimum age requirement per the community"),
                                       h5("totalvotes - total number of community vote"),
                                      h5("userrated - number of users that have rated the game"),
                                       h5("average - user average rating from 1-10"),
                                       h5("boardgamecategory - list of categories"),
                                       h5("boardgameversion - list of versions"),
                                       h5("boardgameexpansion - a list of expansions"),
                                       h5("boardgamefamily - a list of boardgames family"),
                                       h5("description - full text description of game"),
                                 ) #tableOutput("Glossary"))
    )
  )
)

