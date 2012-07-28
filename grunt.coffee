module.exports = (grunt) ->
  
  grunt.loadNpmTasks 'grunt-contrib'
  
  grunt.initConfig
    # cleanout client dir
    clean: ['client/']
    
    #pull together all game files
    coffee:
      compile:
        options:
          bare: true
        files:
          'client/lib/game.js': ['src/**/*.coffee']
    
    concat:
      'client/lib/impact/impact.js': ['ImpactJS/lib/impact/impact.js', 'ImpactJS/lib/impact/*.js']
    
    # copy over weltmeister files
    copy:
      default:
        files:
          "client": "ImpactJS/weltmeister.html"
          "client/lib/weltmeister": "ImpactJS/lib/weltmeister/*"
    
    jade:
      default:
        files:
          'client/index.html': "src/index.jade"
      
  grunt.registerTask 'default', 'clean coffee concat copy jade'
  grunt.registerTask 'cleanup', 'clean'