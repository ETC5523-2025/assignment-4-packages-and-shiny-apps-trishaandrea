library(ggplot2)
library(dplyr)
library(bslib)

if (!requireNamespace("remotes", quietly = TRUE)) install.packages("remotes")
if (!requireNamespace("assignment4packages", quietly = TRUE)) {
  remotes::install_github("ETC5523-2025/assignment-4-packages-and-shiny-apps-trishaandrea")
}
library(assignment4packages)
library(shiny)



names_data <- get_names_data()

names_data <- names_data %>% select(where(function(x) !is.list(x)))
if ("X" %in% names(names_data)) names_data <- dplyr::select(names_data, -X)

ui <- page_fluid(
  theme = bs_theme(bootswatch = "flatly"),
  div(
    style = "text-align:center; background-color:#2C7FB8; color:white; padding:15px; border-radius:6px; margin-bottom:20px;",
    h1("🌊 Most Common Name Explorer", style = "font-weight:600;"),
    p("Interactive Data Analysis & Shiny Exploration", style = "font-size:18px; margin-bottom:0;")
  ),
  h2("How to interpret the outputs"),
  p("The bar chart shows the top N names ranked by the selected count column. ",
    "Choose ", code("Estimate"), " or ", code("finalEstimate"),
    " depending on whether you want raw or adjusted totals. ",
    "Use the filter to focus on names starting with specific letters."),
  
  layout_sidebar(
    sidebar = sidebar(
      title = "Controls",
      # Field meanings (short, meets rubric)
      p(tags$b("Type of name:"), " Choose whether you want first names or surnames."),
      radioButtons(
        "name_type", NULL,
        choices = c("FirstName", "Surname"),
        inline = TRUE, selected = "FirstName"
      ),
      
      p(tags$b("Count / frequency column:"), " Pick the column used for ranking."),
      radioButtons(
        "count_col", NULL,
        choices = c("Estimate", "finalEstimate"),
        inline = FALSE, selected = "Estimate"
      ),
      
      p(tags$b("Filter names that start with (optional):")),
      textInput("starts_with", NULL, placeholder = "e.g. Ma, Jo, Ri"),
      
      p(tags$b("Show top N:")),
      sliderInput("top_n", NULL, min = 5, max = 50, value = 11),
      
      hr(),
      helpText("Tip: switch to ", strong("Surname"), " + ",
               strong("finalEstimate"), " to explore last names with adjusted counts.")
    ),
    
    # Main content
    card(
      card_header("Top names"),
      plotOutput("topPlot", height = 360)
    ),
    card(
      card_header("Table (top N)"),
      tableOutput("topTable")
    )
  )
)

server <- function(input, output, session) {
  
  top_df <- reactive({
    req(input$name_type, input$count_col, input$top_n)
    req(input$name_type %in% names(names_data))
    req(input$count_col %in% names(names_data))
    
    df <- names_data %>%
      rename(name = all_of(input$name_type),
             count = all_of(input$count_col)) %>%
      filter(!is.na(name), !is.na(count))
    
    if (!is.null(input$starts_with) && nzchar(trimws(input$starts_with))) {
      prefix <- tolower(trimws(input$starts_with))
      df <- df %>% filter(startsWith(tolower(name), prefix))
    }
    
    df %>%
      arrange(desc(count)) %>%
      slice_head(n = input$top_n)
  })
  
  output$topPlot <- renderPlot({
    df <- top_df()
    validate(
      need(nrow(df) > 0, "No rows match your filters.")
    )
    ggplot(df, aes(x = reorder(name, count), y = count)) +
      geom_col(fill = "#2C7FB8") +         # blue bars
      coord_flip() +
      labs(x = "name", y = input$count_col) +
      theme_minimal(base_size = 14)
  })
  
  output$topTable <- renderTable({
    top_df() %>%
      transmute(name, count = round(count, 2))
  })
}

shinyApp(ui, server)

