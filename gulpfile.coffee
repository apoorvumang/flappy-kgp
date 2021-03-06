gulp = require 'gulp'
coffee = require 'gulp-coffee'
gutil = require 'gulp-util'
connect = require 'gulp-connect'
concat = require 'gulp-concat'
uglify = require 'gulp-uglify'

gulp.task 'coffee', ->
  gulp.src ['index.coffee']
  .pipe coffee( bare: true ).on('error', gutil.log)
  .pipe gulp.dest 'tmp'
  .pipe connect.reload()

gulp.task 'concat', ->
  gulp.src ['bower_components/phaser/build/phaser.js']
  .pipe concat('index.min.js')
  # .pipe uglify()
  .pipe gulp.dest '.'

gulp.task 'watch', ->
  gulp.watch ['index.coffee', '!gulpfile.coffee'], ['coffee']

gulp.task "connect", connect.server(
  root: __dirname
  port: 3000
  livereload: true
)

gulp.task "server", connect.server(
  root: __dirname
  port: process.env.PORT || 5000
  livereload: false
)

gulp.task 'default', ['coffee', 'concat', 'connect', 'watch']
gulp.task 'prod', ['server']
# gulp.task 'prod', ['coffee', 'concat']