ig.module('game.data.effects.timedeffect')
.requires('game.data.effects.effect').defines =>
  @TimedEffect = @Effect.extend
    _timer: null
    init: (target, owner) ->
      @parent(target, owner)
      @_timer = new ig.Timer()
    update: ->
      if (@_timer.delta() >= 0)
        @removeFromTarget()
        return
      @execute()
    execute: ->