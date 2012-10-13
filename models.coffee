User =
  name: String
  email: String
  picture: String
  twitterId: String

Checkin =
  journey = String
  user = String

Journey =
  time  = Date
  route = ObjectId
  users = Array

Route =
  startLocation = String
  destination = String


#  typical queries:
#  "show me all the other people checking in on this journey train right now"
#  "show me all the other people who regularly check in on this route train right now"
#  "show me all the "
