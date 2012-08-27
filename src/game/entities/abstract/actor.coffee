ig.module("game.entities.abstract.actor")
.requires(
  "impact.entity"
  "game.data.attributes"
  # "game.data.inventory"
  "game.entities.emitters.damagegizmo"
).defines =>
  @EntityActor = ig.Entity.extend(
    collides: ig.Entity.COLLIDES.PASSIVE
    type: ig.Entity.TYPE.A
    attributes: null
    # inventory: null
    emitters: []
    # _apparelByType: {}
    # _animDefinitions: []
    _currentAnim: ""
    _dir: 1
    _effects: []
    _shadow: null
    init: (x, y, settings) ->
      @parent x, y, settings
      @attributes = new Attributes()
      # @inventory = new Inventory()
      for i of settings
        continue  if @attributes[i] is `undefined`
        @attributes[i] = settings[i]
      # unless ig.global.wm
      #   @_applyAnims @animSheet
      # else
      #   @addAnim "wm", 0.1, [ 0 ]
      
      @_damageGizmo = new DamageGizmo @
      @emitters.push(@_damageGizmo)

    update: ->
      @parent()
      # for i of @_apparelByType
      #   apparel = @_apparelByType[i]
      #   anim = apparel.anims[@_currentAnim]
      #   anim.gotoFrame @currentAnim.frame
      #   anim.flip.x = @currentAnim.flip.x
      
      # See if we have any effects applied to this actor
      i = 0
      len = @_effects.length

      while i < len
        effect = @_effects[i]
        effect.update()  if effect?
        i++
      
      # See if we have any active emmiters
      i = 0
      len = @emitters.length

      while i < len
        emitter = @emitters[i]
        emitter.emit() if emitter?
        ++i

    draw: ->
      # px = @pos.x - @offset.x - ig.game.screen.x
      # py = @pos.y - @offset.y - ig.game.screen.y
      
      # if @_shadow?
      #   shadowY = 68 - ig.game.screen.y
      #   @_shadow.draw px + 4, shadowY
        
      @parent()
      # for i of Apparel.TYPE
      #   apparel = @_apparelByType[Apparel.TYPE[i]]
      #   continue  unless apparel?
      #   anim = apparel.anims[@_currentAnim]
      #   anim.draw px, py

    receiveDamage: (amount, owner) ->
      @attributes.increment "health", -amount
      @kill()  if @attributes.health <= 0
      @_damageGizmo.damage += amount

    addEffect: (effect, applyEvenIfHasEffect) ->
      applyEvenIfHasEffect = false if applyEvenIfHasEffect is `undefined`
      return  if @hasEffectOfType(effect.type)  unless applyEvenIfHasEffect
      @_effects.push effect

    removeEffect: (effect) ->
      index = @_effects.indexOf(effect)
      return  if index is -1
      @_effects.splice index, 1

    hasEffectOfType: (effectType) ->
      i = 0
      len = @_effects.length

      while i < len
        effect = @_effects[i]
        continue  unless effect?
        return true  if effect.type is effectType
        i++
      false

    # setAnim: (name, flipX, flipY) ->
    #   @_currentAnim = name
    #   @currentAnim = @anims[name]
    #   @currentAnim.flip.x = flipX or @_dir is -1
    #   @currentAnim.flip.y = flipY or false

    hasEmitterOfType: (emitterClass) ->
      i = 0
      len = @emitters.length

      while i < len
        return true if @emitters[i] instanceof emitterClass
        i++
      false

    setDir: (dir) ->
      @_dir = (if dir < 0 then -1 else 1)
      @currentAnim.flip.x = @_dir is -1  if @currentAnim?

    addShadow: ->
      @_shadow = new ig.Animation('media/shadow.png', 1, [ 0 ])

    # addApparel: (apparel) ->
    #   @removeApparel apparel.type
    #   @_apparelByType[apparel.type] = apparel
    # 
    # removeApparel: (type) ->
    #   apparel = @_apparelByType[type]
    #   return  unless apparel?
    #   @_apprelByType[type] = null

    # _applyAnims: (animSheet) ->
    #   i = 0
    #   len = @_animDefinitions.length
    # 
    #   while i < len
    #     def = @_animDefinitions[i]
    #     name = def[0]
    #     time = def[1]
    #     sequence = def[2]
    #     stop = def[3] or false
    #     @anims[name] = new ig.Animation(animSheet, time, sequence, stop)
    #     ++i
  )
  # EntityActor.humanAnimations = [ [ "normal-idle", 0.1, [ 0 ] ], [ "normal-walk", 0.15, [ 0, 1 ] ], [ "casting-idle", 0.1, [ 2 ] ], [ "casting-walk", 0.15, [ 2, 3 ] ] ]