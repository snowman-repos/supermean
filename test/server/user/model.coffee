"use strict"

should = require("should")
mongoose = require("mongoose")
User = mongoose.model("User")

user = {}

describe "User Model", ->
	before (done) ->
		user = new User
			provider: "local"
			name: "Fake User"
			email: "test@test.com"
			password: "password"

		# Clear users before testing
		User.remove().exec()
		done()

	afterEach (done) ->
		User.remove().exec()
		done()

	it "should begin with no users", (done) ->
		User.find {}, (err, users) ->
			users.should.have.length(0)
			done()

	it "should fail when saving a duplicate user", (done) ->
		user.save()
		userDup = new User(user)
		userDup.save (err) ->
			should.exist(err)
			done()

	it "should fail when saving without an email", (done) ->
		user.email = ""
		user.save (err) ->
			should.exist(err)
			done()

	it "should authenticate user if password is valid", ->
		user.authenticate("password").should.be.true

	it "should not authenticate user if password is invalid", ->
		user.authenticate("blah").should.not.be.true