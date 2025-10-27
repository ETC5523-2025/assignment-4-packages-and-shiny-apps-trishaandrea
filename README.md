
# assignment4packages

An R package that includes a cleaned dataset of common names and an interactive
Shiny app to explore name frequencies.  

**Data source:** [FiveThirtyEight “Most Common Name” dataset](https://github.com/fivethirtyeight/data/tree/master/most-common-name)

📖 **Documentation website:** https://ETC5523-2025.github.io/assignment-4-packages-and-shiny-apps-trishaandrea/

## Installation


You can install the development version of the package from GitHub with:

```r
# install.packages("remotes")
remotes::install_github("ETC5523-2025/assignment-4-packages-and-shiny-apps-trishaandrea")

## Launch the app

library(assignment4packages)
run_app()

## Access and Summarize the Data

library(assignment4packages)

# Load the packaged dataset path and read it
csv_path <- system.file("extdata", "adjusted-name-combinations-list.csv",
                        package = "assignment4packages")
dat <- read.csv(csv_path, check.names = FALSE)

# Quick summary (function provided in the package)
summarize_data(dat)

