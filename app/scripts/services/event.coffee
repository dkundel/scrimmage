'use strict'

angular.module('scrimmageApp')
  .service 'Event', () ->
    tempInfo = {}

    @setTemp = (tmp) =>
      tempInfo = tmp


    @submitInfo = () =>
      console.log 'More magic'
    # AngularJS will instantiate a singleton by calling "new" on this function
