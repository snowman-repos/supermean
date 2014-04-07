"use strict"

angular.module("testApp")
	.factory "AmazingThing", ["$resource", ($resource) ->
		$resource "/api/amazingThings/:id",
			id: "@_id"
		,
			update:
				method: "PUT"
	]