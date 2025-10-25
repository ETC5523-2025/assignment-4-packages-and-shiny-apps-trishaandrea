#' Summarise numeric columns
#'
#' Calculates the mean of all numeric variables in a data frame.
#'
#' @param data A data frame.
#' @return A tibble of column means.
#' @examples
#' summarize_data(mtcars)
#' @export
summarize_data <- function(data) {
  dplyr::summarise_if(data, is.numeric, mean, na.rm = TRUE)
}

