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
      .when '/find',
        templateUrl: 'partials/find'
        controller: 'FindCtrl'
      .when '/create',
        templateUrl: 'partials/create'
        controller: 'CreateCtrl'
      .when '/manage',
        templateUrl: 'partials/manage'
        controller: 'ManageCtrl'
      .when '/league',
        templateUrl: 'partials/league'
        controller: 'LeagueCtrl'
      .when '/profile',
        templateUrl: 'partials/profile'
        controller: 'ProfileCtrl'
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
