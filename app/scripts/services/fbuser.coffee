'use strict'

angular.module('scrimmageApp')
  .service 'FBUser', ($rootScope, Event, PubNub) ->
    # AngularJS will instantiate a singleton by calling "new" on this function
    user = {}
    loggedIn = false

    self = @

    @applyChanges = () =>
      $rootScope.$apply () =>
        $rootScope.loggedIn = loggedIn
        $rootScope.userInfo = user
        window.FBUser = user
        Event.registerListeners()

    @getUser = () =>
      user

    @loggedIn = () =>
      loggedIn

    @fetchUser = () =>
      FB.api 'me', (response) =>
        user = response
        loggedIn = true
        @applyChanges()
        message = 
          user:
            id: response.id
            name: response.name
            first_name: response.first_name
          type: 'connect_client'

        PubNub.publish 'client', message

    @watchAuthChange = () =>
      FB.Event.subscribe 'auth.authResponseChange', (response) =>
        if response.status is 'connected'
          @fetchUser()
        else 
          loggedIn = false

    @logout = () =>
      FB.logout (response) =>
        user = {}
        loggedIn = false

    @login = () =>
      FB.login()

    @checkLogIn = () =>
      FB.getLoginStatus (response) =>
        if response.status is 'connected'
          @fetchUser()
        else
          loggedIn = false

    return