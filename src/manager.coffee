Ball = require './ball.coffee'

class Manager
	constructor: (@$canvas, @$fps) ->
		@$canvas.height = 500
		@ctx = @$canvas.getContext "2d"
		@objs = []
		@$canvas.addEventListener 'click', @clickHandler.bind @
		@frameNo = 0
		@fpsTime = 0

	clickHandler: (e) ->
		x = e.offsetX || (e.layerX - @$canvas.offsetLeft)
		y = e.offsetY || (e.layerY - @$canvas.offsetTop)
		@objs.push new Ball @$canvas, @ctx, x, y

	renderFPS: ->
		previousTime = @fpsTime
		@fpsTime = performance.now()
		totalTime = @fpsTime - previousTime
		@$fps.innerText = Math.floor 50000 / totalTime
		@frameNo = 0

	render: () ->
		@frameNo++
		unless @frameNo % 50
			@renderFPS()
		@ctx.clearRect 0, 0, @$canvas.width, @$canvas.height
		newObjs = []
		for o in @objs
			unless o.color.isFullWhite()
				o.draw()
				newObjs.push o
		@objs = newObjs
		requestAnimationFrame @render.bind @

module.exports = Manager
