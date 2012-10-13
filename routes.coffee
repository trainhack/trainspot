passport = require 'passport'
@include = ->
  @get '/': ->
    @render 'landing': {passport: @session.passport}

  @get '/env': -> @response.json process.env

  # Authenication
  @app.get '/auth/google', passport.authenticate 'google'
  @app.get '/auth/google/return', passport.authenticate 'google', { successRedirect: '/', failureRedirect: '/login' }

  @get '/auth/:provider': ->
    passport.authenticate @params.provider

  @get '/auth/:provider/return': ->
    passport.authenticate @params.provider, { successRedirect: '/', failureRedirect: '/login' }
