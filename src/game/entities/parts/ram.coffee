ig.module("game.entities.parts.ram")
.requires(
  "game.entities.parts.genericpart"
).defines =>

  @EntityRam = @EntityGenericpart.extend
    # Main sprite
    animSheet: new ig.AnimationSheet("media/entities/parts/ram.png", 12, 12)
    partType: 'ram'
    init: (x, y, settings) ->
      @parent x, y, settings
      
    update: ->
      @parent()
