module.exports = function(grunt) {

    grunt.initConfig({

        pkg: grunt.file.readJSON('package.json'),

        compass: {
            dist: {
                options: {
                    sassDir: 'app/assets/stylesheets',
                    cssDir: 'app/assets/stylesheets',
                    require: ['susy','breakpoint'],
                    outputStyle: 'expanded'
                }
            }
        },

        autoprefixer: {
            options: {
                browsers: ['last 2 version']
            },
            multiple_files: {
                expand: true,
                flatten: true,
                src: 'app/assets/stylesheets/*.css',
                dest: 'app/assets/stylesheets'
            }
        },

        cssmin: {
            combine: {
                options: {
                    keepSpecialComments: 0
                },
                files: {
                    'app/assets/stylesheets/global.css': ['app/assets/stylesheets/global.css']
                }
            }
        },

        jshint: {
            beforeconcat: ['js/*.js']
        },

        concat: {
            dist: {
                src: [
                    'js/vendor/*.js',
                    'js/main.js'
                ],
                dest: 'js/build/production.js'
            }
        },

        uglify: {
            build: {
                src: 'js/build/production.js',
                dest: 'js/build/production.min.js'
            }
        },

        imagemin: {
            dynamic: {
                files: [{
                    expand: true,
                    cwd: 'img/',
                    src: ['**/*.{png,jpg,gif}'],
                    dest: 'img/'
                }]
            }
        },

        watch: {
            options: {
                livereload: true,
            },
            html: {
                files: ['index.html'],
                options: {
                    spawn: false,
                }
            },
            // scripts: {
            //     files: ['js/*.js'],
            //     tasks: ['concat', 'uglify', 'jshint'],
            //     options: {
            //         spawn: false,
            //     }
            // },
            css: {
                files: ['app/assets/stylesheets/**/*.scss'],
                tasks: ['compass', 'autoprefixer', 'cssmin'],
                options: {
                    spawn: false,
                }
            },
            // images: {
            //     files: ['img/**/*.{png,jpg,gif}', 'img/*.{png,jpg,gif}'],
            //     tasks: ['imagemin'],
            //     options: {
            //         spawn: false,
            //     }
            // }
        },

        browserSync: {
            dev: {
                bsFiles: {
                    src : 'app/assets/stylesheets/*.css'
                },
                options: {
                    watchTask: true,
                    proxy: {
                        host: 'localhost',
                        port: '3000'
                    },
                    ghostMode: {
                        clicks: true,
                        scroll: true,
                        links: true,
                        forms: true
                    }
                }
            }
        },

        connect: {
            server: {
                options: {
                    port: 8000,
                    base: './'
                }
            }
        },

    });

    require('load-grunt-tasks')(grunt);

    // Default Task is basically a rebuild
    grunt.registerTask('default', ['compass', 'autoprefixer', 'cssmin']);

    grunt.registerTask('debug', ['compass', 'autoprefixer']);

    grunt.registerTask('dev', ['watch']);

};