# Particle
ig.module("game.entities.particles.particle")
.requires("impact.entity").defines =>
  @EntityParticle = ig.Entity.extend(
    collides: ig.Entity.COLLIDES.NEVER
    type: ig.Entity.TYPE.B
    checkAgainst: ig.Entity.TYPE.A
    emitter: null
    life: 2
    _age: 0
    init: (x, y, settings) ->
      @parent x, y, settings

    update: ->
      @_age += ig.system.tick
      ig.game.removeEntity this  if @_age >= @life
      @parent()
  )