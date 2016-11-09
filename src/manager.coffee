Ball = require './ball.coffee'

class Manager
	constructor: ($board) ->
		@canvas = $board
		@ctx = $board.getContext "2d"
		@objs = []
		@bbox =
			left:  @canvas.offsetLeft
			top:  @canvas.offsetTop
			bottom: @canvas.offsetTop + @canvas.height
			right: @canvas.offsetLeft + @canvas.width

		$board.addEventListener 'click', @clickHandler.bind @

	clickHandler: (e) ->
		x = e.layerX - @bbox.left
		y = e.layerY - @bbox.top
		@objs.push new Ball @bbox, @ctx, x, y

	render: () ->
		@ctx.clearRect 0, 0, @canvas.width, @canvas.height
		for o in @objs
			o.draw()
		requestAnimationFrame @render.bind @

module.exports = Manager
