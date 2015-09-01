browserify     = require "browserify"
watchify       = require "watchify"
coffee_react   = require "coffee-reactify"
gulp           = require "gulp"
jade           = require "gulp-jade"
source         = require "vinyl-source-stream"
styl           = require 'gulp-stylus'
autoprefixer   = require "gulp-autoprefixer"
connect        = require "gulp-connect"

PROD = process.env.ENV is 'PROD'

files =
  html:
    src:   "app/*.jade"
    dest:  "dist/"

  scripts:
    src:   "app/scripts/app.coffee"
    watch: "app/scripts/**/*.coffee"
    main:  "app.js"
    dest:  "dist/scripts/"

  styles:
    src:   "app/styles/app.styl"
    watch: "app/styles/**/*styl"
    dest:  "dist/styles/"

  fonts:
    src:   "app/fonts/*.*"
    dest:  "dist/fonts/"

args =
  extensions: [".coffee", ".js"]
args[k] = v for k,v of watchify.args

b = browserify args
b.add files.scripts.src
b.transform coffee_react

bundler = b

bundle = (ids)->
  bundler.bundle()
    .on "error", (error) -> console.log error
    .pipe source files.scripts.main
    .pipe gulp.dest files.scripts.dest
    .pipe connect.reload()

  if PROD
    js = js.pipe streamify uglify()

gulp.task "scripts", -> bundle

gulp.task "styles", ->
  gulp.src files.styles.src
    .pipe styl
      compress: not PROD
    .pipe autoprefixer 'last 2 versions'
    .pipe gulp.dest files.styles.dest
    .pipe connect.reload()

gulp.task "html", ->
  gulp.src files.html.src
    .pipe jade
      pretty: not PROD
    .pipe gulp.dest files.html.dest
    .pipe connect.reload()

gulp.task 'fonts', ->
  gulp.src files.fonts.src
    .pipe gulp.dest files.fonts.dest

gulp.task "watch", ->
  gulp.watch files.styles.watch, ["styles"]
  gulp.watch files.html.src, ["html"]
  gulp.watch files.fonts.src, ["fonts"]

gulp.task "auto-reload", ["build", "watch"], ->
  # run watchify
  bundler = watchify b
  bundler.on "update", bundle
  bundle()

  # start server
  connect.server
    root: "./dist"
    livereload: true


gulp.task "build",   ["scripts", "styles", "html", "fonts"]
gulp.task "default", ["auto-reload"]
