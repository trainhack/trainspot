div class: "hero-unit", ->
  h3  "Is this the journey you want?" 
  h2 @journey.name

  form action: "/checkins", method: "post",  ->
    input type: "hidden", name: "journey", value: "#{@journey.id}"
    button class: "btn btn-large btn-primary", type: "submit",  "Yes, check me in"
    a href: "/journeys", ->
      p ->
        small class: "cancel", "No, take me back"