(function() {
  $(function() {
    console.log("Check it out Coffee Source Maps!");
    return $.ajax('/features', {
      type: 'GET',
      dataType: 'json',
      success: function(features) {
        return _.map(features, function(f) {
          return $('.features').append("<h5>" + f.name + "</h5><p>" + f.description + "</p>");
        });
      }
    });
  });

}).call(this);

/*
//@ sourceMappingURL=client.js.map
*/