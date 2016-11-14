elasticity = 0.9
stopThreshold = 0.01

# model a component of the position and speed vector
class Linear
	constructor: (@pos, @speed, @farEnd, @radius) ->
		@hasSpeed = true
		@nudgeIn()

	nudgeIn: ->
		newPos = @pos + @speed
		if ( newPos - @radius) < 0
			@pos = @radius
		else if (newPos + @radius) > @farEnd
			@pos = @farEnd - @radius
		else
			@pos = newPos
			return false

		return true

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

	nudgeIn: ->
		prevPos = @pos
		candidatePos = @pos + @speed
		if ( distance = candidatePos - @radius) < 0
			@pos = @radius
		else if (distance = candidatePos + @radius - @farEnd) > 0
			@pos = @farEnd - @radius
		else
			@pos = candidatePos
			return 0

		#if there is a bounce, return the ratio of the candidate move 
		#made outside of the boundary
		return distance / @speed

	setNextPos: ->
		nudgeRatio = @nudgeIn()
		if nudgeRatio
			@speed -= @accel * nudgeRatio
			@scaleSpeed -elasticity
		else
			@speed += @accel

module.exports =
	Linear: Linear
	Accel: Accel
