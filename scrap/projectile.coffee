ig.module("game.entities.projectile")
.requires(
  "impact.entity"
  "plugins.box2d.entity"
).defines =>
  @EntityProjectile = ig.Box2DEntity.extend
    size:
      x: 8
      y: 4

    type: ig.Entity.TYPE.NONE
    checkAgainst: ig.Entity.TYPE.B
    collides: ig.Entity.COLLIDES.NEVER
    animSheet: new ig.AnimationSheet("media/projectile.png", 8, 4)
    init: (x, y, settings) ->
      @parent x, y, settings
      @addAnim "idle", 1, [ 0 ]
      @currentAnim.flip.x = settings.flip
      velocity = (if settings.flip then -40 else 40)
      @body.ApplyImpulse new b2.Vec2(velocity, 0), @body.GetPosition()
