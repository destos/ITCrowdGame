ig.module("game.data.effects.drainhealth")
.requires("game.data.effects.timedeffect").defines =>
  @DrainHealthEffect = @TimedEffect.extend
    _amount: 0
    _time: 0
    init: (target, owner, time, amount) ->
      @parent target, owner
      @type = "drainHealth"
      @_amount = amount
      @_time = time
      @_timer.set @_time

    execute: ->
      return  unless @target?
      @target.receiveDamage @_amount * ig.system.tick, @owner