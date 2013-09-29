(function() {
  var app, controllers, express, http, path, __parentDir;

  express = require('express');

  controllers = require('./controllers');

  http = require('http');

  path = require('path');

  app = module.exports = express();

  __parentDir = path.dirname(process.mainModule.filename);

  global.env = app.settings.env;

  app.configure(function() {
    app.set('port', process.env.PORT || 3000);
    app.set('views', __parentDir + '/src/views');
    app.set('view engine', 'jade');
    app.use(express.logger('dev'));
    app.use(express.bodyParser());
    app.use(express.methodOverride());
    app.use(app.router);
    return app.use(express["static"](__parentDir + '/app/public'));
  });

  app.configure('development', function() {
    app.use(express.errorHandler());
    return app.use("/src", express["static"](__parentDir + '/src'));
  });

  app.get('/', controllers.home);

  app.get('/features', controllers.features);

  http.createServer(app).listen(app.get('port'), function() {
    return console.log("Express server on port " + app.get('port'));
  });

}).call(this);

/*
//@ sourceMappingURL=application.js.map
*/