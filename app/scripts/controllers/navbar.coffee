'use strict'

angular.module('scrimmageApp')
  .controller 'NavbarCtrl', ($scope, $location) ->
	$scope.menu = [
	  title: 'Home'
	  link: '/'
	,
	  title: 'Find'
	  link: '/find'
  ,
    title: 'Create'
    link: '/create'
  ,
    title: 'Manage'
    link: '/manage'
  ,
    title: 'League'
    link: '/league'
  ,
    title: 'Profile'
    link: '/profile'
  ]

	$scope.isActive = (route) ->
	  route is $location.path()