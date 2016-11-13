Random = require './random.coffee'

class Color

	constructor: () ->
		@setRandomColor()

	setColorStr: ->
		@string = "rgb(#{@r},#{@g},#{@b})"

	setRandomColor: ->
		@r = Random.intUnder 255
		@g = Random.intUnder 255
		@b = Random.intUnder 255
		@setColorStr()

	isFullWhite: ->
		@r == 255 && @g == 255 && @b == 255

	setBrighter: ->
		f = (c) ->
			if c < 255
				++c
			else c

		@r = f @r
		@g = f @g
		@b = f @b
		@setColorStr()

module.exports = Color
