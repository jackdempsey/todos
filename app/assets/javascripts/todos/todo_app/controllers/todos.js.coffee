((app) ->
  'use strict'

  TodosController = Ember.Controller.extend
    entries: (->
      filter = @getPath 'content.filterBy'

      if Ember.empty filter
        return @get 'content'

      if !Ember.compare filter, 'completed'
        return @get( 'content' ).filterProperty 'completed', true

      if !Ember.compare filter, 'active'
        return @get( 'content' ).filterProperty 'completed', false

    ).property 'content.remaining', 'content.filterBy'

  app.TodosController = TodosController

)(window.Todos)
