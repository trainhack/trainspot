ApiServer = require 'apiserver'

apiserver = new ApiServer()
port = (process.env.VMC_APP_PORT or 3000)
host = (process.env.VCAP_APP_HOST or "localhost")
apiserver.listen port, onListen
console.log "API server listening on port #{port} in #{process.env.NODE_ENV} mode"

onListen = (err) ->
  if err
    console.error "Something terrible happened: #{err.message}"
  else
    console.log "Successfully bound to port #{@port}"
    setTimeout apiserver.close onClose, 5000

onClose = () -> console.log "port unbound correctly"

helloModule =
  world: (req, resp) ->
    resp.serveJSON {hello: 'world'}

apiserver.addModule 'v1', 'hello', helloModule
