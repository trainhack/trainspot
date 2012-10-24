port = process.env.APP_PORT || 3000
host = process.env.APP_HOST || "localhost"

require('zappajs') host, port, ->
  manifest = require './package.json'
  mongoose = require 'mongoose'
  passport = require 'passport'
  googOID = require('passport-google').Strategy
  FoursquareStrategy = require('passport-foursquare').Strategy
  models = require('./models')
  User = models.user




  passport.use new FoursquareStrategy
    clientID: "JTN2AKQEWVSBM24JGMBMOXK30OUPJSE4HM1DWXVJEVWBROEZ",
    clientSecret: "4OPJFTIJQVWIFJPKB3ZIZID4RIJ0CFRMK0CMXPJCAYVR4S4S",
    callbackURL: "http://localhost:3000/auth/foursquare/callback",
    (accessToken, refreshToken, profile, done) ->
      console.log(profile)
      User.findOrCreate { foursquareId: profile.id }, (err, user) ->
        user.name = profile.displayName
        user.save()
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
      'logger',
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
