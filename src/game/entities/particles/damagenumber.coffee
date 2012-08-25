# TODO, pull number presentation out into a number emiter
ig.module("game.entities.particles.damagenumber")
.requires("game.entities.particles.number").defines =>
  @EntityDamageNumber = @EntityNumber.extend
    strokeStyle: '#000000'
    fillStyle: '#cc0000'
    init: (x, y, settings) ->
      @parent x, y, settings