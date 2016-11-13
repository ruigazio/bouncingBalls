# model a component of the position and speed vector
class BoundedAxis
	stopThreshold = 0.5
	elasticity = 0.9

	constructor: (@pos, @speed, @farEnd) ->
		@hasSpeed = true

	checkBounce: (radius) ->
		nextPos = @updatePos()

		if (nextPos - radius) < 0 || (nextPos + radius) > @farEnd
			@scaleSpeed -elasticity
			@updatePos()

	updatePos: () -> #update the coordinate value with the elapsed time
		@pos += @speed

	scaleSpeed: (n) ->
		@speed *= n
		if Math.abs(@speed) < stopThreshold
			@hasSpeed = false

	addSpeed: (n) ->
		@speed += n

module.exports = BoundedAxis
