ig.module("game.entities.emitters.electrifiedgizmo")
.requires(
  "game.entities.particles.emitter"
  "game.entities.particles.spark"
).defines =>
  @ElectrifiedGizmo = @ParticleEmitter.extend
    # emitterLife: 4
    init: (owner) ->
      @parent owner
      @setParticleData
        class: EntitySparkParticle
        spawnTime: 0.15
        # lifeMin: 1.0
        # lifeMax: 1.0
        emitAngleMin: -90
        emitAngleMax: 90
        emitStrengthMin: 20
        emitStrengthMax: 30
        posOffsetMin:
          x: 3
          y: -3
        
        posOffsetMax:
          x: 5
          y: -10
        
        accelMin:
          x: -20
          y: 10
        
        accelMax:
          x: 20
          y: 30

    emit: ->
      @pos.x = @owner.pos.x
      @pos.y = @owner.pos.y
      
      @parent()
    
    