Em.onLoad 'Ember.Application', (application) ->
  application.initializer
    name: 'ember-auth.module.auth-redirectable'
    before: 'ember-auth-load'

    initialize: (container, app) ->
      app.register 'authModule:authRedirectable', \
      Em.Auth.AuthRedirectableAuthModule
      app.inject 'authModule:authRedirectable', 'auth', 'auth:main'
