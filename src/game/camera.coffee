ig.module("game.camera").defines =>
  @Camera = ig.Class.extend
    trap:
      pos:
        x: 0
        y: 0

      size:
        x: 16
        y: 16

    max:
      x: 0
      y: 0

    offset:
      x: 0
      y: 0

    pos:
      x: 0
      y: 0

    damping: 5
    lookAhead:
      x: 0
      y: 0

    currentLookAhead:
      x: 0
      y: 0

    debug: false
    init: (offsetX, offsetY, damping) ->
      @offset.x = offsetX
      @offset.y = offsetY
      @damping = damping

    set: (entity) ->
      @pos.x = entity.pos.x - @offset.x
      @pos.y = entity.pos.y - @offset.y
      @trap.pos.x = entity.pos.x - @trap.size.x / 2
      @trap.pos.y = entity.pos.y - @trap.size.y

    follow: (entity) ->
      @pos.x = @move("x", entity.pos.x, entity.size.x)
      @pos.y = @move("y", entity.pos.y, entity.size.y)
      ig.game.screen.x = @pos.x
      ig.game.screen.y = @pos.y

    move: (axis, pos, size) ->
      lookAhead = 0
      if pos < @trap.pos[axis]
        @trap.pos[axis] = pos
        @currentLookAhead[axis] = @lookAhead[axis]
      else if pos + size > @trap.pos[axis] + @trap.size[axis]
        @trap.pos[axis] = pos + size - @trap.size[axis]
        @currentLookAhead[axis] = -@lookAhead[axis]
      (@pos[axis] - (@pos[axis] - @trap.pos[axis] + @offset[axis] + @currentLookAhead[axis]) * ig.system.tick * @damping).limit 0, @max[axis]

    draw: ->
      if @debug
        ig.system.context.fillStyle = "rgba(255,0,255,0.3)"
        ig.system.context.fillRect (@trap.pos.x - @pos.x) * ig.system.scale, (@trap.pos.y - @pos.y) * ig.system.scale, @trap.size.x * ig.system.scale, @trap.size.y * ig.system.scale