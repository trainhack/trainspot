port = process.env.VMC_APP_PORT || 3000
host = process.env.VCAP_APP_HOST || "localhost"

require('zappajs') port, ->
  manifest = require './package.json'
  mongoose = require 'mongoose'

  @configure =>
    @use 'cookieParser',
      'bodyParser',
      'methodOverride',
      'session': secret: 'shhhhhhhhhhhhhh!',
      @app.router,
      static: __dirname + '/static',

  @configure
    development: =>
      mongoose.connect "mongodb://#{host}/#{manifest.name}-dev"
      @use errorHandler: {dumpExceptions: on, showStack: on}
    production: =>
      mongoose.connect "mongodb://#{host}/#{manifest.name}"
      @use 'errorHandler'

  @get '/': -> 'Hello, World!'
