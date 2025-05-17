library(shiny)

dropdownDeps <- function(){
  htmltools::htmlDependency(name = "handwriting",
                            version = "1.0.0",
                            src = c(file = "."),
                            script = "handwriting.canvas.js")
}


ui = fluidPage(
  dropdownDeps(),
  htmltools::HTML('

                  <div>
  <span style="display : inline-block">
    PenSize <span id="lineWidth">3</span><input type="range" id="penSize" min="1" max="30" value="3">
    <br>
    <canvas id="canvas" width="400" height="400" style="border: 2px solid; cursor: crosshair;"></canvas>
    <br>
    <form>
      Language:
      <select id="language">
        <option value="zh_TW" selected="selected">Chinese</option>
        <option value="ja">Japanese</option>
        <option value="en">English</option>
      </select>
    </form>
    <br>
    <button onclick="canvas.erase();">Erase</button>
    <button onclick="
                  var e = document.getElementById(\'language\');
                  canvas.setOptions({language: e.options[e.selectedIndex].value});
                  canvas.recognize();
                  ">Send</button>
    <button onclick="canvas.undo()">Undo</button>
    <button onclick="canvas.redo()">Redo</button>
    <br>
     <p id="result2">result: <span id="result"></span></p>
  </span>
  <script type="text/javascript" src="handwriting.canvas.js"></script>
  <script type="text/javascript" defer="">
    var canvas = new handwriting.Canvas(document.getElementById(\'canvas\'), 3);
    var width = document.getElementById("demo").clientWidth
    canvas.cxt.canvas.width  = width < 400 ? width : 400;
    canvas.cxt.canvas.height = width < 400 ? width : 400;
    canvas.setCallBack(function(data, err) {
      if (err) throw err;
      else document.getElementById("result").innerHTML = data;
    });
    canvas.set_Undo_Redo(true, true);
    var penSize = document.getElementById("penSize");
    penSize.addEventListener("mousemove", function() {
      document.getElementById("lineWidth").innerHTML = penSize.value;
    });
    penSize.addEventListener("change", function(){
      canvas.setLineWidth(penSize.value);
    });
  </script>
</div>
')
)



server <- function(input, output, session) {

  observeEvent(input$myinput,{
    removeUI(selector = "#result")

    insertUI(selector = "#result2",
             ui = paste0(as.character(input$myinput), collapse = " "),
             where = "afterEnd")
  })

}

shinyApp(ui, server)
