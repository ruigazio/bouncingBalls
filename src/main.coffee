Manager = require './manager.coffee'

document.addEventListener 'DOMContentLoaded', ->
	$board = document.querySelector 'canvas#board'
	$fps = document.querySelector 'span#fps'
	setTimeout () ->
		manager = new Manager $board, $fps
		manager.render()
