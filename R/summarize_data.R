#' Summarize a names dataset
#'
#' Returns a compact summary: number of rows/columns and the available
#' name/frequency columns detected.
#'
#' @param df A data.frame with columns like FirstName, Surname, Estimate, finalEstimate.
#' @return A list summary (printed nicely).
#' @export
summarize_data <- function(df) {
  cols <- names(df)
  present <- intersect(cols, c("FirstName","Surname","Estimate","finalEstimate","cleanName","Adjustment"))
  list(
    n_rows = nrow(df),
    n_cols = ncol(df),
    detected_columns = present
  )
}
