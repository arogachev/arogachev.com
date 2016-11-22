var gulp = require('gulp');
var sass = require('gulp-sass');

gulp.task('sass', function () {
    gulp.src('./_assets/scss/**/*.scss')
        .pipe(sass({ outputStyle: 'compressed' }))
        .pipe(gulp.dest('./assets/css'));
});
