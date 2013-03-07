Task = (description) ->
  @description = ko.observable(description)
  @

Label = (title, tasks) ->
  @title = ko.observable(title)
  @tasks = ko.observableArray(tasks)
  @

ViewModel = () ->
  todoTasks = new Label("To do", [new Task("Get dog food"), new Task("Mow lawn"), new Task("Fix car")])
  doingTasks= new Label("Doing", [new Task("Fix fence"), new Task("Walk dog"), new Task("Read book")])
  doneTasks = new Label("Done", [])
  @labels = ko.observableArray([todoTasks, doingTasks, doneTasks])
  
  @selectedTask =  ko.observable()
  
  @clearSelectedTask = =>
    @selectedTask("")

  @selectTask = (task) =>
    @selectedTask task

  @addTask = =>
    task = new Task("")
    @selectedTask task
    @labels()[0].tasks.push task

  @trash = ko.observableArray()
  @

ko.bindingHandlers.sortableList = init: (element, valueAccessor, allBindingsAccessor, context) ->
  $(element).data "sortList", valueAccessor() #attach meta-data
  $(element).sortable
    update: (event, ui) ->
      item = ui.item.data("sortItem")
      if item
        originalParent = ui.item.data("parentList")
        newParent = ui.item.parent().data("sortList")
        
        position = ko.utils.arrayIndexOf(ui.item.parent().children(), ui.item[0])
        if position >= 0
          originalParent.remove item
          newParent.splice position, 0, item
        ui.item.remove()

    connectWith: ".container"

ko.bindingHandlers.sortableItem = 
  init: (element, valueAccessor) ->
    options = valueAccessor()
    $(element).data "sortItem", options.item
    $(element).data "parentList", options.parentList

ko.bindingHandlers.visibleAndSelect = 
  update: (element, valueAccessor) ->
    ko.bindingHandlers.visible.update element, valueAccessor
    if valueAccessor()
      setTimeout (->
        $(element).focus().select()
      ), 0 #new tasks are not in DOM yet

$ ->
  ko.applyBindings( new ViewModel())