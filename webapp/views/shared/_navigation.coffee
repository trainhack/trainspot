div class: "nav", ->
  if @passport.user
    coffeescript -> console.log 'view', @passport
    li -> "Signed in as #{@passport.user.profile.name.givenName}"