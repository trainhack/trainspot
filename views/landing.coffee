div class: "container", ->
  div class: "row", -> 
    unless @passport.user

      h1 "What if trains were on Foursquare?"

      a class: "btn btn-large btn-primary", href: '/auth/google' , "Sign in with Google"

    