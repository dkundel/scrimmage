'use strict'

angular.module('scrimmageApp')
  .controller 'OverviewCtrl', ($scope, $http) ->
    $http.get('/api/awesomeThings').success (awesomeThings) ->
      $scope.awesomeThings = awesomeThings