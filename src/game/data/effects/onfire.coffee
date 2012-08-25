ig.module("game.data.effects.onfire")
.requires(
  "game.data.effects.drainhealth"
  "game.entities.emitters.burneffect"
).defines =>
  @OnFireEffect = @DrainHealthEffect.extend
    _emitter: null
    init: (target, owner, time, amount) ->
      @parent target, owner, time, amount
      @type = "onFire"
      @_emitter = new BurnEffect(target, owner, time, amount)

    execute: ->
      @parent()
      @_emitter.emit()