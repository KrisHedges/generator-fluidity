# Provide a console meesage too demonstrate coffee source maps in development
$ ->
  console.log "Check it out Coffee Source Maps!"

  $.get '/features', (features) ->
    console.log "Hello"
    features.map (f)->
      $('.features').append "<h5>#{f.name}</h5><p>#{f.description}</p>"
