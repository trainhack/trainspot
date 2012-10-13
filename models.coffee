mongoose = require 'mongoose'
supergoose = require 'supergoose'

UserSchema = new mongoose.Schema
  name: String
  email: String
  picture: String
  twitterId: String

UserSchema.plugin supergoose

CheckinSchema = new mongoose.Schema
  journey:
    type: mongoose.Schema.ObjectId
    ref: 'Journey'
  user:
    type: mongoose.Schema.ObjectId
    ref: 'User'
  location:
    type: mongoose.Schema.ObjectId
    ref: 'Location'

JourneySchema = new mongoose.Schema
  time: Date
  route:
    type: mongoose.Schema.ObjectId
    ref: 'Route'
  users: [{type: mongoose.Schema.ObjectId, ref: 'User'}]

LocationSchema = new mongoose.Schema
  name: String
  location:
    lon: Number
    lat: Number

LocationSchema.index
  location: '2d'

RouteSchema = new mongoose.Schema
  start:
    type: mongoose.Schema.ObjectId
    ref: 'Location'
  destination:
    type: mongoose.Schema.ObjectId
    ref: 'Location'

module.exports.user = mongoose.model 'User', UserSchema
module.exports.checkin = mongoose.model 'Checkin', CheckinSchema
module.exports.journey = mongoose.model 'Journey', JourneySchema
module.exports.location = mongoose.model 'Location', LocationSchema
module.exports.route = mongoose.model 'Route', RouteSchema

#  typical queries:
#  "show me all the other people checking in on this journey train right now"
#  "show me all the other people who regularly check in on this route train right now"
#  "show me all the "
