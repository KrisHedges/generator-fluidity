# Get Home page
#
# * Render index.jade view through default layout
# * Pass the env var to the views
# * Pass the title var to the views
#
module.exports = (req, res) ->
  res.render 'index', {
    env: env,
    title: "Yeoman => Express, Coffeescript, Stylus & Fluidity"
  }
