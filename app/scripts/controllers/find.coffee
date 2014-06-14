'use strict'

angular.module('scrimmageApp')
  .controller 'FindCtrl', ($scope, $http) ->
    $scope.search = {}
    $scope.search.time = "foo"
    $scope.radioModel = 'Left'
    # $http.get('/api/awesomeThings').success (awesomeThings) ->
    #   $scope.awesomeThings = awesomeThings