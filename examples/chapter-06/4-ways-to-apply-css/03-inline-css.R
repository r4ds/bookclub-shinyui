library(shiny)

ui <- fluidPage(

  tags$h2("Heading Level 2"),
  tags$p("This is a paragraph"),

  # 3. INLINE
  tags$p("Second paragraph", style = "color:darkgreen;")

)

server <- function(input, output, session) {}

shinyApp(ui, server)
