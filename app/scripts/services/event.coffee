'use strict'

angular.module('scrimmageApp')
  .service 'Event', ($location) ->
    tempInfo = {}

    @setTemp = (tmp) =>
      tempInfo = tmp


    @submitEvent = (moreInfo) =>
      tempInfo.location = moreInfo.location
      tempInfo.time = moreInfo.time
      tempInfo.date = moreInfo.date

      console.log 'More magic'

      $location.path '/event/1/chat'
      window.scrollTo 0, 0
    # AngularJS will instantiate a singleton by calling "new" on this function

    @join = (id) =>
      console.log 'Join Event'

    return