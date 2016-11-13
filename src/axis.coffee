# model a component of the position and speed vector
elasticity = 0.9
stopThreshold = 0.01

class Linear
	constructor: (@pos, @speed, @farEnd, @radius) ->
		@hasSpeed = true
		@nudgeIn()

	nudgeIn: ->
		prevPos = @pos
		candidatePos = @pos + @speed
		if ( distance = candidatePos - @radius) < 0
			@pos = @radius
		else if (distance = candidatePos + @radius - @farEnd) > 0
			@pos = @farEnd - @radius
		else
			@pos = candidatePos
			return null

		#return the ratio of the move in case of bouncing
		# candidateDistance = Math.abs candidatePos - prevPos
		candidateDistance = candidatePos - prevPos
		return distance / candidateDistance

	setNextPos: ->
		if @nudgeIn()
			@scaleSpeed -elasticity

	scaleSpeed: (n) ->
		@speed *= n
		if Math.abs(@speed) < stopThreshold
			@hasSpeed = false


class  Accel extends Linear
	constructor: (pos, speed, farEnd, radius, @accel) ->
		super pos, speed, farEnd, radius

	setNextPos: ->
		nudgeRatio = @nudgeIn()
		if nudgeRatio == null
			@speed += @accel
		else
			console.log nudgeRatio
			@speed -= @accel * nudgeRatio
			@scaleSpeed -elasticity

module.exports =
	Linear: Linear
	Accel: Accel
