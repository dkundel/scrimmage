'use strict'

angular.module('scrimmageApp')
  .service 'Event', ($rootScope, $location, PubNub) ->
    tempInfo = {}
    eventInfo = {}
    eventList = []

    @registerListeners = () =>
      PubNub.subscribe 'server/create_session/' + $rootScope.userInfo.id, (msg) =>
        $location.path '/event/'+msg.id+'/chat'
        window.scrollTo 0,0

      PubNub.subscribe 'server/receive_session/' + $rootScope.userInfo.id, (msg) =>
        unless msg.session?
          $location.path '/'
          window.scrollTo 0,0
        $rootScope.$apply () ->
          $rootScope.eventInfo = transformBack(msg.session)
          console.log msg.session

      PubNub.subscribe 'server/receive_session/' + $rootScope.userInfo.id + '/joined', (msg) =>
        unless msg.session?
          $location.path '/'
          window.scrollTo 0,0
        $rootScope.$apply () ->
          $location.path '/event/' + msg.session._id + '/chat'



    @getInfo = () =>
      eventInfo

    @fetchAllSessions = () =>
      console.log '???'
      PubNub.subscribe 'server/get_open_sessions', (msg) =>
          $rootScope.$apply () ->
            eventList = $rootScope.eventList = msg.sessions
      
      setTimeout () =>
        console.log '??'
        message = 
          type: 'get_open_sessions'

        PubNub.publish 'client', message
      , 1000


    @getList = () =>
      eventList


    @fetchInfo = (id) =>
      # channel = 'server/receive_session/898122570204099'
      # channel = 'server/receive_session/' + $rootScope.userInfo.id

      setTimeout () ->
        message = 
          type: 'get_session'
          user: 
            id: $rootScope.userInfo.id
          session: id

        PubNub.publish 'client', message
      , 1000

    transformData = () =>
      eventData = 
        description: tempInfo.description
        userType: if tempInfo.single then 'S' else 'D'
        gameType: if tempInfo.ranked then 'R' else 'C'
        fieldType: tempInfo.terrain[0].toUpperCase()
        skillLevel: tempInfo.skill
        racket: tempInfo.racket
        balls: tempInfo.balls
        date: tempInfo.date
        time: tempInfo.time
        location: tempInfo.location

    transformBack = (msg) =>
      unless msg?
        return {}
      clientData = 
        description: msg.description
        single: msg.userType is 'S'
        ranked: msg.gameType is 'R'
        terrain: if msg.fieldType is 'H' then 'hard' else (if msg.fieldType is 'C' then 'clay' else 'grass')
        skill: msg.skillLevel
        racket: msg.racket
        balls: msg.balls
        date: msg.date
        time: msg.time
        location: msg.location
        messages: msg.messages
        users: msg.users


    @setTemp = (tmp) =>
      tempInfo = tmp


    @submitEvent = (moreInfo) =>
      tempInfo.location = moreInfo.location
      tempInfo.time = moreInfo.time
      tempInfo.date = moreInfo.date

      eventData = transformData()

      message = 
        session: eventData
        type: 'create_session'
        user: 
          id: $rootScope.userInfo.id
          first_name: $rootScope.userInfo.first_name
          name: $rootScope.userInfo.name

      PubNub.publish 'client', message

      # $location.path '/event/1/chat'
      # window.scrollTo 0, 0
    # AngularJS will instantiate a singleton by calling "new" on this function

    @join = (id) =>
      console.log 'Join Event'
      message = 
        type: 'join_session'
        user: 
          id: $rootScope.userInfo.id
          first_name: $rootScope.userInfo.first_name
          name: $rootScope.userInfo.name
        session: id

      PubNub.publish 'client', message

    return