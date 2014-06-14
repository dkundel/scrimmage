'use strict'

angular.module('scrimmageApp')
  .controller 'FindCtrl', ($scope, $location, $http, Map) ->

    $scope.back = () ->
      $location.path('/')
      event.stopPropagation()

    $scope.description = ''
    $scope.ranked = true
    $scope.single = true
    $scope.skill = 0
    $scope.racket = false
    $scope.balls = false
    $scope.terrain = ''
    $scope.radius = 5


    $scope.search = {}
    $scope.search.time = "foo"
    $scope.radioModel = 'Left'
    # $http.get('/api/awesomeThings').success (awesomeThings) ->
    #   $scope.awesomeThings = awesomeThings


    $scope.addressResult = ''
    $scope.addressDetails = {}
    $scope.addressOptions = null

    Map.init 'googleMap',
      center: new google.maps.LatLng(-34.397, 150.644)
      zoom: 8

    # Map.getCurrentLocation()

    $scope.$watch () =>
      return $scope.addressDetails
    , (details) =>
      if details?.geometry?.location?
        $scope.geoLocation = new google.maps.LatLng details.geometry.location.k, details.geometry.location.A
        Map.markAndZoom $scope.geoLocation

    $scope.cancel = () =>
      $location.path('/create')
      event.stopPropagation()