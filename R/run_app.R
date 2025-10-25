#' Launch the Shiny app
#'
#' Opens the package's Shiny app located under \code{inst/app}.
#' @param launch.browser Open in browser? Default TRUE.
#' @export
run_app <- function(launch.browser = TRUE) {
  app_dir <- system.file("app", package = "assignment4packages")
  if (app_dir == "") stop("Could not find app directory. Reinstall the package.", call. = FALSE)
  shiny::runApp(app_dir, launch.browser = launch.browser)
}
