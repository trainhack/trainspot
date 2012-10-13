port = process.env.APP_PORT || 3000
host = process.env.APP_HOST || "localhost"

require('zappajs') host, port, ->
  manifest = require './package.json'
  mongoose = require 'mongoose'
  passport = require 'passport'
  googOID = require('passport-google').Strategy

  models = require('./models')
  User = models.user

  passport.use new googOID
    returnURL: "http://#{host}:#{port}/auth/google/return"
    , realm: "http://#{host}:#{port}"
    , (identifier, profile, done) ->
      User.findOrCreate { openId: identifier }, (err, user) ->
        done err, { user: user, profile: profile }

  passport.serializeUser (auth, done) ->
    done null, auth

  passport.deserializeUser (auth, done) ->
    User.findById auth.user._id, (err, user) ->
      done err, auth

  @configure =>
    @use 'cookieParser',
      'bodyParser',
      'methodOverride',
      'session': secret: 'shhhhhhhhhhhhhh!',
      passport.initialize(),
      passport.session(),
      @app.router,
      'static'

  @configure
    development: =>
      mongoose.connect "mongodb://#{host}/#{manifest.name}-dev"
      @use errorHandler: {dumpExceptions: on, showStack: on}
    production: =>
      services = JSON.parse process.env.VCAP_SERVICES
      mongo = services['mongodb-1.8'][0]['credentials']
      mongoose.connect "mongodb://#{mongo.username}:#{mongo.password}@#{mongo.hostname}:#{mongo.port}/#{mongo.db}"
      @use 'errorHandler'

  @include 'routes'
