box::use(
  app/logic/data
)

box::use(
  dplyr[select,pull],
  shiny[selectInput]
)

#' @export
selection <- function(speciesArg){
  
    data$fetch_species() |>
    select(species) |>
    unique() |>
    pull() -> species
  
  selectInput(inputId = speciesArg,
              "Select a Species",
              choices = species,
              selected = 1)
  
}