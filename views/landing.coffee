div class: "container", ->
  div class: "row", -> 
    if @passport.user
      a class: "btn btn-large btn-primary", href: '/journeys' , "Show nearby trains"
    else
      h1 "What if trains were on Foursquare?"

      a class: "btn btn-large btn-primary", href: '/auth/google' , "Sign in with Google"

      coffeescript ->
        $ ->
        navigator.geolocation.getCurrentPosition (position) ->
          console.log position
          $.post '/set_location', location: position.coords, (data) ->
            console.log data
            $('a.btn').before "<div class='alert alert-success'><p>Look! Your latitude is #{data.latitude}, and your longitude is #{data.longitude}!</p><p>How handy is that?</p></div>"
