ig.module("game.data.inventory")
.requires("impact.impact").defines =>
  @Inventory = ig.Class.extend
    _quickSlots: []
    _numQuickSlots: 10
    init: ->

    getQuickSlot: (index) ->
      return null  if index < 0 or index >= @_numQuickSlots
      @_quickSlots[index]

    setQuickSlot: (index, item) ->
      return  if index < 0 or index >= @_numQuickSlots
      @_quickSlots[index] = item