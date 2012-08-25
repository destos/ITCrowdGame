impact_dir = 'ImpactJS'

module.exports = (grunt) ->
  
  grunt.loadNpmTasks 'grunt-contrib'
  # overload coffee script tasks from contrib
  grunt.loadNpmTasks 'grunt-coffee'
  # working on impact specific tasks for eventually baking impact game.
  # grunt.loadNpmTasks 'grunt-impact'
  
  grunt.initConfig
    clean:
      game: ['client/lib/game', '!client/lib/game/levels']
      impact: ['client/lib/impact']
      weltmeister: ['client/lib/weltmeister', 'client/weltmeister.html']
      # client: ['client/']
    
    #pull together all game files
    # coffee:
    #   compile:
    #     options:
    #       bare: true
    #     files:
    #       'client/lib/game/main.js': ['src/game/main.coffee', 'src/game/**/*.coffee']
    
    # concat:
      # 'client/lib/impact/impact.js': ['ImpactJS/lib/impact/impact.js', 'ImpactJS/lib/impact/*.js']
    
    # copy over weltmeister files
    copy:
      weltmeister:
        files:
          "client": "#{impact_dir}/weltmeister.html"
          "client/lib/weltmeister": "#{impact_dir}/lib/weltmeister/*"
      impact:
        files:
          "client/lib/impact": "#{impact_dir}/lib/impact"
      
      backupLevels:
        files:
          'backup/levels': 'client/lib/game/levels'
      restoreLevels:
        files:
          'client/lib/game/levels': 'backup/levels'
          
    # jade:
    #   default:
    #     files:
    #       'client/index.html': "src/index.jade"
    
    coffee:
      gameSrc:
        options:
          bare: true
          preserve_dirs: true
          base_path: 'src/game'
        src: ["src/game/**/*.coffee"]
        dest: "client/lib/game"
    
    # watch:
    #   files: ['src/game/**/*.coffee']
    #   tasks: 'default'
      
    watch:
      gameSrc:
        files: ['src/game/**/*.coffee']
        tasks: 'gameBuild'
      # impactSrc:
      #   files: ['ImpactJS/**/*.js']
      #   tasks: 'debug'
        
  grunt.registerTask 'cleanup', 'clean'
  
  # Game Specific tasks
  grunt.registerTask 'gameWatch', 'watch:gameSrc'
  grunt.registerTask 'gameBuild', 'clean:game coffee:gameSrc'
  
  # ImpactJS source related tasks
  
  # grunt.registerTask 'impact', 'jade concat copy'
  # grunt.registerTask 'build', 'cleanup default impact'
  # grunt.registerTask 'bakeit', ''