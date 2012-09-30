ig.module("game.entities.parts.ram")
.requires(
  "game.entities.abstract.part"
).defines =>

  @EntityRam = @EntityAbstractpart.extend
    size:
      x: 7
      y: 5
      
    offset:
      x: 3
      y: 5
      
    # Main sprite
    animSheet: new ig.AnimationSheet("media/entities/parts/ram.png", 12, 12)
    partType: 'ram'
    init: (x, y, settings) ->
      @parent x, y, settings
      
    update: ->
      @parent()
