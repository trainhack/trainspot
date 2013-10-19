passport = require 'passport'
models = require './models'
@include = ->

  @get '/': ->
    @render 'landing': { passport: @session.passport }

  @post '/set_location': ->
    @session.location = @body.location or { latitude: 51.518190, longitude: -0.178099 }
    @response.json @session.location

  @get '/journeys': ->
    if not @session.location
      @session.location = { latitude: 51.518190, longitude: -0.178099 }
    lat = @query.lat or @session.location.latitude
    lon = @query.lon or @session.location.longitude
    models.journey.find({ location : { $near : [lat,lon] } })
      .limit(10)
      .exec (err, journeys) =>
        if err
          throw err
        else
          @render 'journeys': { journeys: journeys, passport: @session.passport }
          
  @get '/checked-in': ->
    @render 'checked_in': { passport: @session.passport }

  @get '/checkin/:journey': ->
    models.journey.findById @params.journey, (err, journey) =>
      if err
        throw err
      else
        @render 'checkin': {passport: @session.passport, journey: journey}

  @get '/env': -> @response.json process.env

  # Authenication
  @app.get '/auth/google', passport.authenticate 'google'
  @app.get '/auth/google/return', passport.authenticate 'google', { successRedirect: '/', failureRedirect: '/login' }

  @get '/auth/:provider': ->
    passport.authenticate @params.provider

  @get '/auth/:provider/return': ->
    passport.authenticate @params.provider, { successRedirect: '/', failureRedirect: '/login' }
