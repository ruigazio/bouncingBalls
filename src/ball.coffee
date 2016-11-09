class Ball
	constructor: (ctx, x, y) ->
		@ctx = ctx
		@x = x
		@y = y

	draw: () ->
		@ctx.beginPath()
		@ctx.arc @x, @y, 5, 0, Math.PI*2,true
		@ctx.closePath()
		@ctx.stroke()

module.exports = Ball
