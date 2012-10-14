div class: "container", ->
  div class: "row", -> 
    ol class: "nav nav-tabs nav-stacked", ->
      for j in @journeys
        li ->
          a href: "/checkin/#{j._id}", "#{j.name}"
