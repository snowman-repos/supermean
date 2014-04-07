"use strict"

express = require("express")
path = require("path")
fs = require("fs")
mongoose = require("mongoose")

###
Main application file
###

# Set default node environment to development
process.env.NODE_ENV = process.env.NODE_ENV or "development"

# Application Config
config = require("./server/config/config")

# Connect to database
db = mongoose.connect(config.mongo.uri, config.mongo.options)

# Bootstrap models
modelsPath = path.join(__dirname, "server/models")
fs.readdirSync(modelsPath).forEach (file) ->
	require modelsPath + "/" + file	if /(.*)\.(js$|coffee$)/.test(file)

# Populate empty DB with sample data
require "./server/config/dummydata"

# Passport Configuration
passport = require("./server/config/passport")
app = express()

# Express settings
require("./server/config/express") app

# Routing
require("./server/routes") app

# Start server
app.listen config.port, ->
	console.log "Express server listening on port %d in %s mode", config.port, app.get("env")
	return

# Expose app
exports = module.exports = app