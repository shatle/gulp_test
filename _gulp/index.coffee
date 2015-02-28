gulp = require('gulp')
sass = require('gulp-ruby-sass')
cssmin = require('gulp-cssmin')
jsmin = require('gulp-jsmin')
rename = require('gulp-rename')
concat = require('gulp-concat')
coffee = require('gulp-coffee')
util = require('gulp-util')
# 
config = {
  "style": {
    "scss": "src/scss/",
    "dest": "build/assets/css/"
  },
  "js": {
    "coffee": "src/coffee/*.coffee",
    "dest": "build/assets/js/"
  },
  "html": {
    "src": "src/index.html",
    "dest": "build/"
  }
}
# compile scss
gulp.task('style', ->
  sass(config.style.scss, { style: 'expanded' })
    .pipe(gulp.dest(config.style.dest))
    .pipe(rename({suffix: '.min'}))
    .pipe(cssmin())
    .pipe(gulp.dest(config.style.dest))
)
# compile coffeescript
gulp.task('js', ->
  gulp.src(config.js.coffee)
    .pipe(coffee({bare: true}).on('error', util.log))
    .pipe(gulp.dest(config.js.dest))
    .pipe(rename({suffix: '.min'}))
    .pipe(jsmin())
    .pipe(gulp.dest(config.js.dest))
)
# move main html
gulp.task('html', ->
  gulp.src(config.html.src)
    .pipe(gulp.dest(config.html.dest))
)