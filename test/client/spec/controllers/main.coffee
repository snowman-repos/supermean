'use strict'

describe 'Controller: MainCtrl', () ->

	# load the controller's module
	beforeEach module 'testApp'

	MainCtrl = {}
	scope = {}
	$httpBackend = {}

	# Initialize the controller and a mock scope
	beforeEach inject (_$httpBackend_, $controller, $rootScope) ->
		$httpBackend = _$httpBackend_
		$httpBackend.expectGET('/api/amazingThings').respond ['HTML5 Boilerplate', 'AngularJS', 'Karma', 'Express']
		scope = $rootScope.$new()
		MainCtrl = $controller 'MainCtrl', {
			$scope: scope
		}

	it 'should attach a list of amazingThings to the scope', () ->
		expect(scope.amazingThings).toBeUndefined()
		$httpBackend.flush()
		expect(scope.amazingThings.length).toBe 4