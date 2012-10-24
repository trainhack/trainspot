passport = require 'passport'
models = require './models'
@include = ->

  @get '/': ->
    @render 'landing': { passport: @session.passport }

  @post '/set_location': ->
    @session.location = @body.location or { latitude: 51.518190, longitude: -0.178099 }
    @response.json @session.location

  @get '/journeys': ->
    lat = @query.lat or @session.location.latitude
    lon = @query.lon or @session.location.longitude
    models.journey.find({ location : { $near : [lat,lon] } })
      .limit(10)
      .exec (err, journeys) =>
        if err
          throw err
        else
          @render 'journeys': { journeys: journeys, passport: @session.passport }
          
  @get '/journeys/:journey': ->
    models.journey.findById @params.journey, (err, journey) =>

      if err
        throw err
      else
        # console.log journey
        @render 'checkin': {passport: @session.passport, journey: journey}

  @get '/checked-in': ->
    @render 'checked_in': { passport: @session.passport }

  @post '/checkins': ->
    models.journey.findById @body.journey, (err, journey) =>
      
      # check if user in the array, and add him if not, using addToSet
      if err
        throw err
      else
        @render 'checked_in': {passport: @session.passport, journey: journey}

  @get '/env': -> @response.json process.env

  # Authentication
  @app.get '/auth/google', passport.authenticate 'google'
  @app.get '/auth/google/return', passport.authenticate 'google', { successRedirect: '/', failureRedirect: '/login' }

  @app.get '/auth/foursquare', passport.authenticate 'foursquare'
  @app.get '/auth/foursquare/callback', passport.authenticate('foursquare', { successRedirect: '/', failureRedirect: '/login' })

  @get '/auth/:provider': ->
    passport.authenticate @params.provider

  @get '/auth/:provider/return': ->
    passport.authenticate @params.provider, { successRedirect: '/', failureRedirect: '/login' }
