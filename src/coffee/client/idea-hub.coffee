Model = (@name) ->
	@
$ ->
	model = new Model("Tom")
	ko.applyBindings(model)