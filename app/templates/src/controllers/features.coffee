# Get People
#
# * Import our "model"
# * Send a json response on request
#
features = require '../models/feature'

module.exports = (req, res) ->
  res.contentType('application/json')
  res.json(features)
