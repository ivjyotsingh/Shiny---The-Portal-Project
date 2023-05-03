box::use(
  app/logic/data
)

box::use(
  app/view/Controls/SpeciesSelector
)

box::use(
  shiny[NS,tabPanel,fluidRow,column,moduleServer],
  bslib[card,card_header,card_body_fill],
  echarts4r[echarts4rOutput,renderEcharts4r,e_charts,e_bar,e_error_bar,
            e_legend,e_title,e_tooltip,e_line,group_by],
  dplyr[filter,group_by,summarise,n]
)


#' @export
ui <- function(id) {
  ns <- NS(id)
  
  tabPanel("Species Profile",
           fluidRow(
             column(3,
                    card(
                      height = 300,
                      card_header("Controls"),
                      card_body_fill(SpeciesSelector$selection(ns("speciesArg")))
                    )
               ),
             column(3,
                    card(
                      height = 300,
                      card_header("Hind Foot Length"),
                      card_body_fill(echarts4rOutput(ns("hflplot")))
                    )
               ),
             column(3,
                    card(
                      height = 300,
                      card_header("Weight"),
                      card_body_fill(echarts4rOutput(ns("wplot")))
                    ))
        ),
        fluidRow(
          column(12,
                 card(
                   height = 300,
                   card_header("Treatments"),
                   card_body_fill(echarts4rOutput(ns("treatplot")))
                 ))
        )
  ) 
  
}

#' @export
server <- function(id) {
  moduleServer(id, function(input, output, session) {
    
   output$hflplot <- renderEcharts4r({
     
       data$fetch_species() |>
       filter(species == input$speciesArg) |>
       e_charts(species) |>
       e_bar(meanhfl) |>
       e_error_bar(minhfl,maxhfl) |>
       e_legend(show = FALSE) |>
       e_tooltip(trigger = "item")
     
   })   
    
   output$wplot <- renderEcharts4r({
     
     data$fetch_species() |>
       filter(species == input$speciesArg) |>
       e_charts(species) |>
       e_bar(meanwgt) |>
       e_error_bar(minwgt,maxwgt) |>
       e_legend(show = FALSE) |>
       e_tooltip(trigger = "item")
     
   }) 
   
    
   output$treatplot <- renderEcharts4r({
     
      data$fetch_surveys() |>
       filter(species == input$speciesArg) |>
       group_by(censusdate,treatment) |>
       summarise(Count = n(),.groups = "drop") |>
       echarts4r::group_by(treatment) |>
       e_charts(censusdate) |>
       e_line(Count) |>
       e_tooltip(trigger = "axis")
     
   })
    
  
   
    
    })
}