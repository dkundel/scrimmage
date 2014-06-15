'use strict'

angular.module('scrimmageApp')
  .service 'Map', ($rootScope, $location) ->
    # AngularJS will instantiate a singleton by calling "new" on this function

    @markers = []

    @init = (id, options) =>
      delete @map
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
            console.log(resp)
            @centerMap()
        navigator.geolocation.getCurrentPosition callback

    @getEvents = () =>
      console.log "Apply Magic"

    @showEvents = (events) =>
      for m in @markers
        m.setMap null
        # delete m
      @markers = []
      if events?
        for e in events
          marker = new google.maps.Marker
            map: @map
            position: new google.maps.LatLng e.location.lat, e.location.long
            title: e.location.address

          google.maps.event.addListener marker, 'click', () =>
            $rootScope.$apply () ->
              path = '/event/' + e._id + '/overview'
              console.log path
              $location.path(path)
              # window.scrollTo 0, 0

          @markers.push marker



    @markAndZoom = (coords) =>
      if @markerVenue?
        @markerVenue.setMap null
        delete @markerVenue
      @map.panTo coords
      @markerVenue = new google.maps.Marker
        map: @map
        position: coords
        title: 'Venue'

    return