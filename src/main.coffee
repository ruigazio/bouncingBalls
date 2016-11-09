Manager = require './manager.coffee'

document.addEventListener 'DOMContentLoaded', ->
	$board = document.querySelector 'canvas#board'
	setTimeout () ->
		manager = new Manager $board
		manager.render()
