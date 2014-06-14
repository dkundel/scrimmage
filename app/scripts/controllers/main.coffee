'use strict'

angular.module('scrimmageApp')
  .controller 'MainCtrl', ($scope, $location, $http, FBUser, Map) ->

    profileHidden = false

    Map.init 'googleMap',
      center: new google.maps.LatLng(-34.397, 150.644)
      zoom: 8

    Map.getEvents()

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
      console.log '??'
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
    
    # $http.get('/api/awesomeThings').success (awesomeThings) ->
    #   $scope.awesomeThings = awesomeThings