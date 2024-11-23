
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

mdb_cdn <- "https://cdnjs.cloudflare.com/ajax/libs/"
mdb_css <- paste0(mdb_cdn, "mdb-ui-kit/3.6.0/mdb.min.css")


shinyApp(
  ui = fluidPage(
    tags$style("body {background: gainsboro;}"),

    ## load the css code
    tags$head(
      ## Adding a link
      tags$link(
        rel = "stylesheet",
        type = "text/css",
        href = mdb_css
      ),
      ## Pasting all css code
      #includeCSS(path = mdb_css)
    ),
    fluidRow(
      column(
        width = 6,
        br(),
        my_card("Card Content")
      )
    )
  ),
  server = function(input, output) {}
)
