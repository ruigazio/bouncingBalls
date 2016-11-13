path = require 'path'

module.exports =
	watch: true
	entry: './src/main.js'
	devtool: 'sourcemap'
	debug: true
	output:
		path: path.join __dirname, 'dist'
		publicPath: '/'
		filename: 'bundle.js'

	module:
		loaders: [
			{ test: /\.js/, loader: 'babel-loader' }
		]
