ig.module("game.entities.emitters.damagegizmo")
.requires(
  "game.entities.particles.emitter"
  "game.entities.particles.damagenumber"
).defines =>
  @DamageGizmo = @ParticleEmitter.extend
    damage: 0
    init: (owner) ->
      @parent owner
      @setParticleData
        class: EntityDamageNumber
        spawnTime: 0.15
        lifeMin: 1.0
        lifeMax: 1.0
        emitAngleMin: -110
        emitAngleMax: -70
        emitStrengthMin: 50
        emitStrengthMax: 50
        posOffsetMin:
          x: 0
          y: -4

        posOffsetMax:
          x: 0
          y: -6

        accelMin:
          x: 0
          y: 0

        accelMax:
          x: 0
          y: 0

    emit: ->
      return  if @damage <= 0
      @pos.x = @owner.pos.x
      @pos.y = @owner.pos.y
      @customData = @damage.floor()
      @parent()
      @damage = 0