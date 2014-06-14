'use strict'

angular.module('scrimmageApp')
  .controller 'ChatCtrl', ($scope, $rootScope, $routeParams, $http, PubNub) ->
    $scope.id = $routeParams.id

    $scope.messages = [
      user:
        id: 898122570204099
        first_name: 'Dominik'
      content: 'Fooo'
    ,
      user:
        id: 898122570204099
        first_name: 'Dominik'
      content: 'Fooo'
    ,
      user:
        id: 898122570204099
        first_name: 'Dominik'
      content: 'Fooo'
    ,
      user:
        id: 898122570204099
        first_name: 'Dominik'
      content: 'Fooo'
    ]

    $scope.participants = [
      id: 898122570204099
      first_name: 'Dominik'
    ,
      id: 898122570204099
      first_name: 'Dominik'
    , 
      id: 898122570204099
      first_name: 'Dominik'
    ,
      id: 898122570204099
      first_name: 'Dominik'
    ]

    # $scope.participants = [
    #   id: 898122570204099
    #   first_name: 'Dominik'
    # ,
    #   id: 898122570204099
    #   first_name: 'Dominik'
    # ]

    newMessageChannel = 'update_message_'+$scope.id
    # console.log newMessageChannel
    PubNub.subscribe newMessageChannel, (m) =>
      $scope.$apply () =>
        $scope.messages.push m

    $scope.sendMsg = () =>
      console.log 'msg', $scope.newMessage
      msg = 
        user: 
          first_name: $rootScope.userInfo.first_name
          id: $rootScope.userInfo.id
        content: $scope.newMessage
      PubNub.publish 'update_message_'+$scope.id, msg
      $scope.newMessage = ''