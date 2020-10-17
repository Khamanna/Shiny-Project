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
  #       body, label, input, checkboxGroupInput, button, select { 
  #         font: "Cambria";
  #         font-weight: bold;
  #       }
  #        ')
  # )),
  
  id="sidebar",
  width=3,
  selectizeInput(inputId = "top_ten",
                 label = "BoardGame Category",
                 choices = top_ten$boardgamecategory,
                 selected = top_ten$boardgamecategory[8]
  ),
  
  mainPanel(
    width=9,
    tabsetPanel(type = "tabs",
                tabPanel("Explore", 
                         plotOutput("top_ten_games")),
                tabPanel("How Categories Fair Against Each Other", 
                         plotOutput("summary")),
                tabPanel("glossary", h5("Glossary"),br(),
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

