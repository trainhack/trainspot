meta charset: "utf-8"

title @title if @title

@stylesheet = ['//netdna.bootstrapcdn.com/twitter-bootstrap/2.1.1/css/bootstrap-combined.min']

@scripts = ['http://code.jquery.com/jquery.min','//netdna.bootstrapcdn.com/twitter-bootstrap/2.1.1/js/bootstrap.min']

link href: "/favicon.png", rel: "icon shortcut-icon favicon"

if @stylesheets
  for s in @stylesheets
    link rel: 'stylesheet', href: s + '.css'
if @stylesheet
  link(rel: 'stylesheet', href: @stylesheet + '.css')
style @style if @style
if @scripts
  for s in @scripts
    script src: s + '.js'
script(src: @script + '.js') if @script

