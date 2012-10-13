div class: "nav", ->
  if @passport.user
    coffeescript -> console.log 'view', @passport
    li -> "Signed in as #{@passport.user.profile.displayName}"
  else
    li -> a href: '/auth/google', "Sign in via google"
