'use strict'

angular.module('scrimmageApp')
  .controller 'LeagueCtrl', ($scope, $rootScope, $location, $http, PubNub) ->
    $scope.back = () ->
      $location.path('/')
      event.stopPropagation()
    $scope.User1 = "Naomi Pentrel"
    $scope.Points = 10000

    # $scope.users = [
    #   name: "Naomi Pentrel1"
    #   points: 2323
    #   place: 1
    # ,
    #   name: "Naomi Pentrel2"
    #   points: 23232
    #   place: 2
    # ,
    #   name: "Naomi Pentrel3"
    #   points: 23232
    #   place: 3
    # ,
    #   name: "Naomi Pentrel4"
    #   points: 232332
    #   place: 4
    # ,
    #   name: "Naomi Pentrel5"
    #   points: 232322
    #   place: 5
    # ,
    #   name: "Naomi Pentrel7"
    #   points: 232324
    #   place: 6
    # ,
    #   name: "Naomi Pentrel6"
    #   points: 232326
    #   place: 7
    # ,
    #   name: "Naomi Pentrel9"
    #   points: 23232
    #   place: 8
    # ,
    #   name: "Naomi Pentrel8"
    #   points: 23232
    #   place: 9
    # ,
    #   name: "Dominik Kundel"
    #   points: 23232
    #   place: 10
    # ]



    # $scope.$watch () -> 
    #   return $rootScope.eventInfo
    # , (eventInfo) ->
    #   if eventInfo?
    #     console.log eventInfo
    #     $scope.messages = eventInfo.messages
    #     $scope.participants = eventInfo.users
    #     for p, i in $scope.participants
    #         colorMatch[p.id] = 'red' if i is 0
    #         colorMatch[p.id] = 'blue' if i is 1
    #         colorMatch[p.id] = 'green' if i is 2
    #         colorMatch[p.id] = 'purple' if i is 3

    #     for m in $scope.messages
    #         m.color = colorMatch[m.user.id]


    $rootScope.$watch () ->
      return $rootScope.loggedIn
    , (loggedIn) ->
      if loggedIn
        PubNub.subscribe 'server/get_league_statistics/' + $rootScope.userInfo.id, (msg) ->
          $scope.$apply () ->
            console.log 'RECEIVED'
            $scope.users = msg.users

        setTimeout () ->
          PubNub.publish 'client', 
            type: 'get_league_statistics'
            user: 
              id: $rootScope.userInfo.id
        , 1000

    $scope.home = () =>
      $location.path('/')
      event.stopPropagation()

      #    $http.get('/api/awesomeThings').success (awesomeThings) ->
  #      $scope.awesomeThings = awesomeThings
