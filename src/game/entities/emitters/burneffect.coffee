ig.module("game.entities.emitters.burneffect")
.requires(2
  "game.entities.particles.emitter"
  "game.entities.particles.flame"
).defines =>
  @BurnEffect = @ParticleEmitter.extend
    target: null
    init: (target, owner, burnTime, damagePerSecond) ->
      @parent()
      @target = target
      @damage = damagePerSecond
      @emitterLife = burnTime
      @setParticleData
        class: EntityFlameParticle
        spawnTime: 0.1
        lifeMin: 0.25
        lifeMax: 0.5
        emitAngleMin: -90
        emitAngleMax: -90
        emitStrengthMin: 1
        emitStrengthMax: 10
        posOffsetMin:
          x: -2
          y: -3

        posOffsetMax:
          x: 2
          y: 5

        accelMin:
          x: 0
          y: -60

        accelMax:
          x: 0
          y: -30

    emit: ->
      if @target?
        @pos.x = @target.pos.x
        @pos.y = @target.pos.y
      @parent()

    died: ->
      if @target?
        i = @target.emitters.indexOf(this)
        @target.emitters.splice i, 1  if i >= -1
        @target = null
      @parent()