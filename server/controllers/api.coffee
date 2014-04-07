"use strict"

mongoose = require("mongoose")
Thing = mongoose.model("Thing")

###
Get amazing things
###
exports.amazingThings = (req, res) ->
	Thing.find (err, things) ->
		unless err
			res.json things
		else
			res.send err