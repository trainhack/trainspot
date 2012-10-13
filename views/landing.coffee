div class: "container", ->
  div class: "row", -> 
    unless @passport.user

      h1 "What if trains were on Foursquare?"

      a class: "btn btn-large btn-primary", href: '/auth/google' , "Sign in with Google"

    coffeescript ->
      $ ->
      navigator.geolocation.getCurrentPosition (position) ->
        startPos = position
        $('a.btn').before "<div class='alert alert-success'><p>Look! Your latitude is #{position.coords.latitude}, and your longitude is #{position.coords.longitude}!</p><p>How handy is that?</p></div>"
        console.log position
        


    