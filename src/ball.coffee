Axis = require './axis.coffee'
Random = require './random.coffee'
Color = require './color.coffee'

class Ball
	gravity = 0.6 #pseudo gravity
	drag = 0.99
	fullCircleRadian = Math.PI*2

	constructor: (@canvas, @ctx, x, y) ->

		# speed is actually a pseudo speed,
		# it's the increment on the position with each frame
		# which is different from an increment based on real time
		@speed = Random.range 5, 10
		@radius = Random.range 4, 8
		dx = @speed * Random.range -1, 1 # [-1,1] left or right
		dy = @speed * Random.range -1, 0 # [-1,0] always negative => up
		@x = new Axis.Linear x, dx, @canvas.width, @radius
		@y = new Axis.Accel y, dy, @canvas.height, @radius, gravity

		@color = new Color()
		@stopped = false


	setNextPos: ->
		if @y.hasSpeed
			@y.setNextPos()
		else
			stopped = true

		if @x.hasSpeed
			@x.setNextPos()
			if !@y.hasSpeed
				@x.scaleSpeed drag
		else
			if stopped then @stopped = true

	draw: ->
		if @stopped
			# doubles as a discarding mechanism
			# flag object as discardable when it's full white 
			@color.setBrighter()
		else
			@setNextPos()
		@ctx.fillStyle = @color.string
		@ctx.beginPath()
		@ctx.arc @x.pos, @y.pos, @radius, 0, fullCircleRadian, true
		@ctx.closePath()
		@ctx.fill()

module.exports = Ball
