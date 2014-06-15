'use strict'

angular.module('scrimmageApp')
  .controller 'FindCtrl', ($scope, $rootScope, $location, $http, Map, Event) ->

    $scope.back = () ->
      $location.path('/')
      event.stopPropagation()

    $scope.search = {}
    # $scope.search.description = ''
    $scope.search.ranked = null
    $scope.search.single = null
    $scope.search.date = null
    $scope.search.time = null
    $scope.search.skill = 2
    # $scope.search.racket = false
    # $scope.search.balls = false
    $scope.search.terrain = ''
    $scope.search.position = null
    $scope.search.radius = 5

    # $http.get('/api/awesomeThings').success (awesomeThings) ->
    #   $scope.awesomeThings = awesomeThings


    $scope.search.addressResult = ''
    $scope.search.addressDetails = {}
    $scope.search.addressOptions = null

    oldSearch = JSON.parse(JSON.stringify($scope.search))

    Map.init 'googleMap',
      center: new google.maps.LatLng(51.509, -0.125)
      zoom: 8

    # Map.getCurrentLocation()

    $scope.$watch () =>
      return $scope.addressDetails
    , (details) =>
      if details?.geometry?.location?
        $scope.search.position = 
          lat: details.geometry.location.k
          long: details.geometry.location.A
          address: details.formatted_address
        # $scope.geoLocation = new google.maps.LatLng details.geometry.location.k, details.geometry.location.A
        # Map.markAndZoom $scope.geoLocation

    $scope.$watch () =>
      changed = false
      changed = true unless $scope.search.ranked is oldSearch.ranked
      changed = true unless $scope.search.single is oldSearch.single
      changed = true unless $scope.search.date is oldSearch.date
      changed = true unless $scope.search.time is oldSearch.time
      changed = true unless $scope.search.skill is oldSearch.skill
      changed = true unless $scope.search.terrain is oldSearch.terrain
      changed = true unless $scope.search.position?.lat is oldSearch.position?.lat
      changed = true unless $scope.search.position?.long is oldSearch.position?.long
      changed = true unless $scope.search.radius is oldSearch.radius
      oldSearch = JSON.parse(JSON.stringify($scope.search))
      return changed
    , (search) =>
      $scope.updateSearch()

    $scope.$watch () -> 
      return $rootScope.eventList
    , (eventList) ->
      if eventList?
        console.log eventList
        Map.showEvents eventList

    $scope.home = () =>
      $location.path('/')
      event.stopPropagation()

    $scope.cancel = () =>
      $location.path('/create')
      event.stopPropagation()

    $scope.toggleTerrain = (color) =>
      $scope.search.terrain = color
      event.stopPropagation()

    $scope.updateSearch = () =>
      search = {}
      if $scope.search.ranked?
        search.gameType = if $scope.search.ranked then 'R' else 'C'
      if $scope.search.single?
        search.userType = if $scope.search.single then 'S' else 'D'
      if $scope.search.terrain.length > 0
        search.fieldType = $scope.search.terrain[0].toUpperCase()
      search.skillLevel = 
        $lte: $scope.search.skill
      if $scope.search.date?
        search.date = $scope.search.date
      if $scope.search.time?
        search.date = $scope.search.time
      if $scope.search.position
        search.position = $scope.search.position
      if $scope.search.radius
        search.radius = $scope.search.radius

      Event.updateSearch search

    $scope.getCurrentPosition = () =>
      Map.getCurrentLocation (resp) =>
        $scope.search.position = 
          lat: resp.coords.latitude
          long: resp.coords.longitude

      event.stopPropagation()