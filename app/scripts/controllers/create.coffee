'use strict'

angular.module('scrimmageApp')
  .controller 'CreateCtrl', ($scope, $location, $http, FBUser, Map, Event) ->
    $scope.description = ''
    $scope.ranked = false
    $scope.single = true
    $scope.skill = 0
    $scope.racket = false
    $scope.balls = false
    $scope.terrain = 'clay'

    $scope.next = () =>
      Event.setTemp
        description: $scope.description
        ranked: $scope.ranked
        single: $scope.single
        skill: $scope.skill
        racket: $scope.racket
        balls: $scope.balls
        terrain: $scope.terrain
      $location.path('/create/location')

    $scope.cancel = () =>
      $location.path('/')

    $scope.toggleTerrain = (color) =>
      $scope.terrain = color
      event.stopPropagation()

    $scope.home = () =>
      $location.path('/')
      event.stopPropagation()