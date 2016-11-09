Ball = require './ball.coffee'

class Manager
	constructor: ($board) ->
		@canvas = $board
		@ctx = $board.getContext "2d"
		@objs = []
		@canvasInfo =
			offX:  @canvas.offsetLeft
			offY:  @canvas.offsetTop

		$board.addEventListener 'click', @clickHandler.bind @

	clickHandler: (e) ->
		x = e.layerX - @canvasInfo.offX
		y = e.layerY - @canvasInfo.offY
		@objs.push new Ball @ctx, x, y

	render: () ->
		for o in @objs
			o.draw()
		requestAnimationFrame @render.bind @

module.exports = Manager
