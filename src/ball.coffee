class Ball
	constructor: (bbox, ctx, x, y) ->
		@bbox = bbox
		@ctx = ctx
		@x = x
		@y = y
		@speed = Math.random() + 0.1
		@dx = @speed * (Math.random() * 2 - 1)
		@dy = - @speed * Math.random()

	setCoor: ->
		@x += @dx
		@y += @dy

	draw: ->
		@setCoor()
		@ctx.beginPath()
		@ctx.arc @x, @y, 5, 0, Math.PI*2,true
		@ctx.closePath()
		@ctx.stroke()

module.exports = Ball
