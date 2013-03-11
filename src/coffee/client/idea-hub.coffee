fs = require 'fs'

Task = (description) ->
  @description = ko.observable(description)
  @

Label = (title, tasks) ->
  @title = ko.observable(title)
  @tasks = ko.observableArray(tasks)
  @

ViewModel = (tasks) ->
  labels = {}
  for task in tasks
    t = new Task(task.description)
    for label in task.labels
      if labels.hasOwnProperty(label)
        labels[label].push(t)
      else
        labels[label] = [t]

  console.log("labels: ", labels)
  @labels = ko.observableArray(new Label(title, tasks) for title, tasks of labels)
  
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
  ideahub_path = './.ideahub'

  fs.exists ideahub_path, (exists) ->
    fs.mkdir(ideahub_path) unless exists
    fs.readdir(ideahub_path, (err, files) -> 
      console.log(files))

  tasks = [
    {description: "Get dog food", labels: ["To do"]},
    {description: "Mow lawn", labels: ["To do"]},
    {description: "Fix car", labels: ["To do"]},
    {description: "Fix fence", labels: ["Doing"]},
    {description: "Walk dog", labels: ["Doing"]},
    {description: "Read book", labels: ["Doing"]}
  ]

  ko.applyBindings( new ViewModel(tasks))