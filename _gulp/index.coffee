gulp = require('gulp')
sass = require('gulp-ruby-sass')
cssmin = require('gulp-cssmin')
jsmin = require('gulp-jsmin')
htmlmin = require('gulp-htmlmin')
rename = require('gulp-rename')
concat = require('gulp-concat')
coffee = require('gulp-coffee')
util = require('gulp-util')
del = require('del')
livereload = require 'gulp-livereload'
connect = require 'gulp-connect'
# 
config = {
  "base": 'src/base/',
  "src": "src/",
  "build": "build/",
  "style": {
    "base": 'src/base/css/'
    "scss": "src/scss/app.scss",
    "dest": "build/assets/css/"
  },
  "js": {
    "base": 'src/base/js/'
    "coffee": "src/coffee/*.coffee",
    "dest": "build/assets/js/"
  },
  "index": {
    "src": "src/index.html",
    "dest": "build/"
  },
  "templates": {
    "src": "src/templates/*.html",
    "dest": "build/templates/"
  }
}

# compile scss
gulp.task('style', ->
  # del([config.style.dest])
  sass(config.style.scss, { style: 'expanded' })
    .pipe(gulp.dest(config.style.dest))
    # .pipe(rename({suffix: '.min'}))
    # .pipe(cssmin())
    # .pipe(gulp.dest(config.style.dest))
    .pipe connect.reload()
)

# compile coffeescript
gulp.task('js', ->
  # del([config.js.dest])
  gulp.src(config.js.coffee)
    .pipe(coffee({bare: true}).on('error', util.log))
    .pipe(gulp.dest(config.js.dest))
    # .pipe(rename({suffix: '.min'}))
    # .pipe(jsmin())
    # .pipe(gulp.dest(config.js.dest))
    .pipe connect.reload()
)
# move main html
gulp.task('index', ->
  gulp.src(config.index.src)
    .pipe(gulp.dest(config.index.dest))
    # .pipe(rename({suffix: '.min'}))
    # .pipe(htmlmin({collapseWhitespace: true}))
    # .pipe(gulp.dest(config.index.dest))
    .pipe connect.reload()
)
gulp.task('templates', ->
  gulp.src(config.templates.src)
    .pipe(gulp.dest(config.templates.dest))
    # .pipe(rename({suffix: '.min'}))
    # .pipe(htmlmin({collapseWhitespace: true}))
    # .pipe(gulp.dest(config.templates.dest))
    .pipe connect.reload()
)
# watch
gulp.task 'watch', ()->
  gulp.watch config.src+'/**/*.scss', ['style']
  gulp.watch config.src+'/**/*.coffee', ['js']
  gulp.watch config.templates.src+'*.html', ['templates']
  gulp.watch config.html.src, ['index']
# server
gulp.task 'server', ()->
  connect.server({
    root: ['build'],
    port: '8888',
    livereload: true
  });

# copy base files
gulp.task 'base', ()->
  gulp.src(config.style.base+'*.css').pipe gulp.dest(config.style.dest)
  gulp.src(config.js.base+'*.js').pipe gulp.dest(config.js.dest)
  gulp.src(config.base+'fonts/*').pipe gulp.dest(config.build+'assets/fonts/')

# default
gulp.task "default", ['server', 'watch']
# build
gulp.task "build", ['base', 'style', 'js', 'index', 'templates']
