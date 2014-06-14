'use strict'

angular.module('scrimmageApp')
  .service 'Pubnub', () ->
    _publishKey = 'pub-c-b4096ce5-10e7-4674-9cbc-7f1393edf2be'
    _subscribeKey = 'sub-c-fafce722-f3bb-11e3-b429-02ee2ddab7fe'

    @channel = 
      USER: 'user'

    @init = () =>
      @instance = PUBNUB.init 
        publish_key: _publishKey
        subscribe_key: _subscribeKey

    @publish = (channel, msg) =>
      @instance.publish
        channel: channel
        message: msg

    @subscribe = (channel, callback, options)
      options ?= {}
      options.channel = channel
      options.message = callback
      @instance.subscribe options

    return

    # AngularJS will instantiate a singleton by calling "new" on this function
