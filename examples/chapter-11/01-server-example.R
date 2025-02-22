
s <- httpuv::startServer(
  host = "127.0.0.1",
  port = 8080,
  app = list(

    # Defines all actions to perform after the connection is established.
    onWSOpen = function(ws) {


      # Provide feedback in the console about the status of the WebSocket server
      cat("Server connection opened.\n")


      # Invoked whenever a message is received on this connection.
      ws$onMessage(function(binary, message) {

        # provide feedback in the console about the messages it receives.
        cat("Server received message:", message, "\n")

        # Sends a message from the server
        ws$send("Hello client!")

      })


      # Invoked when the connection is closed
      ws$onClose(function() {

        # Provide feedback in the console about the status of the server
        cat("Server connection closed.\n")

      })

    }
  )
)
