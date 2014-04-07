"use strict"

angular.module("testApp")
	.controller "NavbarCtrl", ($scope, $location, Auth) ->
		$scope.menu = [
			title: "Home"
			link: "/"
		, 
			title: "Profile"
			link: "/profile"
		]
		
		$scope.logout = ->
			Auth.logout().then ->
				$location.path "/login"
		
		$scope.isActive = (route) ->
			route is $location.path()