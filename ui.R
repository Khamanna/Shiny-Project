fluidPage(
  # tags$head(tags$style(
  #   HTML('
  #       #sidebar {
  #           background-color: #191414;
  #           color: white
  #       }
  #       #header {
  #         padding: 20px;
  #         text-align: center;
  #         background: #1DB954;
  #         color: white;
  #         font-size: 20px;
  #       }
  #       body, label, input, button, select { 
  #         font: "Cambria";
  #         font-weight: bold;
  #       }
  #        ')
  # )),
  
  br(),
  id="sidebar",
  br(),
  width=6,
  selectizeInput(inputId = "top_ten",
                 label = "BoardGame Category",
                 choices = top_ten$boardgamecategory,
                 selected = top_ten$boardgamecategory[6]
  ),
  
  mainPanel(
    width=13,
    tabsetPanel(type = "tabs",
                tabPanel("Top Ten Games per Top Ten Category",br(),br(),
                         plotOutput("top_ten_games")),
                tabPanel("Top Ten Categories Ranked", br(),br(),
                         plotOutput("summary")),
                tabPanel("Play Hours", br(),br(),
                         plotOutput("num_of_players")),
                tabPanel("Glossary",br(), h5("Glossary"),br(),
                                      ('minplayer - minumum number of players per the publishers'),br(),
                                      ("maxplayers - maximum number of players per the publishers"),br(),
                                      ("minplaytime - minimum playtime required per the publishers"),br(),
                                      ("maxplaytime - maximum playtime per the publishers"),br(),
                                      ("minage - minimum age requiremnet per the publishers"),br(),
                                      ("totalvotes - total number of community vote"),br(),
                                      ("playerage - minimum age requirement per the community"),br(),
                                       ("totalvotes - total number of community vote"),br(),
                                       ("playerage - minimum age requirement per the community"),br(),
                                      ("userrated - number of users that have rated the game"),br(),
                                       ("average - user average rating from 1-10"),br(),
                                       ("boardgamecategory - list of categories"),br(),
                                       ("boardgameversion - list of versions"),br(),
                                       ("boardgameexpansion - a list of expansions"),br(),
                                       ("boardgamefamily - a list of boardgames family"),br(),
                                       ("description - full text description of game"),br()
                                 ) #tableOutput("Glossary"))
    )
  )
)

