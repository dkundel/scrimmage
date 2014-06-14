'use strict'

angular.module('scrimmageApp')
  .controller 'FindCtrl', ($scope, $location, $http) ->

    $scope.back = () ->
      $location.path('/')
      event.stopPropagation()

    $scope.description = ''
    $scope.ranked = true
    $scope.single = true
    $scope.skill = 0
    $scope.racket = false
    $scope.balls = false
    $scope.terrain = ''
    $scope.radius = 5


    $scope.search = {}
    $scope.search.time = "foo"
    $scope.radioModel = 'Left'
    # $http.get('/api/awesomeThings').success (awesomeThings) ->
    #   $scope.awesomeThings = awesomeThings
