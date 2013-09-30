module.exports = (grunt) ->
  application_name = "test"
  grunt.initConfig
    pkg: grunt.file.readJSON('package.json')

    develop:
      server:
        file:
          'server.js'

    stylus:
      options:
        paths: ['node_modules/grunt-contrib-stylus/node_modules', 'node_modules/fluidity/lib']

      compile_dev:
        expand: true
        cwd: 'src/assets/stylus'
        src: ['**/*']
        dest: 'app/public/css/'
        ext: '.css'
        options:
          compress: false

      compile_build:
        options:
          compress: true
        files:
          'app/public/css/build.css' :  ['src/assets/stylus/**/*.styl']

    styleguide:
      dist:
        files:
          'app/public/styleguide': 'src/assets/stylus/**/*.styl'
        options:
          name: application_name + ' Styleguide'

    coffee:
      compile_app_dev:
        expand: true
        cwd: 'src'
        src: [
          '*.coffee',
          'models/**/*.coffee',
          'controllers/**/*.coffee']
        dest: 'app/'
        ext: '.js'
        options:
          sourceMap: true

      compile_assets_dev:
        expand: true
        cwd: 'src/assets/coffee'
        src: ['**/*']
        dest: 'app/public/js'
        ext: '.js'
        options:
          sourceMap: true

      compile_app_build:
        expand: true
        cwd: 'src/'
        src: [
          'application.coffee',
          'models/**/*.coffee',
          'controllers/**/*.coffee']
        dest: 'app/'
        ext: '.js'
        options:
          sourceMap: false

      compile_assets_build:
        expand: true
        cwd: 'src/assets/coffee'
        src: ['**/*.coffee']
        dest: 'app/public/js/'
        ext: '.js'
        options:
          sourceMap: false

    coffeelint:
      lintall: ['src/**/*.coffee']

    docco:
      debug:
        src: ['src/**/*.coffee']
        options:
          output: 'app/public/docs/'
          template: 'app/public/docs/docstemplate/mydocco.jst'
          css: 'app/public/docs/docstemplate/mydocco.css'

    concat:
      options:
        seperator: ';'
      components:
        src: ['app/public/components/zepto/zepto.js', 'app/public/components/fluidity-ui/fluidity.js']
        dest : 'tmp/components-concat.js'
      assets:
        src: ['app/public/js/**/*.js']
        dest : 'tmp/asset-concat.js'
      build:
        src: ['tmp/components-concat.js', 'tmp/asset-concat.js']
        dest : 'app/public/js/build-concat.js'

    uglify:
      js:
        files:
          'app/public/js/build.min.js': 'app/public/js/build-concat.js'

    cssmin:
      css:
        files:
          'app/public/css/build.min.css': 'app/public/css/build.css'

    clean:
      all:
        src:
          ['app/public/css/**/*',
           'app/public/js/**/*',
           'app/*.js',
           'app/*.map',
           'tmp/**/*',
           'app/models/**/*',
           'app/views/**/*',
           'app/controllers/**/*']
        filter: 'isFile'

      build:
        src:
          ['app/public/css/**/*',
           'app/public/js/**/*',
           '!app/public/css/build.min.css',
           '!app/public/js/build.min.js',
           'tmp/**/*',
           'app/**/*.map']
        filter: 'isFile'

      styleguide:
        src:
          ['app/public/styleguide/**/*']
        filter: 'isFile'

      docs:
        src:
          ['app/public/docs/**/*','!app/public/docs/docstemplate/**/*' ]
        filter: 'isFile'

    delayed_reload:
      server_restart:
        wait: 400

    watch:
      coffee_app:
        files: ['src/**/*.coffee','!src/assets/coffee/**/*']
        tasks: [
          'coffee:compile_app_dev',
          'docco',
          'develop',
          'delayed_reload']
        options:
          nospawn: true
          livereload:true

      coffee_assets:
        files: ['src/assets/coffee/**/*']
        tasks: ['coffee:compile_assets_dev', 'docco']
        options:
          livereload: true

      stylus:
        files: ['src/assets/stylus/**/*' ]
        tasks: ['stylus:compile_dev', 'makedoc']
        options:
          livereload: true

      jade:
        files: ['src/views/**/*.jade']
        tasks: ['develop']
        options:
          livereload: true

    rerun:
      dev:
        options:
          tasks: ['develop']
    env:
      dev:
        NODE_ENV: 'development'
      build:
        NODE_ENV: 'production'

  grunt.loadNpmTasks 'grunt-develop'
  grunt.loadNpmTasks 'grunt-contrib-watch'
  grunt.loadNpmTasks 'grunt-env'

  grunt.loadNpmTasks 'grunt-contrib-stylus'
  grunt.loadNpmTasks 'grunt-styleguide'

  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-coffeelint'
  grunt.loadNpmTasks 'grunt-docco'

  grunt.loadNpmTasks 'grunt-contrib-concat'
  grunt.loadNpmTasks 'grunt-contrib-uglify'
  grunt.loadNpmTasks 'grunt-contrib-cssmin'
  grunt.loadNpmTasks 'grunt-contrib-clean'

  grunt.registerMultiTask 'delayed_reload', "A delayed emission of 'livereload' event", ->
    wait = this.data.wait or 250
    fail = this.data.fail or false
    done = this.async()
    setTimeout ->
      if (fail)
         grunt.fail.fatal("Delayed Reload Failed", fail)
      else
        grunt.event.emit('livereload')
        done()
    , wait

  grunt.registerTask 'default', ['dev']
  grunt.registerTask 'cleandoc', ['clean:styleguide','clean:docs']
  grunt.registerTask 'makedoc', ['cleandoc', 'styleguide', 'docco']

  grunt.registerTask 'dev',
     ['env:dev'
     'clean:all',
     'coffeelint',
     'coffee:compile_app_dev',
     'coffee:compile_assets_dev',
     'stylus:compile_dev',
     'develop',
     'watch']

  grunt.registerTask 'build',
  ['env:build',
   'clean:all',
   'makedoc',
   'coffeelint',
   'coffee:compile_app_build',
   'coffee:compile_assets_build',
   'stylus:compile_build',
   'concat:components',
   'concat:assets',
   'concat:build',
   'uglify',
   'cssmin',
   'clean:build',
   'develop']
