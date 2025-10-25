# data-raw/01_prepare_names_data.R
# Purpose: Copy or prepare dataset for packaging

# Ensure destination exists
dir.create("inst/extdata", showWarnings = FALSE, recursive = TRUE)

# Copy data to extdata so that it can be used by the package and app
file.copy(
  from = "data-raw/adjusted-name-combinations-list.csv",
  to   = "inst/extdata/adjusted-name-combinations-list.csv",
  overwrite = TRUE
)

message("Data prepared and copied to inst/extdata/adjusted-name-combinations-list.csv")
