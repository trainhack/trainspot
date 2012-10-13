class Journey
  include Mongoid::Document

  field :name, type: String
  field :time, type: Date
  field :users, type: Array
  field :trainId, type: String
  field :location, type: Array
  field :scheduleId, type: String
  field :terminated, type: Boolean
  field :route, type: Moped::BSON::ObjectId

end

# JourneySchema = new mongoose.Schema
#   name: String
#   time: Date
#   users: [{type: mongoose.Schema.ObjectId, ref: 'User'}]
#   trainID: String
#   location: Array
#   scheduleId: String
#   terminated: Boolean
#
#   route:
#     type: mongoose.Schema.ObjectId
#     ref: 'Route'
