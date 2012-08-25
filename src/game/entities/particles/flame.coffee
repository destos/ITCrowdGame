ig.module("game.entities.particles.flame")
.requires("game.entities.particles.particle").defines =>
  @EntityFlameParticle = EntityParticle.extend
    animSheet: new ig.AnimationSheet("media/effects/spell-fireball.png", 20, 20)
    size:
      x: 12
      y: 14

    offset:
      x: 8
      y: 3

    maxVel:
      x: 100
      y: 100

    friction:
      x: 100
      y: 0

    gravityFactor: 0
    init: (x, y, settings) ->
      @parent x, y, settings
      @addAnim "burn", 0.1, [ 8 ]
      @currentAnim.gotoRandomFrame()

    update: ->
      p = @_age / @life
      if p < 0.5
        @currentAnim.alpha = p
      else
        @currentAnim.alpha = 1 - p
      @parent()