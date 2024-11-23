
library(shiny)
library(htmltools)

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

# handle dependency
mdb_cdn <- "https://cdnjs.cloudflare.com/ajax/libs/"
mdb_card_dep <- function() {
  htmlDependency(
    name = "mdb-card",
    version = "1.0",
    src = c(href = mdb_cdn),
    stylesheet = "mdb-ui-kit/3.6.0/mdb.min.css"
  )
}

# create the card
my_card_with_deps <- function(...) {
  cardTag <- my_card(...)

  tagList(cardTag, mdb_card_dep())

}


shinyApp(
  ui = fluidPage(
    tags$style("body {background: gainsboro;}"),

    fluidRow(
      column(
        width = 6,
        br(),
        my_card_with_deps("Card Content")
      )
    )
  ),
  server = function(input, output) {}
)
