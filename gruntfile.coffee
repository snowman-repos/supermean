# Generated on 2014-03-30 using generator-angular-fullstack 1.3.3
"use strict"

# # Globbing
# for performance reasons we're only matching one level down:
# 'test/spec/{,*/}*.js'
# use this if you want to recursively match all subfolders:
# 'test/spec/**/*.js'
process.env.NODE_ENV = process.env.NODE_ENV or "development"
config = require("./server/config/config")
module.exports = (grunt) ->
	
	# Load grunt tasks automatically
	require("load-grunt-tasks") grunt
	
	# Time how long tasks take. Can help when optimizing build times
	require("time-grunt") grunt
	
	# Define the configuration for all the tasks
	grunt.initConfig
		
		# Project settings
		yeoman:
			
			# configurable paths
			client: require("./bower.json").appPath or "client"
			dist: "dist"

		express:
			options:
				port: config.port
				cmd: "coffee"

			dev:
				options:
					script: "server.coffee"
					debug: true

			prod:
				options:
					script: "dist/server.coffee"
					node_env: "production"

		open:
			server:
				url: "http://localhost:<%= express.options.port %>"

		watch:
			coffee:
				files: ["<%= yeoman.client %>/scripts/{,*/}*.{coffee,litcoffee,coffee.md}"]
				tasks: ["newer:coffee:dist"]

			coffeeTest:
				files: ["test/spec/{,*/}*.{coffee,litcoffee,coffee.md}"]
				tasks: [
					"newer:coffee:test"
					"karma"
				]

			stylus:
				files: ["<%= yeoman.client %>/styles/{,*/}*.styl"]
				tasks: [
					"stylus:server"
					"autoprefixer"
				]

			gruntfile:
				files: ["Gruntfile.js"]

			livereload:
				files: [
					"<%= yeoman.client %>/views/{,*//*}*.{html,jade}"
					"{.tmp,<%= yeoman.client %>}/styles/{,*//*}*.css"
					"{.tmp,<%= yeoman.client %>}/scripts/{,*//*}*.js"
					"<%= yeoman.client %>/images/{,*//*}*.{png,jpg,jpeg,gif,webp,svg}"
				]
				options:
					livereload: true

			express:
				files: [
					"server.js"
					"server/**/*.{js,json}"
				]
				tasks: [
					"newer:jshint:server"
					"express:dev"
					"wait"
				]
				options:
					livereload: true
					nospawn: true #Without this option specified express won't be reloaded

		
		# Make sure code styles are up to par and there are no obvious mistakes
		jshint:
			options:
				jshintrc: ".jshintrc"
				reporter: require("jshint-stylish")

			server:
				options:
					jshintrc: "server/.jshintrc"

				src: ["server/{,*/}*.js"]

			all: []

		
		# Empties folders to start fresh
		clean:
			dist:
				files: [
					dot: true
					src: [
						".tmp"
						"<%= yeoman.dist %>/*"
						"!<%= yeoman.dist %>/.git*"
						"!<%= yeoman.dist %>/Procfile"
					]
				]

			heroku:
				files: [
					dot: true
					src: [
						"heroku/*"
						"!heroku/.git*"
						"!heroku/Procfile"
					]
				]

			server: ".tmp"

		
		# Add vendor prefixed styles
		autoprefixer:
			options:
				browsers: ["last 1 version"]

			dist:
				files: [
					expand: true
					cwd: ".tmp/styles/"
					src: "{,*/}*.css"
					dest: ".tmp/styles/"
				]

		
		# Debugging with node inspector
		"node-inspector":
			custom:
				options:
					"web-host": "localhost"

		
		# Use nodemon to run server in debug mode with an initial breakpoint
		nodemon:
			debug:
				script: "server.js"
				options:
					nodeArgs: ["--debug-brk"]
					env:
						PORT: config.port

					callback: (nodemon) ->
						nodemon.on "log", (event) ->
							console.log event.colour

						
						# opens browser on initial server start
						nodemon.on "config:update", ->
							setTimeout (->
								require("open") "http://localhost:8080/debug?port=5858"
							), 500

		
		# Automatically inject Bower components into the app
		"bower-install":
			client:
				html: "<%= yeoman.client %>/views/index.jade"
				ignorePath: "<%= yeoman.client %>/"

		# Compiles CoffeeScript to JavaScript
		coffee:
			options:
				sourceMap: true
				sourceRoot: ""

			dist:
				files: [
					expand: true
					cwd: "<%= yeoman.client %>/scripts"
					src: "{,*/}*.coffee"
					dest: ".tmp/scripts"
					ext: ".js"
				]

			test:
				files: [
					expand: true
					cwd: "test/client/spec"
					src: "{,*/}*.coffee"
					dest: ".tmp/client/spec"
					ext: ".js"
				]

		stylus:
			server:
				options:
					linenos: true
					compress: false
					banner: "/*" + new Date() + "*/"

				files:
					".tmp/styles/main.css": "<%= yeoman.client %>/styles/main.styl"

			dist:
				options:
					urlfunc: "embedurl"
					compress: true
					banner: "/*" + new Date() + "*/"

				files:
					"<%= yeoman.dist %>/public/styles/main.css": "<%= yeoman.client %>/styles/main.styl"

		
		# Renames files for browser caching purposes
		rev:
			dist:
				files:
					src: [
						"<%= yeoman.dist %>/public/scripts/{,*/}*.js"
						"<%= yeoman.dist %>/public/styles/{,*/}*.css"
						"<%= yeoman.dist %>/public/images/{,*/}*.{png,jpg,jpeg,gif,webp,svg}"
						"<%= yeoman.dist %>/public/styles/fonts/*"
					]

		
		# Reads HTML for usemin blocks to enable smart builds that automatically
		# concat, minify and revision files. Creates configurations in memory so
		# additional tasks can operate on them
		useminPrepare:
			html: [
				"<%= yeoman.client %>/views/index.jade"
			]
			options:
				dest: "<%= yeoman.dist %>/public"

		
		# Performs rewrites based on rev and the useminPrepare configuration
		usemin:
			html: [
				"<%= yeoman.dist %>/views/{,*/}*.html"
				"<%= yeoman.dist %>/views/{,*/}*.jade"
			]
			css: ["<%= yeoman.dist %>/public/styles/{,*/}*.css"]
			options:
				assetsDirs: ["<%= yeoman.dist %>/public"]

		
		# The following *-min tasks produce minified files in the dist folder
		imagemin:
			options:
				cache: false

			dist:
				files: [
					expand: true
					cwd: "<%= yeoman.client %>/images"
					src: "{,*/}*.{png,jpg,jpeg,gif}"
					dest: "<%= yeoman.dist %>/public/images"
				]

		svgmin:
			dist:
				files: [
					expand: true
					cwd: "<%= yeoman.client %>/images"
					src: "{,*/}*.svg"
					dest: "<%= yeoman.dist %>/public/images"
				]

		# convert SVG icons to a single sprite
		svgstore:
			options:
				prefix : "icon-"
			compile:
				files:
					"<%= yeoman.client %>/images/icons.svg": ["<%= yeoman.client %>/images/icons/*.svg"]

		htmlmin:
			dist:
				options: {}
				
				#collapseWhitespace: true,
				#collapseBooleanAttributes: true,
				#removeCommentsFromCDATA: true,
				#removeOptionalTags: true
				files: [
					expand: true
					cwd: "<%= yeoman.client %>/views"
					src: [
						"*.html"
						"partials/**/*.html"
					]
					dest: "<%= yeoman.dist %>/views"
				]

		
		# Allow the use of non-minsafe AngularJS files. Automatically makes it
		# minsafe compatible so Uglify does not destroy the ng references
		ngmin:
			dist:
				files: [
					expand: true
					cwd: ".tmp/concat/scripts"
					src: "*.js"
					dest: ".tmp/concat/scripts"
				]

		
		# Replace Google CDN references
		cdnify:
			dist:
				html: ["<%= yeoman.dist %>/views/*.html"]

		
		# Copies remaining files to places other tasks can use
		copy:
			dist:
				files: [
					{
						expand: true
						dot: true
						cwd: "<%= yeoman.client %>"
						dest: "<%= yeoman.dist %>/public"
						src: [
							"*.{ico,png,txt}"
							".htaccess"
							"bower_components/**/*"
							"images/{,*/}*.{webp}"
							"fonts/**/*"
						]
					}
					{
						expand: true
						dot: true
						cwd: "<%= yeoman.client %>/views"
						dest: "<%= yeoman.dist %>/views"
						src: "**/*.jade"
					}
					{
						expand: true
						cwd: ".tmp/images"
						dest: "<%= yeoman.dist %>/public/images"
						src: ["generated/*"]
					}
					{
						expand: true
						dest: "<%= yeoman.dist %>"
						src: [
							"package.json"
							"server.js"
							"server/**/*"
						]
					}
				]

			styles:
				expand: true
				cwd: "<%= yeoman.client %>/styles"
				dest: ".tmp/styles/"
				src: "{,*/}*.css"

		
		# Run some tasks in parallel to speed up the build process
		concurrent:
			server: [
				"coffee:dist"
				"stylus:server"
			]
			test: [
				"coffee"
				"stylus"
			]
			debug:
				tasks: [
					"nodemon"
					"node-inspector"
				]
				options:
					logConcurrentOutput: true

			dist: [
				"coffee"
				"stylus:dist"
				"imagemin"
				"svgmin"
				"svgstore"
				"htmlmin"
			]

		
		# By default, your `index.html`'s <!-- Usemin block --> will take care of
		# minification. These next options are pre-configured if you do not wish
		# to use the Usemin blocks.
		# cssmin: {
		#   dist: {
		#     files: {
		#       '<%= yeoman.dist %>/styles/main.css': [
		#         '.tmp/styles/{,*/}*.css',
		#         '<%= yeoman.client %>/styles/{,*/}*.css'
		#       ]
		#     }
		#   }
		# },
		# uglify: {
		#   dist: {
		#     files: {
		#       '<%= yeoman.dist %>/scripts/scripts.js': [
		#         '<%= yeoman.dist %>/scripts/scripts.js'
		#       ]
		#     }
		#   }
		# },
		# concat: {
		#   dist: {}
		# },
		
		# Test settings
		karma:
			unit:
				configFile: "karma.conf.coffee"
				singleRun: true

		mochaTest:
			options:
				reporter: "spec"

			src: ["test/server/**/*.coffee"]

		env:
			test:
				NODE_ENV: "test"

		protractor:
			options:
				keepAlive: true
				configFile: "./protractor.conf.js"
		
			singlerun: true
			auto:
				keepAlive: true
				options:
					args:
						seleniumPort: 4444

	
	# Used for delaying livereload until after server has restarted
	grunt.registerTask "wait", ->
		grunt.log.ok "Waiting for server reload..."
		done = @async()
		setTimeout (->
			grunt.log.writeln "Done waiting!"
			done()
		), 500

	grunt.registerTask "express-keepalive", "Keep grunt running", ->
		@async()

	grunt.registerTask "serve", (target) ->
		if target is "dist"
			grunt.task.run([
				"build"
				"express:prod"
				"open"
				"express-keepalive"
			])
		if target is "debug"
			grunt.task.run([
				"clean:server"
				"bower-install"
				"concurrent:server"
				"autoprefixer"
				"concurrent:debug"
			])
		grunt.task.run [
			"clean:server"
			"bower-install"
			"concurrent:server"
			"autoprefixer"
			"express:dev"
			"open"
			"watch"
		]

	grunt.registerTask "server", ->
		grunt.log.warn "The `server` task has been deprecated. Use `grunt serve` to start a server."
		grunt.task.run ["serve"]

	grunt.registerTask "test", (target) ->
		if target is "server"
			grunt.task.run [
				"env:test"
				"mochaTest"
			]
		else if target is "client"
			grunt.task.run [
				"clean:server"
				"concurrent:test"
				"autoprefixer"
				"karma"
			]
		else
			grunt.task.run [
				"test:server"
				"test:client"
			]
		# grunt.task.run ["protractor"]

	grunt.registerTask "build", [
		"clean:dist"
		"bower-install"
		"useminPrepare"
		"concurrent:dist"
		"autoprefixer"
		"svgstore"
		"concat"
		"ngmin"
		"copy:dist"
		"cdnify"
		"cssmin"
		"uglify"
		"rev"
		"usemin"
	]
	grunt.registerTask "heroku", ->
		grunt.log.warn "The `heroku` task has been deprecated. Use `grunt build` to build for deployment."
		grunt.task.run ["build"]

	grunt.registerTask "default", [
		"newer:jshint"
		"test"
		"build"
	]