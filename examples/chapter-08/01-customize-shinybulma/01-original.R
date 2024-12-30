# devtools::install_github("RinteRface/shinybulma")

library(shiny)
library(shinybulma)

shinyApp(
  ui = bulmaPage(
    bulmaSection(
      bulmaTileAncestor(
        bulmaTileParent(
          vertical = TRUE,
          bulmaTileChild(
            bulmaTitle("Tile 1"),
            p("Put some data here"),
            color = "link"
          ),
          bulmaTileChild(
            bulmaTitle("Tile 2"),
            "Hi Bulma!",
            color = "danger"
          )
        ),
        bulmaTileParent(
          vertical = TRUE,
          bulmaTileChild(
            bulmaTitle("Tile 3"),
            p("Put some data here"),
            color = "warning"
          ),
          bulmaTileChild(
            bulmaTitle("Tile 3"),
            ("Put some data here"),
            color = "info"
          )
        )
      )
    )
  ),
  server = function(input, output) {}
)
