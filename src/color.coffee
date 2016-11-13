Random = require './random.coffee'

class Color

	constructor: (@maxLevel=250) ->
		@setRandomColor()

	setColorStr: ->
		@string = "rgb(#{@r},#{@g},#{@b})"

	setRandomMaxBrightness: (maxLevel) ->
		@maxLevel = maxLevel

	setRandomColor: ->
		@r = Random.intUnder @maxLevel
		@g = Random.intUnder @maxLevel
		@b = Random.intUnder @maxLevel
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
