'use strict'

angular.module('scrimmageApp')
  .controller 'CreateMapCtrl', ($scope, $location, $http, Map) ->
    $scope.addressResult = ''
    $scope.addressDetails = {}
    $scope.addressOptions = null

    Map.init 'googleMap',
      center: new google.maps.LatLng(51.509, -0.125)
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