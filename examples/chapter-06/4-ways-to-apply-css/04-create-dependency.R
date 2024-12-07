library(shiny)

#  4. DEPENDENCY
color_dependency <- function() {
  htmltools::htmlDependency(
    name = "p_color",
    version = "1.0.0",
    src = "www/",
    stylesheet = "style.css"
  )
}

ui <- fluidPage(

  tags$h2("Heading Level 2"),
  tags$p("This is a paragraph")

)

ui_dep <- tagList(ui, color_dependency())

server <- function(input, output, session) {}

shinyApp(ui_dep, server)
