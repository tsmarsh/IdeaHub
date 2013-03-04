Card = (@description) ->
	@

Column = (title, @cards) ->
	@title = ko.observable(title)
	@addCard = =>
		@cards.push(new Card("Please add details"))
	@

Page = (@columns) ->
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