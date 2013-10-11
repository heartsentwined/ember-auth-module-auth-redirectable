class Em.Auth.AuthRedirectableAuthModule
  init: ->
    @auth._config 'authRedirectable', @_defaultConfig
    @config? || (@config = @auth._config 'authRedirectable')

    # register an authAccess handler type
    @auth._handlers.authAccess = []

    @patch()

  _defaultConfig:
    # [string] route name to redirect to when accessing a protected route
    #   without a signed in session
    route: null

  patch: ->
    self = this
    Em.Route.reopen
      beforeModel: (queryParams, transition) ->
        ret = super.apply this, arguments
        return ret if self.auth.signedIn || !@authRedirectable

        transition = queryParams unless transition?

        promises = []
        for handler in self.auth._handlers.authAccess
          promises.push handler(transition)

        if typeof ret.then == 'function'
          ret.then =>
            Em.RSVP.all(promises).then => @transitionTo self.config.route
        else
          Em.RSVP.all(promises).then => @transitionTo self.config.route
