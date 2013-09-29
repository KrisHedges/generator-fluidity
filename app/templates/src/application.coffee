#
# ### Express App Module Dependencies.
#
express = require 'express'
controllers = require './controllers'
http = require 'http'
path = require 'path'

# ### Setup Some Variables
# - app is our express app
# - __parentDir will give us a bit more flexibility through explicity
# - global.env var is used for determining assets to include in jade views
#
app = module.exports = express()
__parentDir = path.dirname(process.mainModule.filename)
global.env = app.settings.env

#
# ### Configure our express app.
#
app.configure ->
  app.set 'port', process.env.PORT || 3000
  app.set 'views', __parentDir + '/src/views'
  app.set 'view engine', 'jade'
  app.use express.logger('dev')
  app.use express.bodyParser()
  app.use express.methodOverride()
  app.use app.router
  app.use express.static(__parentDir + '/app/public')

#
# ### Configure our express development environment.
#
app.configure 'development', ->
  app.use express.errorHandler()
# Exposes our source code for source mapping during development
  app.use("/src", express["static"](__parentDir + '/src'))
#
# ### Routes
#
app.get '/', controllers.home
app.get '/features', controllers.features

#
# ### Launch our App
#
http.createServer(app).listen app.get('port'), ->
  console.log("Express server on port " + app.get('port'))
