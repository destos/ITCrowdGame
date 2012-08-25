ig.module('game.data.effects.effect').defines =>
  @Effect = ig.Class.extend
    target: null
    owner: null
    type: ""
    init: (target, owner) ->
      @target = target
      @owner = owner
    update: ->
    removeFromTarget: ->
      if @target is null
        return
      @target.removeEffect(@)
