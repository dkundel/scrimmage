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
  'ngRoute',
  'ngAutocomplete'
])
  .config ($routeProvider, $locationProvider) ->
    $routeProvider
      .when '/',
        templateUrl: 'partials/main'
        controller: 'MainCtrl'
      .when '/find',
        templateUrl: 'partials/find'
        controller: 'FindCtrl'
      .when '/create/location',
        templateUrl: 'partials/create-map'
        controller: 'CreateMapCtrl'
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
      .when '/event/:id/chat',
        templateUrl: 'partials/chat'
        controller: 'ChatCtrl'
      .when '/event/:id/overview',
        templateUrl: 'partials/overview'
        controller: 'OverviewCtrl'
      .otherwise
        redirectTo: '/'

    $locationProvider.html5Mode true

  .run ($rootScope, $location, $http, FBUser, PubNub, Event) ->

    $rootScope.$watch(() ->
      FBUser.loggedIn()
    , (status) ->
      $rootScope.userInfo = FBUser.getUser()
      $rootScope.loggedIn = status
      window.rootS = $rootScope
    )

    PubNub.init()

    window.fbAsyncInit = () ->
      FB.init {
        appId      : '1559501997610150',
        xfbml      : true,
        version    : 'v2.0'
      }
      FBUser.watchAuthChange()
      FBUser.checkLogIn()
