'use strict'

angular.module('scrimmageApp')
  .controller 'ManageCtrl', ($scope, $http) ->
    $http.get('/api/awesomeThings').success (awesomeThings) ->
      $scope.awesomeThings = awesomeThings