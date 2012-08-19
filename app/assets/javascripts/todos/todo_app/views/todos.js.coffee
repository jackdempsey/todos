((app) ->
  'use strict'

  TodosView = Ember.CollectionView.extend
    contentBinding: 'controller.entries'
    tagName: 'ul'
    elementId: 'todo-list'
    itemViewClass: Ember.View.extend
      templateName: 'todosTemplate'
      classNames: [ 'view' ]
      classNameBindings: ['content.completed', 'content.editing']
      doubleClick: -> @get( 'content' ).set( 'editing', true )
      removeItem: -> @getPath( 'controller.content' ).removeObject @get('content')
      ItemEditorView: Ember.TextField.extend
        valueBinding: 'content.title'
        classNames: [ 'edit' ]
        change: ->
          if Ember.empty @getPath('content.title')
            @getPath( 'controller.content' ).removeObject @get('content')
          else
            @get('content').set('title', @getPath('content.title').trim())

        whenDone: -> @get( 'content' ).set 'editing', false
        focusOut: -> @whenDone()
        didInsertElement: -> @$().focus()
        insertNewline: -> @whenDone()

  app.TodosView = TodosView

)(window.Todos)
