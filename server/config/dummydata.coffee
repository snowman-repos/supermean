"use strict"

mongoose = require("mongoose")
User = mongoose.model("User")
Thing = mongoose.model("Thing")

###
Populate database with sample application data
###

#Clear old things, then add things in
Thing.find({}).remove ->
	Thing.create
		name: "HTML5 Boilerplate"
		info: "HTML5 Boilerplate is a professional front-end template for building fast, robust, and adaptable web apps or sites."
		amazingness: 10
	,
		name: "AngularJS"
		info: "AngularJS is a toolset for building the framework most suited to your application development."
		amazingness: 10
	,
		name: "Karma"
		info: "Spectacular Test Runner for JavaScript."
		amazingness: 10
	,
		name: "Express"
		info: "Flexible and minimalist web application framework for node.js."
		amazingness: 10
	,
		name: "MongoDB + Mongoose"
		info: "An excellent document database. Combined with Mongoose to simplify adding validation and business logic."
		amazingness: 10
	, ->
		console.log "finished populating things"

# Clear old users, then add a default user
User.find({}).remove ->
	User.create
		provider: "local"
		name: "Test User"
		email: "test@test.com"
		password: "test"
	, ->
		console.log "finished populating users"