'use strict'

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