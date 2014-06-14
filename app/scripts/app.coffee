'use strict'

window.fbAsyncInit = () ->
  FB.init {
    appId      : '1559501997610150',
    xfbml      : true,
    version    : 'v2.0'
  }

angular.module('scrimmageApp', [
  'ngCookies',
  'ngResource',
  'ngSanitize',
  'ngRoute'
])
  .config ($routeProvider, $locationProvider) ->
    $routeProvider
      .when '/',
        templateUrl: 'partials/main'
        controller: 'MainCtrl'
      
      .otherwise
        redirectTo: '/'

    $locationProvider.html5Mode true

  .run ($rootScope, $location, $http, FBUser) ->

    $rootScope.$watch(() -> 
      FBUser.loggedIn()
    , (status) ->
      $rootScope.userInfo = FBUser.getUser()
      $rootScope.loggedIn = status
      window.rootS = $rootScope
    )


    window.fbAsyncInit = () ->
      FB.init {
        appId      : '1559501997610150',
        xfbml      : true,
        version    : 'v2.0'
      }
      FBUser.watchAuthChange()
      FBUser.checkLogIn()