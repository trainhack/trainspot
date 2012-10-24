div class: "container", ->
  div class: "row", -> 
    ol class: "nav nav-tabs nav-stacked", ->
      for j in @journeys
        li ->
          a href: "/journeys/#{j._id}", "#{j.name}"
