"use strict"

angular.module("testApp")
	.factory "User", ($resource) ->
		$resource "/api/users/:id",
			id: "@id"
		,
			update:
				method: "PUT"
				params: {}

			get:
				method: "GET"
				params:
					id: "me"