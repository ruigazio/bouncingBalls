CoordinateComponent = require './coordinateComponent.coffee'

class Ball
	g = 9.8 #pseudo gravity
	minimalSpeed = 5
	elasticity = 0.9
	drag = 0.99
	maxRadius = 8
	minRadius = 4
	fullCircleRadian = Math.PI*2
	WIN = 0
	WTOP = 2
	WRIGHT = 4
	WBOTTOM = 8
	WLEFT = 16

	@getRandomColor: ->
		c = ->
			Math.floor Math.random() * 255
		"rgb(#{c()},#{c()},#{c()})"

	constructor: (@canvas, @ctx, x, y) ->

		# speed is actually a pseudo speed,
		# it's the increment on the position with each frame
		# which is different from an increment based on time
		@speed = Math.random() + minimalSpeed
		dx = @speed * (Math.random() * 2 - 1) # [-1,1] left or right
		dy = - @speed * Math.random() # [-1,0] always negative => up
		@x = new CoordinateComponent x, dx
		@y = new CoordinateComponent y, dy

		@color = @constructor.getRandomColor()
		@radius = Math.random() * (maxRadius - minRadius) + minRadius


	checkBounce: (coo, farEnd) ->
		nextPos = coo.updatePos()

		if (nextPos - @radius) < 0 || (nextPos + @radius) > farEnd
			coo.scaleSpeed -elasticity
			coo.updatePos()

	setCoor: (elapsedTime) ->

		if @y.hasSpeed
			@y.addSpeed g * elapsedTime
			@checkBounce @y, @canvas.height

		if @x.hasSpeed
			@checkBounce @x, @canvas.width
			if !@y.hasSpeed
				@x.scaleSpeed drag

	draw: (elapsedTime) ->
		unless @stopped
			@setCoor elapsedTime
		@ctx.fillStyle = @color
		@ctx.beginPath()
		@ctx.arc @x.pos, @y.pos, @radius, 0, fullCircleRadian, true
		@ctx.closePath()
		@ctx.fill()

module.exports = Ball
