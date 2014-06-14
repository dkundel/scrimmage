'use strict'

angular.module('scrimmageApp')
  .service 'Map', () ->
    # AngularJS will instantiate a singleton by calling "new" on this function

    @init = (id, options) =>
      @options = options
      @mapId = id
      @map = new google.maps.Map (document.getElementById id), options

    @centerMap = (zoomLevel) =>
      if @currentPos? and @currentPos.latitude? and @currentPos.longitude?
        @map.panTo new google.maps.LatLng(@currentPos.latitude, @currentPos.longitude)

    @getCurrentLocation = (callback) =>
      if navigator.geolocation
        unless typeof callback is 'function'
          callback = (resp) =>
            @currentPos = resp.coords
            @lastPosTime = resp.timestamp 
            @centerMap()
        navigator.geolocation.getCurrentLocation callback

    @getEvents = () =>
      console.log "Apply Magic"

    return