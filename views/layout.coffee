doctype 5
html ->
  head ->
    partial "shared/meta"

  body role: "application", ->
    #if browserIs "ie"
    #  javascriptTag "http://html5shiv.googlecode.com/svn/trunk/html5.js"

    @templates if @templates

    div id: "navigation", class: "navbar", role: "navigation", ->
      div class: "navbar-inner", ->
        a class: "brand", href: "#", -> "Trainspot"
        div class: "container", ->
          partial "shared/navigation"

    div class: "body", ->
      @body

    footer id: "footer", class: "footer", role: "contentinfo", ->
      div class: "container", ->
        partial "shared/footer"

  if @popups
    aside id: "popups", ->
      @popups

  if @bottom
    @bottom

    script "App.bootstrap(#{JSON.stringify(@bootstrapData, null, [])})" if @bootstrapData
