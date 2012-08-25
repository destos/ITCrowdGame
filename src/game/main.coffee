ig.module("game.main")
.requires(
  "impact.game"
  "impact.font"
  "game.entities.player"
  "game.entities.moss"
  # "game.entities.crate"
  # "game.levels.test"
  "levels.office"
  # "game.levels.max"
  "game.camera"
  # "plugins.box2d.game"
  # "plugins.box2d.debug"
  "impact.debug.debug"
  "game.gui.gui"
).defines ->
  MyGame = ig.Game.extend(
    gravity: 300
    font: new ig.Font("media/04b03.font.png")
    clearColor: "#1b2026"
    init: ->
      
      # GUI
      @gui = new GUI()
      
      # debugger
      # @gui.player = @getEntityByName("player")
      
      # @gui.player = @getEntitiesByType(EntityMoss)[0]
      
      # Controls
      ig.input.bind ig.KEY.LEFT_ARROW, "left"
      ig.input.bind ig.KEY.UP_ARROW, "jump"
      ig.input.bind ig.KEY.RIGHT_ARROW, "right"
      ig.input.bind ig.KEY.X, "jet"
      ig.input.bind ig.KEY.C, "shoot"
      # if ig.ua.mobile
      #   ig.input.bindTouch "#buttonLeft", "left"
      #   ig.input.bindTouch "#buttonRight", "right"
      #   ig.input.bindTouch "#buttonShoot", "shoot"
      #   ig.input.bindTouch "#buttonJump", "jump"
      # Load the LevelTest as required above ('game.level.test')
      @loadLevel LevelOffice
      
      # @debugDrawer = new ig.Box2DDebug( ig.world )

    loadLevel: (data) ->
      @parent data
      i = 0

      while i < @backgroundMaps.length
        @backgroundMaps[i].preRender = true
        i++
      
      # attach player to gui after level load
      @gui.player = @getEntitiesByType(EntityMoss)[0]

    update: ->
      # Update all entities and BackgroundMaps
      @parent()
      
      # Update GUI
      @gui.update()
      
      player = @getEntitiesByType(EntityMoss)[0]
      if player
        @screen.x = player.pos.x - ig.system.width / 2
        @screen.y = player.pos.y - ig.system.height / 2
        
    draw: ->
      # Paused
      return if @paused
      
      # Draw all entities and BackgroundMaps
      @parent()
      # Draw gui
      @gui.draw()
      # @font.draw "Arrow Keys, X, C", 2, 2  unless ig.ua.mobile
      # @debugDrawer.draw()
  )
  # if ig.ua.iPad
  #   ig.Sound.enabled = false
  #   ig.main "#canvas", MyGame, 60, 240, 160, 2
  # else if ig.ua.mobile
  #   ig.Sound.enabled = false
  #   width = 320
  #   height = 320
  #   ig.main "#canvas", MyGame, 60, 160, 160, 1
  #   c = ig.$("#canvas")
  #   c.width = width
  #   c.height = height
  #   # ig.ua.pixelRatio;
  #   pr = 2
  #   unless pr is 1
  #   # c.style.width = (width / pr) + 'px';
  #   # c.style.height = (height / pr) + 'px';
  #   
  #     c.style.webkitTransformOrigin = "left top"
  #     c.style.webkitTransform = "scale3d(2,2, 0)" + ""
  #       # 'translate3d('+(width / (4 * pr))+'px, '+(height / (4 * pr))+'px, 0)' + 
  #       # 'scale3d('+pr+', '+pr+', 0)' +
  #     
  #   # //~ ig.system.canvas.style.width = '320px';
  #   # //~ ig.system.canvas.style.height = '320px';
  #   # //~ ig.$('#body').style.height = '800px';
  #   #   
  #   #     //~ 320
  #   #  //~ 80 480  80 // div 320/1.5 = 213
  #   # //~ 160 640 160 // div 320/2 = 160
  #     
  # else
  
  # LoaderClass = null
  # debugger
  #force baked, cuz it is
  # ig.baked = true
  
  ig.main "#canvas", MyGame, 40, 320, 240, 2 #, LoaderClass