'use strict'

angular.module('scrimmageApp')
  .controller 'MainCtrl', ($scope, $rootScope, $location, $http, FBUser, Map, Event) ->

    profileHidden = false

    Map.init 'googleMap',
#      center: new google.maps.LatLng(51.509, -0.125)
      zoom: 8

    Map.getCurrentLocation()

    $rootScope.$watch () ->
      return $rootScope.loggedIn
    , (loggedIn) ->
      if loggedIn
        console.log '!!!!'
        Event.fetchAllSessions()

    $scope.$watch () ->
      return $rootScope.eventList
    , (eventList) ->
      if eventList?
        console.log eventList
        Map.showEvents eventList

    $scope.logIn = () ->
      FBUser.login()
      event.stopPropagation()

    $scope.logOut = () ->
      FBUser.logout()
      event.stopPropagation()

    $scope.create = () ->
      $location.path('/create')
      event.stopPropagation()

    $scope.search = () ->
      $location.path('/find')
      event.stopPropagation()

    $scope.hide = () ->
      $scope.profileHidden = true;
      event.stopPropagation()

    $scope.show = () ->
      $scope.profileHidden = false;
      event.stopPropagation()

    $scope.league = () ->
      $location.path('/league')
      event.stopPropagation()

    $scope.home = () =>
      $location.path('/')
      event.stopPropagation()

    # $http.get('/api/awesomeThings').success (awesomeThings) ->
    #   $scope.awesomeThings = awesomeThings