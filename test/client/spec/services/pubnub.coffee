'use strict'

describe 'Service: Pubnub', () ->

  # load the service's module
  beforeEach module 'scrimmageApp'

  # instantiate service
  Pubnub = {}
  beforeEach inject (_Pubnub_) ->
    Pubnub = _Pubnub_

  it 'should do something', () ->
    expect(!!Pubnub).toBe true
