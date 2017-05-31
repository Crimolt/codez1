var gulp = require('gulp')
var shell = require('gulp-shell')

gulp.task('build', shell.task(['jekyll build']))

gulp.task('default', ['build']);