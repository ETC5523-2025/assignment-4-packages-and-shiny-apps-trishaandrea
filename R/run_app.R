#' Launch the Shiny app
#' 
#' This function runs the Shiny app located in `inst/app`.
#' @export
run_app <- function() {
  app_dir <- system.file("app", package = "assignment4packages")
  if (app_dir == "") {
    stop("Could not find app directory. Try reinstalling the package.", call. = FALSE)
  }
  shiny::runApp(app_dir, display.mode = "normal")
}

