library(shiny)

ui <- fluidPage(
  # 1. EXTERNAL
  tags$link(rel = "stylesheet", type="text/css", href="style.css"),

  tags$h2("Heading Level 2"),
  tags$p("This is a paragraph"),
)

server <- function(input, output, session) {}

shinyApp(ui, server)
