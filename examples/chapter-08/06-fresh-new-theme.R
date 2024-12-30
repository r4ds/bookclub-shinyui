library(shiny)
library(bs4Dash)
library(fresh)

layout_vars <- bs4dash_layout(main_bg = "#006994")

navbar_vars <- list(
  # navbar background
  bs4dash_status(light = "#005475", primary = "#00755c"),
  # put toggler in white
  bs4dash_vars(navbar_light_color = "#fff")
)

inverted_colors <- bs4dash_color(
  gray_900 = "#fff",
  white = "#005475"
)
ocean_theme <- create_theme(
  layout_vars,
  navbar_vars,
  inverted_colors
)


ui <- dashboardPage(
  dashboardHeader(title = "Custom colors"),
  dashboardSidebar(),
  dashboardBody(
    use_theme(ocean_theme),
    # Boxes need to be put in a row (or column)
    fluidRow(
      box(
        solidHeader = TRUE,
        plotOutput("plot1", height = 250),
        status = "olive"
      ),
      box(
        solidHeader = TRUE,
        status = "lightblue",
        title = "Controls",
        sliderInput(
          "slider",
          "Number of observations:",
          1,
          100,
          50
        )
      )
    )
  )
)

server <- function(input, output) {
  set.seed(122)
  histdata <- rnorm(500)

  output$plot1 <- renderPlot({
    data <- histdata[seq_len(input$slider)]
    hist(data)
  })
}

shinyApp(ui, server)
