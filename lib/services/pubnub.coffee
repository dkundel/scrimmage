Session = require('../models/sessions')
User = require('../models/users')

pubnub = require('pubnub').init(
  publish_key: 'pub-c-b4096ce5-10e7-4674-9cbc-7f1393edf2be'
  subscribe_key: 'sub-c-fafce722-f3bb-11e3-b429-02ee2ddab7fe'
)

channel_client = 'client'
channel_server = 'server'

msg_create_session =          'create_session'
msg_edit_session =            'edit_session'
msg_connect_client =          'connect_client'
msg_get_sessions =            'get_sessions'
msg_get_open_sessions =       'get_open_sessions'
msg_join_session =            'join_session'
msg_get_session =             'get_session'
msg_leave_session =           'leave_session'
msg_remove_user =             'remove_user'
msg_session_cancelled =       'session_cancelled'
msg_kicked_from_session =     'kicked_from_session'
msg_send_message =            'send_message'
msg_receive_message =         'receive_message'
msg_receive_session =         'receive_session'
msg_get_user_info =           'get_user_info'
msg_get_league_statistics =   'get_league_statistics'

# --------------------------------------------------------------------------
# Error Handling Functions
# -------------------------------------------------------------------------- 
SentSuccessful = (e) ->
  console.log 'SUCCESS!', e

SentError = (e) ->
  console.log 'FAILED! RETRY PUBLISH!', e

ServerError = (e) ->
  # handleError e
  console.log 'FAILED!', e

# --------------------------------------------------------------------------
# Help Functions
# --------------------------------------------------------------------------
IsFull = (type, size) ->
  (type is 'S' and size is 2) or (type is 'D' and size is 4)

GetRandomStatistic = () ->
  max = 42
  min = -13
  Math.random() * (max - min) + min

# --------------------------------------------------------------------------
# Message Template
# --------------------------------------------------------------------------
# { type: 'type', user: 'facebook_id', ... }
# OR
# { type: 'type', session: 'session__id', user: 'facebook_id', ... }

# --------------------------------------------------------------------------
# Client Events
# -------------------------------------------------------------------------- 
pubnub.subscribe
  channel: channel_client
  callback: (message) ->
    switch message.type
      when msg_create_session then do ->
        # console.log 'session', message.session
        Session.create message.session,(err, session) ->
          if err
            ServerError err
          else
            session.admin = message.user.id
            session.users.push message.user
            console.log 'users', session.users
            session.save (err) ->
              console.log err
              # console.log '???'
              pubnub.publish
                channel: channel_server + '/' + msg_create_session + '/' + message.user.id
                message:
                  id: session._id.toString()


      when msg_edit_session then do ->
        Session.findOneAndUpdate
          _id: message.session._id
          message.session

      when msg_connect_client then do ->
        User.update
          _id: message.user, _id: message.user, upsert: true, (err, user) ->
            #hackstrong‬
            if err
              ServerError err
            else
              user.statistics.won = GetRandomStatistic()
              user.statistics.tied = GetRandomStatistic()
              user.statistics.lost = GetRandomStatistic()
              user.save

      when msg_get_sessions then do ->
        currentLocation = message.data.settings.position
        radius = message.data.settings.radius
        delete message.data.settings.position
        delete message.data.settings.radius
        Session.find message.data.settings, (err, sessions) ->
          if err
            ServerError err
          else
            open_sessions = sessions.filter (session) ->
              not IsFull session.userType, session.users.length
            if currentLocation?.lat and currentLocation?.long
              console.log '???'
              filteredByDistance = open_sessions.filter (session) ->
                x = (session.location.long - currentLocation.long) * Math.cos ((session.location.lat + currentLocation.lat)/2)
                y = (session.location.lat - currentLocation.lat)
                d = Math.sqrt (Math.pow(x, 2) + Math.pow(y, 2)) * 6731 * 1.60934
                return d <= radius
            else
              filteredByDistance = open_sessions

            pubnub.publish
              channel: channel_server + '/' + msg_get_open_sessions
              message:
                user: message.user
                type: msg_get_open_sessions
                sessions: filteredByDistance
              callback: SentSuccessful
              error: SentError

      when msg_get_open_sessions then do ->
        Session.find {}, (err, sessions) ->
          if err
            ServerError err
          else
            console.log sessions
            open_sessions = sessions.filter (session) ->
              not IsFull session.userType, session.users.length
            console.log open_sessions
            pubnub.publish
              channel: channel_server + '/' + msg_get_open_sessions
              message:
                user: message.user
                type: msg_get_open_sessions
                sessions: open_sessions
              callback: SentSuccessful
              error: SentError

      when msg_join_session then do ->
        Session.findById message.session, (err, session) ->
          if err
            ServerError err
          else
            if IsFull session.userType, session.users.length
              pubnub.publish
                channel: channel_server + '/' + msg_receive_session + '/' + message.user.id + '/joined'
                message:
                  user: message.user
                  session: null
                  type: msg_receive_session
                  messages: session
                callback: SentSuccessful
                error: SentError
            else
              session.users.push message.user
              session.save (err) ->
                console.log err
                pubnub.publish
                  channel: channel_server + '/' + msg_receive_session + '/' + message.user.id + '/joined'
                  message:
                    user: message.user
                    session: session
                    type: msg_receive_session
                    messages: session
                  callback: SentSuccessful
                  error: SentError

      when msg_get_session then do ->
        Session.findById message.session, (err, session) ->
          if err
            ServerError err
          else
            channelname = channel_server + '/' + msg_receive_session + '/' + message.user.id
            console.log channelname
            pubnub.publish
              channel: channelname
              message:
                user: message.user
                session: session
                type: msg_receive_session
                messages: session
              callback: SentSuccessful
              error: SentError

      when msg_leave_session, msg_remove_user then do ->
        Session.findById message.session, (err, session) ->
          if err
            ServerError err
          else
            if message.user is session.admin
              for user, i in session.users
                if user isnt session.admin
                  pubnub.publish
                    channel: channel_server
                    message:
                      user: user
                      type: msg_session_cancelled
                      session: session
                    callback: SentSuccessful
                    error: SentError
            else
              session.users = users.filter (user) ->
                user isnt message.user
              if message.type is msg_remove_user
                pubnub.publish
                  channel: channel_server
                  message:
                    user: message.user
                    type: msg_kicked_from_session
                    session: session
                  callback: SentSuccessful
                  error: SentError

      when msg_send_message then do ->
        Session.findById message.session, (err, session) ->
          if err
            ServerError err
          else
            session.messages.push message.data
            session.save () ->
              if err
                ServerError
              else 
                pubnub.publish
                  channel: channel_server + '/chat/' + message.session 
                  message: message.data
                  callback: SentSuccessful
                  error: SentError

      when msg_get_user_info then do ->
        User.find _id: message.user, (err, user) ->
          if err
            ServerError err
          else
            pubnub.publish
              channel: channel_server
              message:
                user: message.user
                type: msg_get_user_info
                info: user
              callback: SentSuccessful
              error: SentError

      when msg_get_league_statistics then do ->
        User.find {}, (err, users) ->
          if err
            ServerError err
          else
            statistics = []
            for user, i in users
              statistics.push
                identifier: user.identifier
                points: user.statistics.won * 2 + user.statistics.tied
                name: user.name
                firstName: user.firstName
            pubnub.publish
              channel: channel_server + '/' + msg_get_user_info + '/' + message.user.id
              message:
                users: statistics
              callback: SentSuccessful
              error: SentError

      else
        console.log 'Unknown client message \'', message, '\' received.'

    return