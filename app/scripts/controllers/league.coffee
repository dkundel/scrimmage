'use strict'

angular.module('scrimmageApp')
  .controller 'Leaguetrl', ($scope, $http) ->
    $http.get('/api/awesomeThings').success (awesomeThings) ->
      $scope.awesomeThings = awesomeThings