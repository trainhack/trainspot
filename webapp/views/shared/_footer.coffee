cite class: "copyright", ->
  span "&copy;"
  if @author and @email
    a @author, href: @email
  span @year or 2012
