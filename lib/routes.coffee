'use strict'

api = require('./controllers/api')
index = require('./controllers')

###
Application routes
###
module.exports = (app) ->
  
  # Server API Routes
  app.route('/api/awesomeThings').get api.awesomeThings
  
  # All undefined api routes should return a 404
  app.route('/api/*').get (req, res) ->
    res.send 404
    return

  # All other routes to use Angular routing in app/scripts/app.js
  app.route('/partials/*').get index.partials
  app.route('/*').get index.index
  return