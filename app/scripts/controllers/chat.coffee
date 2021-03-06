'use strict'

angular.module('scrimmageApp')
  .controller 'ChatCtrl', ($scope, $rootScope, $location, $routeParams, $http, Event, PubNub) ->
    $scope.id = $routeParams.id
    colorMatch = {}
    # Event.fetchInfo $scope.id

    $scope.$watch () -> 
      return $rootScope.eventInfo
    , (eventInfo) ->
      if eventInfo?
        console.log eventInfo
        $scope.messages = eventInfo.messages
        $scope.participants = eventInfo.users
        for p, i in $scope.participants
            colorMatch[p.id] = 'red' if i is 0
            colorMatch[p.id] = 'blue' if i is 1
            colorMatch[p.id] = 'green' if i is 2
            colorMatch[p.id] = 'purple' if i is 3

        for m in $scope.messages
            m.color = colorMatch[m.user.id]


    $rootScope.$watch () ->
      return $rootScope.loggedIn
    , (loggedIn) ->
      if loggedIn
        Event.fetchInfo $scope.id


    $scope.home = () =>
      $location.path('/')
      event.stopPropagation()

    # $scope.messages = [
    #   user:
    #     id: 898122570204099
    #     first_name: 'Dominik'
    #   content: 'Fooo'
    # ,
    #   user:
    #     id: 898122570204099
    #     first_name: 'Dominik'
    #   content: 'Fooo'
    # ,
    #   user:
    #     id: 898122570204099
    #     first_name: 'Dominik'
    #   content: 'Fooo'
    # ,
    #   user:
    #     id: 898122570204099
    #     first_name: 'Dominik'
    #   content: 'Fooo'
    # ]

    # $scope.participants = [
    #   id: 898122570204099
    #   first_name: 'Dominik'
    # ,
    #   id: 898122570204099
    #   first_name: 'Dominik'
    # ,
    #   id: 898122570204099
    #   first_name: 'Dominik'
    # ,
    #   id: 898122570204099
    #   first_name: 'Dominik'
    # ]

    # $scope.participants = [
    #   id: 898122570204099
    #   first_name: 'Dominik'
    # ,
    #   id: 898122570204099
    #   first_name: 'Dominik'
    # ]

    newMessageChannel = 'server/chat/'+$scope.id
    # console.log newMessageChannel
    console.log newMessageChannel
    PubNub.subscribe newMessageChannel, (m) =>
      $scope.$apply () =>
        m.color = colorMatch[m.user.id]
        $scope.messages.push m

    $scope.sendMsg = () =>
      console.log 'msg', $scope.newMessage
      msg =
        type: 'send_message'
        session: $scope.id
        data: 
          user:
            first_name: $rootScope.userInfo.first_name
            id: $rootScope.userInfo.id
          content: $scope.newMessage

      PubNub.publish 'client', msg
      $scope.newMessage = ''