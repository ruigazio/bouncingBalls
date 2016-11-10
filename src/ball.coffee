class Ball
	g = 9.8 #gravity m/s^2
	minimalSpeed = 5
	radius = 5
	elasticity = 0.9
	WIN = 0
	WTOP = 1
	WRIGHT = 2
	WBOTTOM = 3
	WLEFT = 4

	constructor: (canvas, ctx, x, y) ->
		@canvas = canvas
		@ctx = ctx
		@x = x
		@y = y

		# set the time stamp - it'll be rendered imediately after instantiation
		@timeStamp = performance.now()

		@speed = Math.random() + minimalSpeed
		@dx = @speed * (Math.random() * 2 - 1) # [-1,1] left or right
		@dy = - @speed * Math.random() # always negative => up

	#time in seconds between frames
	getElapsedTime: ->
		previousTime = @timeStamp
		@timeStamp = performance.now()
		(@timeStamp - previousTime)/1000

	onWall: ->
		touching = WIN
		if @x < 0
			touching = WLEFT
		if @x > @canvas.width
			touching = WRIGHT
		if @y > @canvas.height
			touching = WBOTTOM
		if @y < 0
			touching = WTOP

		if @wallHyst
			unless touching
				@wallHyst = false
			return WIN
		else
			if touching
				@wallHyst = true
			return touching

	setCoor: ->
		wall =  @onWall()
		switch wall
			when WLEFT,WRIGHT
				@dx = -@dx * elasticity
			when WTOP, WBOTTOM
				@dy = -@dy * elasticity

		@dy += g * @getElapsedTime()
		@x += @dx
		@y += @dy
		if @y > @canvas.height + 12
			@stopped = true
			@y = @canvas.height

		###
		if !(@wallHyst && Math.abs(@dy) < 0.01)
			@dy += g * @getElapsedTime()
			@x += @dx
			@y += @dy
		###

	draw: ->
		unless @stopped
			@setCoor()
		@ctx.beginPath()
		@ctx.arc @x, @y, radius, 0, Math.PI*2,true
		@ctx.closePath()
		@ctx.stroke()

module.exports = Ball
