ig.module("game.data.attributes")
.requires("impact.impact").defines =>
  @Attributes = ig.Class.extend
    health: 100
    healthMin: 0
    healthMax: 100
    healthRegen: 20
    mana: 100
    manaMin: 0
    manaMax: 100
    manaRegen: 20
    init: ->
      @mana = @manaMax

    increment: (attribute, amount) ->
      return  if isNaN(amount) or typeof this[attribute] is `undefined`
      currValue = this[attribute]
      newValue = currValue + amount
      minValue = this[attribute + "Min"]
      maxValue = this[attribute + "Max"]
      newValue = minValue  if minValue isnt `undefined` and newValue < minValue
      newValue = maxValue  if maxValue isnt `undefined` and newValue > maxValue
      this[attribute] = newValue