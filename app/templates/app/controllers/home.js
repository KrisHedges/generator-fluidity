(function() {
  module.exports = function(req, res) {
    return res.render('index', {
      env: env,
      title: "Yeoman => Express, Coffeescript, Stylus & Fluidity"
    });
  };

}).call(this);

/*
//@ sourceMappingURL=home.js.map
*/