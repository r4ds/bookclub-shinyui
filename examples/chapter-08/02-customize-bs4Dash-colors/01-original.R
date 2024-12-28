library(shiny)
library(bs4Dash)

ui <- dashboardPage(
  dashboardHeader(title = "Custom colors"),
  dashboardSidebar(),
  dashboardBody(
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
