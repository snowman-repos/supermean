"use strict"

api = require("./controllers/api")
index = require("./controllers")
users = require("./controllers/users")
session = require("./controllers/session")
middleware = require("./middleware")

###
Application routes
###
module.exports = (app) ->
	
	# Server API Routes
	app.get "/api/amazingThings", api.amazingThings
	app.post "/api/users", users.create
	app.put "/api/users", users.changePassword
	app.get "/api/users/me", users.me
	app.get "/api/users/:id", users.show
	app.post "/api/session", session.login
	app.del "/api/session", session.logout
	
	# All undefined api routes should return a 404
	app.get "/api/*", (req, res) ->
		res.send 404
	
	# All other routes to use Angular routing in app/scripts/app.js
	app.get "/partials/*", index.partials
	app.get "/*", middleware.setUserCookie, index.index