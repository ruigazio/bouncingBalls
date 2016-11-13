Ball = require './ball.coffee'

class Manager
	constructor: (@$canvas, @$fps) ->
		@$canvas.height = 500
		@ctx = @$canvas.getContext "2d"
		@objs = []
		# set the time stamp - the ball will be rendered imediately after instantiation
		@timeStamp = 0

		@bbox =
			left:  @$canvas.offsetLeft
			top:  @$canvas.offsetTop
			bottom: @$canvas.offsetTop + @$canvas.height - @$canvas.clientTop
			right: @$canvas.offsetLeft + @$canvas.width - @$canvas.clientLeft

		@$canvas.addEventListener 'click', @clickHandler.bind @
		@frameNo = 0
		@fpsTime = 0

	clickHandler: (e) ->
		x = e.layerX - @bbox.left
		y = e.layerY - @bbox.top
		@objs.push new Ball @$canvas, @ctx, x, y

	#time in seconds between frames
	setElapsedTime: ->
		previousTime = @timeStamp
		@timeStamp = performance.now()
		@elapsedTime = (@timeStamp - previousTime)/1000

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
		elapsedTime = @setElapsedTime()
		@ctx.clearRect 0, 0, @$canvas.width, @$canvas.height
		newObjs = []
		for o in @objs
			o.draw()
			unless o.color.isFullWhite()
				newObjs.push o
		@objs = newObjs
		requestAnimationFrame @render.bind @

module.exports = Manager
