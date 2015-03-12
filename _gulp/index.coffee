gulp = require 'gulp'
sass = require 'gulp-ruby-sass'
cssmin = require 'gulp-cssmin'
uglify = require 'gulp-uglify'
uglifyjs = require 'gulp-uglifyjs'
htmlmin = require 'gulp-htmlmin'
rename = require 'gulp-rename'
concat = require 'gulp-concat'
coffee = require 'gulp-coffee'
util = require 'gulp-util'
rimraf = require 'rimraf' # delete folder
grimraf = require 'gulp-rimraf' # delete file
livereload = require 'gulp-livereload'
connect = require 'gulp-connect'
argv = require('yargs').argv
gulpif = require 'gulp-if'
# 
config = 
  "base": 'src/base/',
  "src": "src/",
  "build": "build/",
  "style": 
    "base": 'src/base/css/*.css'
    "scss": "src/scss/app.scss",
    "dest": "build/assets/css/"
  ,"js": 
    "base": 'src/base/js/'
    "coffee": "src/coffee/*.coffee",
    "dest": "build/assets/js/"
  ,"index": 
    "src": "src/index.html",
    "dest": "build/"
  ,"templates": 
    "src": "src/templates/*.html",
    "dest": "build/templates/"
  ,"images": 
    "src": "src/img/*",
    "dest": "build/assets/img/"

# compile scss
gulp.task 'style', ->
  sass(config.style.scss, { style: 'expanded' })
    .pipe(gulpif(argv.production, cssmin()))
    .pipe(gulp.dest(config.style.dest))
    .pipe connect.reload()

gulp.task 'style-base', ->
  gulp.src(config.style.base)
    .pipe(concat('base.css'))
    .pipe(gulp.dest(config.style.dest))

# compile coffeescript
gulp.task 'js', ->
  gulp.src(config.js.coffee)
    .pipe(coffee({bare: true}).on('error', util.log))
    .pipe(gulpif(argv.production,uglify({compress:{drop_console: true}})))
    .pipe(gulp.dest(config.js.dest))
    .pipe connect.reload()

# move main html
gulp.task 'index', ->
  gulp.src(config.index.src)
    .pipe(gulpif(argv.production,htmlmin({collapseWhitespace: true, removeComments: true})))
    .pipe(gulp.dest(config.index.dest))
    .pipe connect.reload()

gulp.task 'templates', ->
  gulp.src(config.templates.src)
    .pipe(gulpif(argv.production,htmlmin({collapseWhitespace: true, removeComments: true})))
    .pipe(gulp.dest(config.templates.dest))
    .pipe connect.reload()

gulp.task 'images', ->
  gulp.src(config.images.src)
    .pipe(gulp.dest(config.images.dest))
    .pipe connect.reload()

# copy base files
gulp.task 'base', ()->
  gulp.start 'style-base'
  gulp.src(config.js.base+'*.js')
    .pipe(gulpif(argv.production,uglify({compress:{drop_console: true}})))
    .pipe(gulp.dest(config.js.dest))
  gulp.src(config.base+'fonts/*').pipe gulp.dest(config.build+'assets/fonts/')

# watch
gulp.task 'watch', ()->
  gulp.watch config.src+'/**/*.scss', ['style']
  gulp.watch config.src+'/**/*.coffee', ['js']
  gulp.watch config.templates.src, ['templates']
  gulp.watch config.index.src, ['index']
  gulp.watch config.images.src, ['images']
# server
gulp.task 'server', ->
  connect.server({
    root: ['build'],
    port: '8888',
    livereload: true
  });

# default
gulp.task "default", ['server', 'watch']
gulp.task "clean", ->
  rimraf config.build, ()->
# build
gulp.task "build", ->
  gulp.start 'base', 'index', 'templates','style', 'js', 'images'
