'use strict'

angular.module('scrimmageApp')
  .controller 'CreateCtrl', ($scope, $location, $http, FBUser, Map) ->
    