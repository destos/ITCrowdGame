ig.module("game.entities.roy")
.requires(
  "impact.entity"
).defines =>

  @EntityRoy = ig.Entity.extend
    size:
      x: 11
      y: 37
    offset:
      x: 6
      y: 5
    
    maxVel:
      x: 80
      y: 300
    friction:
      x: 600
      y: 0
    
    # Player friendly group
    type: ig.Entity.TYPE.A
    checkAgainst: ig.Entity.TYPE.NONE
    collides: ig.Entity.COLLIDES.PASSIVE
    
    # Main sprite
    animSheet: new ig.AnimationSheet("media/entities/char/roy.png", 24, 42)
    
    health: 10
    
    accelGround: 300
    accelAir: 200
    jump: 150
    flip: false
    
    init: (x, y, settings) ->
      @parent x, y, settings
      @addAnim 'idle', 1, [0]
    update: ->
      @currentAnim = @anims.idle
      @currentAnim.flip.x = @flip
      @parent()
