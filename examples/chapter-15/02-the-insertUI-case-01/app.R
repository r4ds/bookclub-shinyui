library(shiny)
library(bs4Dash)

dashboardUserImage <- "https://adminlte.io/themes/v3/dist/img/user2-160x160.jpg"

# dropdownDeps <- function(){
#   htmltools::htmlDependency(name = "bs4-dropdown",
#                             version = "1.0.0",
#                             src = c(file = "."),
#                             script = "add-message-item.js")
# }

render_vd_insert_tables <- function(){

  list(
    htmltools::htmlDependency(name = "table-style",
                              version = "1.0.0",
                              src = c(file = "."),
                              stylesheet = "table-style.css"),
    HTML('
  <table>
  <thead>
    <tr>
      <th>Feature</th>
      <th><code>renderUI</code></th>
      <th><code>insertUI</code></th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td><strong>Mechanism</strong></td>
      <td>Re-renders the <em>entire</em> UI component and replaces it.</td>
      <td>Inserts <em>new</em> UI elements <u>without</u> modifying existing ones.</td>
    </tr>
    <tr>
      <td><strong>Performance</strong></td>
      <td>Slower (reprocesses all HTML/dependencies every time).</td>
      <td>Faster (only processes new content).</td>
    </tr>
    <tr>
      <td><strong>DOM Updates</strong></td>
      <td>Forces full reflow (replaces container content).</td>
      <td>Uses <code>insertAdjacentHTML</code> (minimal reflow).</td>
    </tr>
    <tr>
      <td><strong>Dependencies</strong></td>
      <td>Re-resolves dependencies (CSS/JS) on every render.</td>
      <td>Processes dependencies once for new content.</td>
    </tr>
    <tr>
      <td><strong>Use Case</strong></td>
      <td>When the <em>entire</em> UI component must be rebuilt.</td>
      <td>For <em>incremental</em> updates (adding/removing elements).</td>
    </tr>
    <tr>
      <td><strong>State Preservation</strong></td>
      <td>May reset inputs/outputs (re-initializes everything).</td>
      <td>Preserves existing states (only binds new elements).</td>
    </tr>
    <tr>
      <td><strong>Example</strong></td>
      <td><pre>output$dynamicUI <- renderUI({
  div("All content regenerates")
})</pre></td>
      <td><pre>insertUI(
  selector = "#parent",
           where = "beforeEnd",
           ui = div("New item added")
      )</pre></td>
        </tr>
        </tbody>
        </table>
           ')
  )
}

validate_status <- function(status) {

  valid_statuses <- c(
    "primary",
    "secondary",
    "success",
    "info",
    "warning",
    "danger",
    "light",
    "dark"
  )

  if (is.null(status)) {
    return(TRUE)
  } else {
    if (status %in% valid_statuses) {
      return(TRUE)
    }
  }

  stop("Invalid status: ", status, ". Valid statuses are: ",
       paste(valid_statuses, collapse = ", "), ".")
}

dropdownMenu <- function(..., type = c("messages", "notifications", "tasks"),
                         badgeStatus = "primary", icon = NULL, headerText = NULL,
                         .list = NULL, href = NULL) {
  type <- match.arg(type)
  if (!is.null(badgeStatus)) validate_status(badgeStatus)
  items <- c(list(...), .list)

  # Make sure the items are a tags
  # lapply(items, tagAssert, type = "a", class = "dropdown-item")

  if (is.null(icon)) {
    icon <- switch(
      type,
      messages = shiny::icon("comments"),
      notifications = shiny::icon("bell"),
      tasks = shiny::icon("tasks")
    )
  }

  numItems <- length(items)

  if (is.null(badgeStatus)) {
    badge <- NULL
  } else {
    badge <- shiny::span(class = paste0("badge badge-", badgeStatus, " navbar-badge"), numItems)
  }

  if (is.null(headerText)) {
    headerText <- paste("You have", numItems, type)
  }

  shiny::tags$li(
    #dropdownDeps(),
    class = "nav-item dropdown",
    shiny::tags$a(
      class = "nav-link",
      `data-toggle` = "dropdown",
      href = "#",
      `aria-expanded` = "false",
      icon,
      badge
    ),
    shiny::tags$div(
      class = sprintf("dropdown-menu dropdown-menu-lg"),
      shiny::tags$span(
        class = "dropdown-item dropdown-header",
        headerText
      ),
      shiny::tags$div(class = "dropdown-divider"),
      items,
      if (!is.null(href)) {
        shiny::tags$a(
          class = "dropdown-item dropdown-footer",
          href = href,
          target = "_blank",
          "More"
        )
      }
    )
  )
}

dropdownMenuUI <- function(){

  bs4Dash::dashboardPage(

    dark = FALSE,

    header = bs4Dash::dashboardHeader(
      rightUi = dropdownMenu(
        badgeStatus = "danger",
        type = "messages"
      )
    ),

    sidebar = bs4Dash::dashboardSidebar(),

    controlbar = bs4Dash::dashboardControlbar(),

    footer = bs4Dash::dashboardFooter(),

    title = "test",

    body = bs4Dash::dashboardBody(
      actionButton("add", "Add dropdown item"),
      br(),
      br(),
      render_vd_insert_tables())
  )

}

shinyApp(
  ui =  dropdownMenuUI() ,
  server = function(input, output, session) {

    observeEvent(input$add, {
      insertUI(
        selector = ".dropdown-menu >
        .dropdown-item.dropdown-header",
        where = "afterEnd",
        ui = messageItem(
          message = paste("message", input$add),
          image = dashboardUserImage,
          from = "Divad Nojnarg",
          time = "today",
          color = "success"
        )
      )
    })
  }
)
