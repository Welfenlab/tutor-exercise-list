var gulp        = require('gulp');
var source      = require('vinyl-source-stream');
var browserify  = require('browserify');
var gutil       = require('gulp-util');
var coffee      = require('gulp-coffee');

// browserify bundle for direct browser use.
gulp.task("bundle", function(){
  bundler = browserify('./src/exercise_list.coffee',
    {
      transform: ['coffeeify'],
      standalone: 'exerciseList',
      extensions: ['.coffee'],
      debug: false
    });

  return bundler.bundle()
    .pipe(source('exercise_list.js'))
    .pipe(gulp.dest('dist'));
});

// simple transpile if you want to bundle it yourself
// using this can reduce the size of your own bundle
gulp.task("transpile", function(){
  gulp.src('./src/**/*.coffee')
    .pipe(coffee({bare: true}).on('error', gutil.log))
    .pipe(gulp.dest('./lib/'))
});

gulp.task("build", ["bundle", "transpile"]);

gulp.task("default", ["build"]);
