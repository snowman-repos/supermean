"use strict"

mongoose = require("mongoose")
Schema = mongoose.Schema

###
Thing Schema
###
ThingSchema = new Schema(
	name: String
	info: String
	amazingness: Number
)

###
Validations
###
ThingSchema.path("amazingness").validate ((num) ->
	num >= 1 and num <= 10
), "Amazingness must be between 1 and 10"
mongoose.model "Thing", ThingSchema