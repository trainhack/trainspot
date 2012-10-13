require('zappajs') ->
  @configure =>
    @use 'bodyParser', 'methodOverride', @app.router, 'static'

  @configure
    development: => @use errorHandler: {dumpExceptions: on, showStack: on}
    production: => @use 'errorHandler'

  @get '/': -> 'Hello, World!'
