#' Get names dataset
#' @return data.frame
#' @export
get_names_data <- function() {
  csv_path <- system.file(
    "extdata", "adjusted-name-combinations-list.csv",
    package = "assignment4packages"
  )
  
  df <- read.csv(csv_path, check.names = FALSE)
  
  if (any(!nzchar(names(df)) | is.na(names(df)))) {
    df <- df[, nzchar(names(df)) & !is.na(names(df)), drop = FALSE]
  }
  
  if ("X" %in% names(df)) df <- df[, setdiff(names(df), "X"), drop = FALSE]
  
  names(df) <- make.names(names(df), unique = TRUE)
  
  df
}
