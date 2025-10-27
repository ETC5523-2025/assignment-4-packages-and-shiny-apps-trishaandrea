#' Summarise a names data frame
#' @param df A data.frame
#' @param value_col Name of the numeric column to summarise (default tries "finalEstimate")
#' @param group_col Name of the grouping column (default tries "cleanName")
#' @export
summarize_data <- function(df, value_col = NULL, group_col = NULL) {
  stopifnot(is.data.frame(df))
  
  # Choose safe defaults if nothing/"" is supplied
  if (is.null(value_col) || identical(value_col, "")) {
    value_col <- if ("finalEstimate" %in% names(df)) "finalEstimate" else {
      nums <- names(df)[vapply(df, is.numeric, TRUE)]
      if (!length(nums)) stop("No numeric columns found to summarise.")
      nums[1]
    }
  }
  if (is.null(group_col) || identical(group_col, "")) {
    group_col <- if ("cleanName" %in% names(df)) "cleanName" else {
      chars <- names(df)[vapply(df, function(x) is.character(x) || is.factor(x), TRUE)]
      if (!length(chars)) stop("No character/factor columns found for grouping.")
      chars[1]
    }
  }
  
  if (!value_col %in% names(df)) stop("Column '", value_col, "' not in data.")
  if (!group_col %in% names(df)) stop("Column '", group_col, "' not in data.")
  
  df |>
    dplyr::group_by(.data[[group_col]]) |>
    dplyr::summarise(
      n      = dplyr::n(),
      mean   = mean(.data[[value_col]], na.rm = TRUE),
      median = stats::median(.data[[value_col]], na.rm = TRUE),
      min    = min(.data[[value_col]], na.rm = TRUE),
      max    = max(.data[[value_col]], na.rm = TRUE),
      .groups = "drop"
    ) |>
    dplyr::arrange(dplyr::desc(mean))
}

