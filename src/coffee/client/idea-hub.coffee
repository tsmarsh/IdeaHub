Card = (description) ->
	@description = ko.observable(description)
	@

Column = (title, @cards) ->
	@title = ko.observable(title)
	@addCard = =>
		@cards.push(ko.observable(new Card("")))
	@

Page = (@columns) ->
	$('#cardModal').modal
			keyboard: true
			show: false

	@setCurrentCard = (data) =>
		console.log(data)
		@currentCard(data)
		$('#cardModal').modal 'show'
	@

$ ->
	todoCards = ko.observableArray()
	doingCards = ko.observableArray()
	doneCards = ko.observableArray()

	todos = new Column("Todo", todoCards)
	doing = new Column("Doing", doingCards)
	done = new Column("Done", doneCards) 
	columns = ko.observableArray([todos, doing, done])

	window.page = new Page(columns)
	ko.applyBindings(page)