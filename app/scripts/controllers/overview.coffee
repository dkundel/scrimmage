'use strict'

angular.module('scrimmageApp')
  .controller 'OverviewCtrl', ($scope, $location, $routeParams, $http, Event) ->
    $scope.id = $routeParams.id

    $scope.event =
      location:
        lat: 12.1
        long: 12.1
        address: "Something Really, Long, 2244, Awesome Town"
      time: "22:22 PM"
      date: "22/22/2222"
      description: "Blablabla"
      ranked: true
      single: false
      balls: false
      racket: true
      terrain: 'clay'
      organizer:
        id: 898122570204099
        name: 'Dominik Kundel'
        first_name: 'Dominik'

    $scope.back = () =>
      window.scrollTo(0,0)
      $location.path '/'

    $scope.home = () =>
      $location.path('/')
      event.stopPropagation()

    $scope.join = () =>
      Event.join $scope.id
