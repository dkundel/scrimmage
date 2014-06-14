'use strict'

describe 'Service: Fbuser', () ->

  # load the service's module
  beforeEach module 'scrimmageApp'

  # instantiate service
  Fbuser = {}
  beforeEach inject (_Fbuser_) ->
    Fbuser = _Fbuser_

  it 'should do something', () ->
    expect(!!Fbuser).toBe true
