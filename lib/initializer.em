Em.onLoad 'Ember.Application', (application) ->
  application.initializer
    name: 'ember-auth.module.auth-redirectable'
    after: 'ember-auth'

    initialize: (container, app) ->
      app.register 'authModule:authRedirectable', \
      Em.Auth.AuthRedirectableAuthModule
