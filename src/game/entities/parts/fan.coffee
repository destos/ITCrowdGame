ig.module("game.entities.parts.fan")
.requires(
  "game.entities.abstract.part"
).defines =>

  @EntityFan = @EntityAbstractpart.extend
    size:
      x: 10
      y: 9
      
    offset:
      x: 2
      y: 2
      
    # Main sprite
    animSheet: new ig.AnimationSheet("media/entities/parts/fan.png", 14, 13)
    partType: 'fan'
    init: (x, y, settings) ->
      @parent x, y, settings
      
    update: ->
      @parent()
