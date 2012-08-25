ig.module("game.gui.itemslot")
.requires("impact.impact").defines =>
  ItemSlot = ig.Class.extend(
    _image: null
    _imageSelected: null
    _font: null
    item: null
    selected: false
    width: 16
    height: 16
    quantity: 1
    init: ->
      @_image = ig.game.assets.img_itemSlot
      @_imageSelected = ig.game.assets.img_itemSlotSelected
      @_font = ig.game.assets.font

    draw: (x, y) ->
      if @selected
        @_imageSelected.draw x, y
      else
        @_image.draw x, y
      @item.icon.draw x + 2, y + 2  if @item?
      @_font.draw @quantity, x + @_image.width - 1, y + @_image.height - @_font.height + 2, ig.Font.ALIGN.RIGHT  if @quantity > 1
  )