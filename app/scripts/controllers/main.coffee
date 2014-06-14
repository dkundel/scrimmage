'use strict'

angular.module('scrimmageApp')
  .controller 'MainCtrl', ($scope, $http, Map) ->

    Map.init 'googleMap',
      center: new google.maps.LatLng(-34.397, 150.644)
      zoom: 8
    # $http.get('/api/awesomeThings').success (awesomeThings) ->
    #   $scope.awesomeThings = awesomeThings