"use strict"

describe "Service: AmazingThing", ->
	
	# load the service's module
	beforeEach module("testApp")
	
	# instantiate service
	AmazingThing = undefined
	beforeEach inject((_AmazingThing_) ->
		AmazingThing = _AmazingThing_
	)
	it "should do something", ->
		expect(!!AmazingThing).toBe true