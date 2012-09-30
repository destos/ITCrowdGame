ig.module("game.entities.abstract.part")
.requires(
  "impact.entity"
  "game.entities.emitters.electrifiedgizmo"
).defines =>

  @EntityAbstractpart = ig.Entity.extend
    size:
      x: 12
      y: 12
    offset:
      x: 0
      y: -2
    
    maxVel:
      x: 80
      y: 300
    friction:
      x: 600
      y: 0
    
    partType: 'generic'
    
    checkAgainst: ig.Entity.TYPE.A
    collides: ig.Entity.COLLIDES.LITE
    
    # Main sprite
    # animSheet: new ig.AnimationSheet("media/entities/parts/generic.png", 12, 48)
    pickup: new ig.Sound('media/sounds/part_pickup.ogg')
    flip: false
    
    _sparkTimer: null
    _sparkOffset: null
    
    init: (x, y, settings) ->
      @parent x, y, settings
      
      @addAnim 'idle', 1, [0]
      @addAnim 'glow', 0.1, [0,1,2,3,3,3,2,1,0,0,0,0,0]
      @currentAnim = @anims.glow
      @currentAnim.gotoRandomFrame();
      
      @_electrifiedGizmo = new ElectrifiedGizmo @
      @_sparkTimer = new ig.Timer()
      @sparkReset()
      return @
    
    sparkReset: ->
      @_sparkTimer.reset()
      @_sparkOffset = (Math.random() * 15).floor()
        
    update: ->
      @parent()
      if @_sparkTimer.delta() >= @_sparkOffset
        @sparkReset()
        @_electrifiedGizmo.emit()
        
    check: (other) ->
      # play collection animation and velocity then kill
      # if other is 
      @pickup.play()
      # @collides = ig.Entity.COLLIDES.NEVER
      @kill()
      # other.addPart?(@partType)
      # @popoff()
      
    # update: ->
      # @currentAnim.flip.x = @flip
      # @parent()
      
    # popoff: ->
      