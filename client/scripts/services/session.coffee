"use strict"

angular.module("testApp")
	.factory "Session", ($resource) ->
		$resource "/api/session/"