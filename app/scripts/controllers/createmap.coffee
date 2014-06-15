'use strict'

angular.module('scrimmageApp')
  .controller 'CreateMapCtrl', ($scope, $location, $http, Map, Event) ->
    $scope.addressResult = ''
    $scope.addressDetails = {}
    $scope.addressOptions = null
    dateNow = new Date()
    $scope.time = dateNow.getHours() + ':' + dateNow.getMinutes()
    $scope.date = (dateNow.getMonth() + 1) + '/' + (dateNow.getDate()) + '/' + (dateNow.getFullYear())

    Map.init 'googleMap',
#      center: new google.maps.LatLng(51.509, -0.125) --> doesn't show something before location has loaded
      zoom: 8

    Map.getCurrentLocation()

    $scope.$watch () =>
      return $scope.addressDetails
    , (details) =>
      if details?.geometry?.location?
        $scope.geoLocation = new google.maps.LatLng details.geometry.location.k, details.geometry.location.A
        Map.markAndZoom $scope.geoLocation

    $scope.cancel = () =>
      $location.path('/create')
      event.stopPropagation()

    $scope.next = () =>
      Event.submitEvent
        location:
          lat: $scope.addressDetails.geometry.location.k
          long: $scope.addressDetails.geometry.location.A
          address: $scope.addressDetails.formatted_address
        time: $scope.time
        date: $scope.date

    $scope.home = () =>
      $location.path('/')
      event.stopPropagation()
