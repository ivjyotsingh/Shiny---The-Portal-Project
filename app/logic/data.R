box::use(
  here[here]
)

box::use(
  utils[read.csv]
)

#' @export
fetch_plots <- function(){
  read.csv(here::here("data","plots.csv"))
}

#' @export
fetch_species <- function(){
  species <- read.csv(here::here("data","species.csv"))
  species$species[is.na(species$species)] <- "NA"
  species
}

#' @export
fetch_surveys <- function(){
  surveys <- read.csv(here::here("data","surveys.csv"))
  surveys$species[is.na(surveys$species)] <- "NA"
  surveys
}