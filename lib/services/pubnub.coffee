pubnub = require('pubnub').init(
  publish_key: 'pub-c-b4096ce5-10e7-4674-9cbc-7f1393edf2be'
  subscribe_key: 'sub-c-fafce722-f3bb-11e3-b429-02ee2ddab7fe'
)

# ---------------------------------------------------------------------------
#Publish Messages
#--------------------------------------------------------------------------- 
###
message = some: 'data'
pubnub.publish
  channel: 'server'
  message: message
  callback: (e) ->
    console.log 'SUCCESS!', e
    return

  error: (e) ->
    console.log 'FAILED! RETRY PUBLISH!', e
    return
###

# --------------------------------------------------------------------------
# Client Events
# -------------------------------------------------------------------------- 
pubnub.subscribe
  channel: 'client'
  callback: (message) ->
    switch message.type
      when "create_session" then do (message.data) ->
        console.log message
      when "edit_session" then do (message.data) ->
        console.log message
      when "remove_session" then do (message.data) ->
        console.log message
      when "connect_client" then do (message.data) ->
        console.log messageg
      when "get_sessions" then do (message.data) ->
        console.log message
      when "get_all_sessions" do (message.data) ->
        console.log message
      when "join_session" then do (message.data) ->
        console.log message
      when "leave_session" then do (message.data) ->
        console.log message
      when "kick_user" then do (message.data) ->
        console.log message
      when "send_message" then do (message.data) ->
        console.log message
      else console.log 'Unknown client message \'', message, '\' received.'
    return