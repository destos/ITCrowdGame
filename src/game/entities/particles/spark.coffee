ig.module("game.entities.particles.spark")
.requires("game.entities.particles.particle").defines =>
  @EntitySparkParticle = EntityParticle.extend
    animSheet: new ig.AnimationSheet("media/entities/effects/spark.png", 25, 20)
    # life: 1
    size:
      x: 25
      y: 20

    offset:
      x: 0
      y: -2
      
    minVel:
      x: -20
      y: 10
      
    maxVel:
      x: 20
      y: 20

    friction:
      x: 100
      y: 50
      
    # accelMin:
    #   x: -20
    #   y: 10
    # 
    # accelMax:
    #   x: 20
    #   y: 20

    # gravityFactor: 0
    
    init: (x, y, settings) ->
      @parent x, y, settings
      @addAnim "arc", 0.1, [0...6]
      @currentAnim = @anims.arc
      console.log settings
      @currentAnim.flip.x = settings.accel.x > 0
      if @currentAnim.flip.x
        @pos.x = @pos.x - 26
      
    update: ->
      @parent()
      if @currentAnim.frame is 5
        ig.game.removeEntity @ 
      