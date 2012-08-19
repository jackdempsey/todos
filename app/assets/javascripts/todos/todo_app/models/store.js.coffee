((app) ->
  "use strict"
  Store = (name) ->
    @name = name
    store = localStorage.getItem(@name)
    @data = (store and JSON.parse(store)) or {}

    # Save the current state of the **Store** to *localStorage*.
    @save = -> localStorage.setItem @name, JSON.stringify(@data)

    # Wrapper around `this.create`
    # Creates a `Todo` model object out of the title
    @createFromTitle = (title) ->
      todo = app.Todo.create
        title: title
        store: this
      @create todo
      todo


    # Store the model inside the `Store`
    @create = (model) ->
      model.set "id", Date.now()  unless model.get("id")
      @update model


    # Update a model by replacing its copy in `this.data`.
    @update = (model) ->
      @data[model.get("id")] = model.getProperties("id", "title", "completed")
      @save()
      model


    # Retrieve a model from `this.data` by id.
    @find = (model) ->
      todo = app.Todo.create(@data[model.get("id")])
      todo.set "store", this
      todo


    # Return the array of all models currently in storage.
    @findAll = ->
      result = []
      for key of @data
        todo = app.Todo.create(@data[key])
        todo.set "store", this
        result.push todo
      result


    # Delete a model from `this.data`, returning it.
    @remove = (model) ->
      delete @data[model.get("id")]

      @save()
      model

    return

  app.Store = Store
)(window.Todos)
