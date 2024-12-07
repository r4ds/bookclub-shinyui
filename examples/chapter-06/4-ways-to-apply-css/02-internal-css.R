library(shiny)

ui <- fluidPage(

  # 2. INTERNAL
  tags$head(
    tags$style(
      "p {
        color: purple;
      }"
      )
  ),

  tags$h2("Heading Level 2"),
  tags$p("This is a paragraph"),
)

server <- function(input, output, session) {}

shinyApp(ui, server)
