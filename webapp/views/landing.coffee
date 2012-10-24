div class: "container", ->
  div class: "row", -> 
    coffeescript ->
      $ ->
      navigator.geolocation.getCurrentPosition (position) ->
        console.log position
        $.post '/set_location',
          location: position.coords,
          (data) ->
            done

    if @passport.user
      a class: "btn btn-large btn-primary", href: '/journeys' , "Show nearby trains"
    else
      h1 "What if trains were on Foursquare?"

      p ->
        a class: "btn btn-large btn-primary", href: '/auth/foursquare' , "Sign in with Foursquare"
      p ->
        a class: "btn btn-large btn-primary", href: '/auth/google' , "Sign in with Google"