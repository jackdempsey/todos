((app) ->
  "use strict"
  Router = Ember.Router.extend(root: Ember.Route.extend(
    showAll: Ember.Route.transitionTo("index")
    showActive: Ember.Route.transitionTo("active")
    showCompleted: Ember.Route.transitionTo("completed")
    index: Ember.Route.extend(
      route: "/"
      connectOutlets: (router) ->
        controller = router.get("applicationController")
        context = app.entriesController
        context.set "filterBy", ""
        controller.connectOutlet "todos", context
    )
    active: Ember.Route.extend(
      route: "/active"
      connectOutlets: (router) ->
        controller = router.get("applicationController")
        context = app.entriesController
        context.set "filterBy", "active"
        controller.connectOutlet "todos", context
    )
    completed: Ember.Route.extend(
      route: "/completed"
      connectOutlets: (router) ->
        controller = router.get("applicationController")
        context = app.entriesController
        context.set "filterBy", "completed"
        controller.connectOutlet "todos", context
    )
    specs: Ember.Route.extend(
      route: "/specs"
      connectOutlets: ->
    )
  ))

  # TODO: Write them
  app.Router = Router
)( window.Todos )
