pubnub = require('pubnub').init(
  publish_key: 'pub-c-b4096ce5-10e7-4674-9cbc-7f1393edf2be'
  subscribe_key: 'sub-c-fafce722-f3bb-11e3-b429-02ee2ddab7fe'
)

channel_client = 'client'
channel_server = 'server'

msg_create_session =      'create_session'
msg_edit_session =        'edit_session'
msg_connect_client =      'connect_client'
msg_get_sessions =        'get_sessions'
msg_get_open_sessions =   'get_open_sessions'
msg_join_session =        'join_session'
msg_leave_session =       'leave_session'
msg_remove_user =         'remove_user'
msg_session_cancelled =   'session_cancelled'
msg_kicked_from_session = 'kicked_from_session'
msg_send_message =        'send_message'
msg_receive_message =     'receive_message'
msg_receive_session =     'receive_session'
msg_get_user_info =       'get_user_info'

# --------------------------------------------------------------------------
# Error Handling Functions
# -------------------------------------------------------------------------- 
SentSuccessful = (e) ->
  console.log 'SUCCESS!', e

SentError = (e) ->
  console.log 'FAILED! RETRY PUBLISH!', e

ServerError = (e) ->
  handleError e
  console.log 'FAILED!', e

# --------------------------------------------------------------------------
# Help Functions
# --------------------------------------------------------------------------
IsFull = (type, size) ->
  (type is 'S' and size is 2) or (type is 'D' and size is 4)

# --------------------------------------------------------------------------
# Message Template
# --------------------------------------------------------------------------
# { type: 'type', user: 'facebook_id', ... }
# OR
# { type: 'type', session: 'session_identifier', user: 'facebook_id', ... }

# --------------------------------------------------------------------------
# Client Events
# -------------------------------------------------------------------------- 
pubnub.subscribe
  channel: channel_client
  callback: (message) ->
    switch message.type
      when msg_create_session then do ->
        Session.create message.session,(err, session) ->
          if err
            ServerError err
          else
            session.admin = message.user
            session.users.push message.user

      when msg_edit_session then do ->
        Session.findOneAndUpdate
          identifier: message.session.identifier
          message.session

      when msg_connect_client then do ->
        User.count
          identifier: message.user, (err, count) ->
            if err
              ServerError err
            else if count == 0
              User.create
                identifier: message.user, (err, user) ->
                  ServerError err if err

      when msg_get_sessions then do ->
        Session.find message.data.settings, (err, sessions) ->
          if err
            ServerError err
          else
            open_sessions = sessions.filter (session) ->
              IsFull session.userType, session.users.length
            pubnub.publish
              channel: channel_server
              message:
                user: message.user
                type: msg_get_open_sessions
                sessions: open_sessions
              callback: SentSuccessful
              error: SentError

      when msg_get_open_sessions then do ->
        Session.find {}, (err, sessions) ->
          if err
            ServerError err
          else
            open_sessions = sessions.filter (session) ->
              IsFull session.userType, session.users.length
            pubnub.publish
              channel: channel_server
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
            session.users.push message.user
            channel: channel_server
              message:
                user: message.user
                session: message.session
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
            session.messages.push(message.data)
            pubnub.publish
              channel: channel_server
              message:
                user: message.user
                session: message.session
                type: msg_receive_message
                data: message.data
              callback: SentSuccessful
              error: SentError

      when msg_get_user_info then do ->
        User.find identifier: message.user, (err, user) ->
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

      else
        console.log 'Unknown client message \'', message, '\' received.'

    return