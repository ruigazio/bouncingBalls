del              = require 'del'
gutil            = require 'gutil'
gulp             = require 'gulp'
coffee           = require 'gulp-coffee'
replace          = require 'gulp-replace'
concat           = require 'gulp-concat'
gulpWebpack      = require 'gulp-webpack'
webpack          = require 'webpack'
webpackDevServer = require "webpack-dev-server"

gulp.task 'clean', ->
	del [ 'dist/**/*' ]

gulp.task 'html', ['clean'], ->
	gulp.src 'src/*.html'
		.pipe gulp.dest 'dist/'

gulp.task 'coffee', ->
	gulp.src './src/*.coffee'
	.pipe(coffee({bare: true}).on('error', gutil.log))
	.pipe replace '.coffee', '.js'
	.pipe gulp.dest './dist/'

gulp.task 'js', ->
	gulp.src './src/*.js'
	.pipe gulp.dest './dist/'

gulp.task 'webdist', ['html'], ->
	gulp.src 'src/main.coffee'
		.pipe gulpWebpack require './webpack.config.dist.coffee'
		.pipe gulp.dest 'dist/'

gulp.task 'webpack-dev-server', ['html'], ->
	myConfig = require './webpack.config.coffee'
	gulp.watch ["src/**/*.html"], ['html']
	new webpackDevServer webpack(myConfig),
		watch: true
		publicPath: "/"
		contentBase: "dist"
		stats:
			colors: true
	.listen 8003, "localhost", (err) ->
		if err then throw new gutil.PluginError "webpack-dev-server", err
		gutil.log "[webpack-dev-server]", "http://localhost:8003/webpack-dev-server/index.html"

gulp.task 'default', ['webpack-dev-server']
