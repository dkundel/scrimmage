'use strict'

angular.module('scrimmageApp')
  .controller 'ProfileCtrl', ($scope, $http) ->
    $http.get('/api/awesomeThings').success (awesomeThings) ->
      $scope.awesomeThings = awesomeThings