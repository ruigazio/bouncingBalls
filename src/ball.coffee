class Ball
	g = 9.8 #gravity m/s^2
	minimalSpeed = 5

	constructor: (bbox, ctx, x, y) ->
		@bbox = bbox
		@ctx = ctx
		@x = x
		@y = y

		# set the time stamp - it'll be rendered imediately after instantiation
		@timeStamp = performance.now()

		@speed = Math.random() + minimalSpeed
		@dx = @speed * (Math.random() * 2 - 1) # [-1,1] left or right
		@dy = - @speed * Math.random() # always positive => up

	#time in seconds between frames
	getElapsedTime: ->
		previousTime = @timeStamp
		@timeStamp = performance.now()
		(@timeStamp - previousTime)/1000

	setCoor: ->
		@dy += g * @getElapsedTime()
		@x += @dx
		@y += @dy

	draw: ->
		@setCoor()
		@ctx.beginPath()
		@ctx.arc @x, @y, 5, 0, Math.PI*2,true
		@ctx.closePath()
		@ctx.stroke()

module.exports = Ball
