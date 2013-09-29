# Provide a console meesage too demonstrate coffee source maps in development
$ ->
  console.log "Check it out Coffee Source Maps!"

  $.ajax '/features',
      type: 'GET'
      dataType: 'json'
      success: (features) ->
        _.map features, (f)->
          $('.features').append "<h5>#{f.name}</h5><p>#{f.description}</p>"
