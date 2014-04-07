describe "Home Page", ->
	ptor = protractor.getInstance()
	it "should load the homepage", ->
		ptor.get "/"
		expect(ptor.findElement(protractor.By.id("view-container")).getText()).toBe "Welcome Home..."