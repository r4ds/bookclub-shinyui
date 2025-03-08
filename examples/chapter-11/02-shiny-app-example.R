library(shiny)
shinyApp(
  ui = fluidPage(
    selectInput(
      "variable",
      "Variable:",
      c("Cylinders" = "cyl",
        "Transmission" = "am",
        "Gears" = "gear")
    ),
    tableOutput("data")
  ),
  server = function(input, output) {
    output$data <- renderTable({
      mtcars[, c("mpg", input$variable), drop = FALSE]
    }, rownames = TRUE)
  }
)
