library(shiny)

ui <- fluidPage(
  tags$style("p { color: red;}"),
  tags$script(
    "alert('Click on the Hello World text!');
     // change text color
     function changeColor(color){
       document.getElementById('hello').style.color = color;
     }
    "
  ),
  p(id = "hello", onclick="changeColor('green')", "Hello World")
)

server <- function(input, output, session) {}

shinyApp(ui, server)