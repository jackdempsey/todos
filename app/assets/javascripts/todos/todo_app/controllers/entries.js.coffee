((app) ->
  'use strict'

  Entries = Ember.ArrayProxy.extend
    store: new app.Store app.storeNamespace
    content: []

    createNew: (value) ->
      return unless value.trim()
      todo = @get( 'store' ).createFromTitle value
      @pushObject todo

    pushObject: (item, ignoreStorage) ->
      unless ignoreStorage
        @get( 'store' ).create item
      @_super item

    removeObject: (item) ->
      @get( 'store' ).remove item
      @_super item

    clearCompleted: ->
      @filterProperty(
        'completed', true
      ).forEach( @removeObject, this )

    total: (->
      @get( 'length' )
    ).property '@each.length'

    remaining: ( ->
      @filterProperty( 'completed', false ).get 'length'
    ).property '@each.completed'

    completed: (->
      return @filterProperty( 'completed', true ).get( 'length' )
    ).property '@each.completed'

    noneLeft: (->
      @get( 'total' ) is 0
    ).property 'total'

    allAreDone: ((key, value) ->
      if value?
        @setEach 'completed', value
        value
      else
        !!@get( 'length' ) and @everyProperty( 'completed', true )
    ).property '@each.completed'

    init: ->
      @_super()
      # Load items if any upon initialization
      items = @get( 'store' ).findAll()
      if items.get 'length'
        @set '[]', items

  app.EntriesController = Entries
  app.entriesController = Entries.create()


)(window.Todos)
