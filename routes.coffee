passport = require 'passport'
models = require './models'
@include = ->
  @get '/': ->
    @render 'landing': { passport: @session.passport }

  @get '/journeys': ->
    lat = @request.query.lat or -2.009
    lon = @request.query.lon or 53.73
    models.journey.find({ location : { $near : [lat,lon] } })
      .limit(10)
      .exec (err, journeys) =>
        if err
          throw err
        else
          @render 'journeys': { journeys: journeys, passport: @session.passport }
          

  @get '/env': -> @response.json process.env

  # Authenication
  @app.get '/auth/google', passport.authenticate 'google'
  @app.get '/auth/google/return', passport.authenticate 'google', { successRedirect: '/', failureRedirect: '/login' }

  @get '/auth/:provider': ->
    passport.authenticate @params.provider

  @get '/auth/:provider/return': ->
    passport.authenticate @params.provider, { successRedirect: '/', failureRedirect: '/login' }
