
library(shiny)

my_card <- function(...) {
  withTags(
    div(
      class = "card",
      div(
        class = "card-body",
        h5(class = "card-title", "Card title"),
        p(class = "card-text", "Card content"),
        button(
          type = "button",
          class = "btn btn-primary",
          "Button"
        )
      )
    )
  )
}

shinyApp(
  ui = fluidPage(
    fluidRow(
      column(
        width = 6,
        align = "center",
        br(),
        my_card("Card Content")
      )
    )
  ),
  server = function(input, output) {}
)
