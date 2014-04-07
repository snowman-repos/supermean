"use strict"

angular.module("testApp")
	.controller "MainCtrl", ($scope, $http, AmazingThing) ->

		AmazingThing.query "", (things) ->
			$scope.amazingThings = things

			console.info "Fetch some things for you..."
			console.log things

		# $http.get("/api/amazingThings").success (amazingThings) ->
		# 	$scope.amazingThings = amazingThings