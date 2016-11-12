# model a component of the position and speed vector
class CoordinateComponent
	stopThreshold = 0.1

	constructor: (@pos, @speed) ->
		@hasSpeed = true
		# @i = i #coordinate value
		# @d = d #speed (d for delta)

	updatePos: () -> #update the coordinate value with the elapsed time
		@pos += @speed

	scaleSpeed: (n) ->
		@speed *= n
		if Math.abs(@speed) < stopThreshold
			@hasSpeed = false

	addSpeed: (n) ->
		@speed += n

module.exports = CoordinateComponent
