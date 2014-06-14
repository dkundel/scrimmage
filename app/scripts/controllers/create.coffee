'use strict'

angular.module('scrimmageApp')
  .controller 'CreateCtrl', ($scope, $http) ->
    $http.get('/api/awesomeThings').success (awesomeThings) ->
      $scope.awesomeThings = awesomeThings