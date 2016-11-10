class Ball
	g = 9.8 #gravity m/s^2
	minimalSpeed = 5
	elasticity = 0.9
	drag = 0.98
	maxRadius = 8
	minRadius = 4
	WIN = 0
	WTOP = 2
	WRIGHT = 4
	WBOTTOM = 8
	WLEFT = 16

	constructor: (canvas, ctx, x, y) ->
		@canvas = canvas
		@ctx = ctx
		@x = x
		@y = y

		# set the time stamp - the ball will be rendered imediately after instantiation
		@timeStamp = performance.now()

		@speed = Math.random() + minimalSpeed
		@dx = @speed * (Math.random() * 2 - 1) # [-1,1] left or right
		@dy = - @speed * Math.random() # [-1,0] always negative => up
		@setRandomColor()
		@radius = Math.random() * (maxRadius - minRadius) + minRadius

	setRandomColor: ->
		c = ->
			Math.floor Math.random() * 255
		@color = "rgb(#{c()},#{c()},#{c()})"

	#time in seconds between frames
	getElapsedTime: ->
		previousTime = @timeStamp
		@timeStamp = performance.now()
		(@timeStamp - previousTime)/1000

	onWall: ([x,y]) ->
		touching = WIN
		if (x-@radius) < 0
			touching |= WLEFT
		else if (x + @radius) > @canvas.width
			touching |= WRIGHT
		if (y+@radius) > @canvas.height
			touching |= WBOTTOM
		else if (y-@radius) < 0
			touching |= WTOP

		return touching

	getUpdatedCoor: ->
		return [ @x + @dx, @y + @dy]

	setCoor: ->
		coords = @getUpdatedCoor()
		touching =  @onWall coords
		if !@stoppedY && touching & (WTOP | WBOTTOM)
			@dy = -@dy * elasticity
			if Math.abs(@dy) < 0.1
				@stoppedY = true

		if !@stoppedX && touching & (WLEFT | WRIGHT)
			@dx = -@dx * elasticity
			if Math.abs(@dx) < 0.1
				@stoppedX = true

		if !@stoppedY
			@dy += g * @getElapsedTime()
			@y += @dy

		if !@stoppedX
			if @stoppedY
				@dx = @dx * drag
			@x += @dx

	draw: ->
		unless @stopped
			@setCoor()
		@ctx.fillStyle = @color
		@ctx.beginPath()
		@ctx.arc @x, @y, @radius, 0, Math.PI*2,true
		@ctx.closePath()
		@ctx.fill()

module.exports = Ball
