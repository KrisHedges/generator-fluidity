(function() {
  var features;

  features = require('../models/feature');

  module.exports = function(req, res) {
    res.contentType('application/json');
    return res.json(features);
  };

}).call(this);

/*
//@ sourceMappingURL=features.js.map
*/