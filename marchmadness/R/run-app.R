#' @title The Shiny App for Interactive table
#' @description
#' This is a basic shiny app to run an interactive table to explore the data.
#' @returns Nothing
#' @examples
#' \dontrun{
#' run_app()
#' }
#' @export
run_app <- function() {
  app_dir <- system.file("eda-app", package = "cwdata")
  shiny::runApp(app_dir, display.mode = "normal")
}
