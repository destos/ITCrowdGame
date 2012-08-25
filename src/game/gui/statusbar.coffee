ig.module('game.gui.statusbar')
.requires('impact.impact').defines =>
  @StatusBar = ig.Class.extend
    maxValue: 100
    value: 100
    barImage: null
    _trackImage: null
    init: ->
      @trackImage = new ig.Image("media/gui/status-bar-track.png")
    draw: (x,y) ->
      @trackImage.draw(x,y)
      if this.barImage?
        offset = 1
        fillWidth = @barImage.width * @value / @maxValue
        @barImage.draw(x + offset, y + offset, 0, 0, fillWidth) if fillWidth >= 1
      return undefined