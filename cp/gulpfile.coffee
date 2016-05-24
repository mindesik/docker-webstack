Promise = require('es6-promise').Promise
gulp = require('gulp')
uglify = require('gulp-uglify')
coffee = require('gulp-coffee')

gulp.task('assets', ['coffee'])

gulp.task 'coffee', ->
    gulp.src('resources/assets/coffee/**/*').pipe(coffee(bare: true)).pipe(gulp.dest('public/js'))

gulp.task 'default', ->
    gulp.watch(['resources/assets/coffee/**/*'], ['coffee'])