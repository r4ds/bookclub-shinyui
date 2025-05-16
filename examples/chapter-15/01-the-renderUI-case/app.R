library(shiny)
library(bs4Dash)

new_message <- data.frame(
  message = "New message",
  from = "Paul",
  time = "yesterday",
  color = "success"
)

shinyApp(
  ui = dashboardPage(
    dark = FALSE,
    header = dashboardHeader(
      rightUi = uiOutput("messages", container = tags$li)
    ),
    sidebar = dashboardSidebar(),
    controlbar = dashboardControlbar(),
    footer = dashboardFooter(),
    title = "test",
    body = dashboardBody(actionButton("add", "Add message"))
  ),
  server = function(input, output) {

    messages <- reactiveValues(
      items = data.frame(
        message = rep("A message", 10),
        from = LETTERS[1:10],
        time = rep("yesterday", 10),
        color = rep("success", 10)
      )
    )

    observeEvent(input$add, {
      messages$items <- rbind(messages$items, new_message)
    })

    output$messages <- renderUI({
      lapply(seq_len(nrow(messages$items)), function(i) {
        items_i <- messages$items[i, ]
        bs4Dash::messageItem(
          message = items_i$message,
          from = items_i$from,
          time = items_i$time,
          color = items_i$color
        )
      }) |>
        c(badgeStatus = "danger",
          type = "messages") |>
        do.call(what = "dropdownMenu")
    })
  }
)
