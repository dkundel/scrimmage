'use strict'

describe 'Service: Event', () ->

  # load the service's module
  beforeEach module 'scrimmageApp'

  # instantiate service
  Event = {}
  beforeEach inject (_Event_) ->
    Event = _Event_

  it 'should do something', () ->
    expect(!!Event).toBe true
