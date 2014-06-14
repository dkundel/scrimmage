'use strict'

describe 'Service: Map', () ->

  # load the service's module
  beforeEach module 'scrimmageApp'

  # instantiate service
  Map = {}
  beforeEach inject (_Map_) ->
    Map = _Map_

  it 'should do something', () ->
    expect(!!Map).toBe true
