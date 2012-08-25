ig.module("game.gui.gui")
.requires(
  "impact.impact"
  "game.gui.statusbar"
  # "game.gui.itemslot"
).defines =>

  @GUI = ig.Class.extend
    player: null
    manaBar: null
    healthBar: null
    _numQuickSlots: 10
    _quickSlots: []
    _slotSpacing: 0
    _positions: {}
    init: ->
      # @manaBar = new StatusBar()
      # @manaBar.width = 50
      # @manaBar.height = 4
      # @manaBar.barImage = ig.game.assets.img_barMana
      # @_positions.manaBar =
      #   x: ig.system.width * 0.5 - @manaBar.width - 1
      #   y: 2
      
      @healthBar = new StatusBar()
      @healthBar.width = 50
      @healthBar.height = 4
      @healthBar.barImage = new ig.Image("media/gui/bar-health.png")
      @_positions.healthBar =
        x: ig.system.width * 0.5 + 1
        y: 2 
        # y: @_positions.manaBar.y
      # 
      # i = 0
      # 
      # while i < @_numQuickSlots
      #   slot = new ItemSlot()
      #   @_quickSlots.push slot
      #   i++
      # ig.input.bind ig.KEY._1, "quick1"
      # ig.input.bind ig.KEY._2, "quick2"
      # ig.input.bind ig.KEY._3, "quick3"
      # ig.input.bind ig.KEY._4, "quick4"
      # ig.input.bind ig.KEY._5, "quick5"
      # ig.input.bind ig.KEY._6, "quick6"
      # ig.input.bind ig.KEY._7, "quick7"
      # ig.input.bind ig.KEY._8, "quick8"
      # ig.input.bind ig.KEY._9, "quick9"
      # ig.input.bind ig.KEY._0, "quick10"
      # ig.input.bind ig.KEY.Z, "cycleSpell1"
      # ig.input.bind ig.KEY.C, "cycleSpell2"

    update: ->
      if @player?
        @healthBar.maxValue = @player.attributes.healthMax
        @healthBar.value = @player.attributes.health
        
      # @manaBar.maxValue = @player.attributes.manaMax
      # @manaBar.value = @player.attributes.mana
      # @_activateSlot 0  if ig.input.pressed("quick1")
      # @_activateSlot 1  if ig.input.pressed("quick2")
      # @_activateSlot 2  if ig.input.pressed("quick3")
      # @_activateSlot 3  if ig.input.pressed("quick4")
      # @_activateSlot 4  if ig.input.pressed("quick5")
      # @_activateSlot 5  if ig.input.pressed("quick6")
      # @_activateSlot 6  if ig.input.pressed("quick7")
      # @_activateSlot 7  if ig.input.pressed("quick8")
      # @_activateSlot 8  if ig.input.pressed("quick9")
      # @_activateSlot 9  if ig.input.pressed("quick10")
      # @_cycleSpells -1  if ig.input.pressed("cycleSpell1")
      # @_cycleSpells 1  if ig.input.pressed("cycleSpell2")

    # updateQuickSlots: ->
    #   i = 0
    #   len = @_quickSlots.length
    # 
    #   while i < len
    #     slot = @_quickSlots[i]
    #     slot.item = @player.inventory.getQuickSlot(i)
    #     slot.selected = false
    #     slot.selected = true  if @player.spellCaster.getSpell() is slot.item  if slot.item instanceof Spell
    #     ++i

    draw: ->
      for i of @_positions
        target = @[i]
        continue  unless target?
        pos = @_positions[i]
        target.draw pos.x, pos.y
      #   
      # slotAreaWidth = @_quickSlots.length * (@_quickSlots[0].width + @_slotSpacing) - @_slotSpacing
      # tx = Math.floor((ig.system.width - slotAreaWidth) * 0.5)
      # ty = Math.floor(ig.system.height - @_quickSlots[0].height - 2)
      # i = 0
      # len = @_quickSlots.length

      # while i < len
      #   slot = @_quickSlots[i]
      #   slot.draw tx, ty
      #   tx += Math.floor(slot.width + @_slotSpacing)
      #   ++i

    # _activateSlot: (slotNum) ->
    #   slot = @_quickSlots[slotNum]
    #   return  if not slot? or not slot.item?
    #   @player.spellCaster.setSpell slot.item  if slot.item instanceof Spell
    #   @updateQuickSlots()
    # 
    # _cycleSpells: (dir) ->
    #   currIndex = 0
    #   i = 0
    #   len = @_quickSlots.length
    # 
    #   while i < len
    #     if @_quickSlots[i].item is @player.spellCaster.getSpell()
    #       currIndex = i
    #       break
    #     ++i
    #   c = 0
    #   i = currIndex + dir
    #   len = @_quickSlots.length
    # 
    #   while c < len
    #     if i < 0
    #       i = len - 1
    #     else i = 0  if i >= len
    #     item = @_quickSlots[i].item
    #     if item instanceof Spell
    #       @_activateSlot i
    #       break
    #     c++
    #     i += dir
