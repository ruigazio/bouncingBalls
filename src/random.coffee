C =
	range: (l,r) ->
		breath = r - l
		breath * Math.random() + l

	under: (r) ->
		r * Math.random()

	intUnder: ->
		Math.floor C.under.apply null, arguments

	intRange: ->
		Math.floor C.range.apply null, arguments

module.exports = C
