webpack = require 'webpack'
module.exports =
	entry: './src/main.js'
	output:
		filename: 'bundle.js'

	module:
		loaders: [
			{ test: /\.js/, loader: 'babel-loader' }
		]

	plugins: [
		new webpack.optimize.UglifyJsPlugin()
	]
