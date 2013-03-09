class Tasks
  items: []

  load: ->
    json = localStorage.getItem @storeKey()
    @items = JSON.parse json if json

  save: ->
    json = JSON.stringify @items
    localStorage.setItem @storeKey(), json

  storeKey: ->
    date = new Date
    "tasks-#{date.toISOString().substring 0, 10}"

  clear: ->
    @items = []
    json = localStorage.getItem @storeKey()

  get: (index) -> @items[index]
  add: (task) ->
    index = @items.length
    @items.push task
    @save()
    @renderTask task, index
    @focusOn index


  renderIn: (list) ->
    @list = list
    @list.empty()
    for task, index in @items
      @renderTask task, index

  render: -> @renderIn @list if @list

  renderTask: (task, index) ->
    unless task.title.trim() is ""
      @list.prepend """
        <div class="row task #{if task.completed then "completed" else ""}"
          data-index="#{index}">
          <input type="checkbox" #{if task.completed then "checked" else ""}>
          <input type="text" value="#{task.title}">
        </div>
        """

  focusOn: (index) ->
    focusOnTask = ->
      $(".task[data-index='#{index}'] input[type='text']").focus()
    setTimeout focusOnTask, 1 # new thread

$ -> # Init app
  IS_MOBILE = $.os.ios || $.os.android
  TAP = if IS_MOBILE then 'tap' else 'click'

  tasks = new Tasks
  tasks.load()

  list = $ '.list'
  tasks.renderIn list
  listResize = -> list.css 'height', $(window).height()-47 # list.top
  setTimeout listResize, 100

  button = $ '.navbar .button'
  button.on 'touchStart', -> $(this).addClass 'tap'
  button.on TAP, ->
   $(this).removeClass 'tap'
   tasks.add title:'New task'

  getTaskIndexOf = (el) ->
    el.closest('.task').attr 'data-index'

  list.on 'keyup', 'input[type=text]', (e) ->
    if e.keyCode == 13 then $(this).blur()

  list.on 'change', 'input[type=text]', ->
    input = $ this
    index = getTaskIndexOf input
    task = tasks.get index
    task.title = input.val()
    tasks.save()
    tasks.render() if task.title.trim() is ""

  list.on 'change', 'input[type=checkbox]', ->
    checkbox = $ this
    taskEl = checkbox.closest '.task'
    index = getTaskIndexOf checkbox
    task = tasks.get index
    task.completed = checkbox.attr 'checked'
    tasks.save()
    if task.completed
      taskEl.addClass 'completed'
    else
      taskEl.removeClass 'completed'

