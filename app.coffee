# Not in use

port = (process.env.VMC_APP_PORT or 3000)
host = (process.env.VCAP_APP_HOST or "localhost")

http = require("http")

http.createServer((req, res) ->
  res.writeHead 200,
    "Content-Type": "text/plain"

  res.end "Hello World\n"
).listen port, host