# TODO, pull number presentation out into a number emiter
ig.module("game.entities.particles.number")
.requires("game.entities.particles.particle").defines =>
  @EntityNumber = @EntityParticle.extend
    _canvas: ig.$new("canvas")
    _textWidth: 0
    gravityFactor: 0.25
    strokeStyle: '#000000'
    fillStyle: '#ffffff'
    init: (x, y, settings) ->
      @parent x, y, settings
      @_drawText()

    update: ->
      @parent()

    _drawText: ->
      context = @_canvas.getContext("2d")
      @_canvas.width = 50
      @_canvas.height = 20
      strDmg = "-" + @data
      context.clearRect 0, 0, @_canvas.width, @_canvas.height
      if @data > 0
        context.strokeStyle = @strokeStyle
        context.fillStyle = @fillStyle
        context.font = "bold 12px Arial"
        context.textBaseline = "top"
        context.lineWidth = 3
        context.strokeText strDmg, 0, 0
        context.fillText strDmg, 0, 0
        @_textWidth = context.measureText(strDmg).width

    draw: ->
      if @data > 0
        px = ig.system.getDrawPos(@pos.x + @_textWidth * 0.25 - ig.game.screen.x)
        py = ig.system.getDrawPos(@pos.y - ig.game.screen.y)
        ig.system.context.globalAlpha = 1 - (@_age / @life)
        ig.system.context.drawImage @_canvas, px, py
        ig.system.context.globalAlpha = 1.0
        @parent()
