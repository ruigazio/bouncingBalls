# model a component of the position and speed vector
class Linear
	stopThreshold = 0.01
	elasticity = 0.9

	constructor: (@pos, @speed, @farEnd, @radius) ->
		@hasSpeed = true
		if (@pos - @radius) < 0
			@pos = @radius
		if (@pos + @radius) > @farEnd
			@pos = @farEnd - @radius

	setNextPos: ->
		nextPos = @incPos()

		if (nextPos - @radius) < 0 || (nextPos + @radius) > @farEnd
			@scaleSpeed -elasticity
			@incPos()

	incPos: () -> #update the coordinate value with the elapsed time
		@pos += @speed

	scaleSpeed: (n) ->
		@speed *= n
		if Math.abs(@speed) < stopThreshold
			@hasSpeed = false

	addSpeed: (n) ->
		@speed += n

class  Accel extends Linear
	constructor: (pos, speed, farEnd, radius, @accel) ->
		super pos, speed, farEnd, radius

	setNextPos: ->
		super()
		@addSpeed @accel

module.exports =
	Linear: Linear
	Accel: Accel
