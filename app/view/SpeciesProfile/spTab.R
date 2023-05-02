box::use(
  app/logic/data
)

box::use(
  app/view/Controls/SpeciesSelector
)

box::use(
  shiny[NS,tabPanel,fluidRow,column,moduleServer],
  bslib[card,card_header,card_body_fill]
)


#' @export
ui <- function(id) {
  ns <- NS(id)
  
  tabPanel("Species Profile",
           fluidRow(
             column(3,
                    card(
                      height = 350,
                      card_header("Controls"),
                      card_body_fill(SpeciesSelector$selection(ns("speciesArg")))
                    )
               )
        )
  ) 
  
}

#' @export
server <- function(id) {
  moduleServer(id, function(input, output, session) {
    
      
    })
}