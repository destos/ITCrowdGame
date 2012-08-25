ig.module("game.entities.moss")
.requires(
  "impact.entity"
  # "plugins.box2d.entity"
  "game.entities.abstract.actor"
  # "game.entities.projectile"
).defines =>
  
  @EntityMoss = @EntityActor.extend
    size:
      x: 11
      y: 37
    offset:
      x: 6
      y: 5
    
    maxVel:
      x: 80
      y: 300
    friction:
      x: 800
      y: 0
      
    _damageGizmo: null,
    
    # Player friendly group
    type: ig.Entity.TYPE.A
    checkAgainst: ig.Entity.TYPE.NONE
    collides: ig.Entity.COLLIDES.PASSIVE
    
    # Main sprite
    animSheet: new ig.AnimationSheet("media/moss.png", 24, 42)
    
    # health: 10
    
    accelGround: 300
    accelAir: 200
    jump: 150
    flip: false
    
    init: (x, y, settings) ->
      @parent x, y, settings
      @addAnim 'idle', 1, [0]
      @addAnim 'walk', 0.1, [1...9]
      @addAnim 'duck', 0.1, [0]
      # @addAnim( "jet", 0.10, [ 10, 11 ] )
      @addAnim 'jump', 0.4, [8,9]
      @addAnim 'fall', 0.4, [6,7]
      @addAnim 'push', 0.3, [12...17]
      # @addShadow()
    update: ->
      
      # Move left right
      accel = if @standing then @accelGround else @accelAir
      
      if ig.input.state('left')
        @accel.x = -accel
        @flip = true
      else if ig.input.state('right')
        @accel.x = accel
        @flip = false
        
      else
        @accel.x = 0;
        
      # Jump
      if @standing && ig.input.pressed('jump') 
        @vel.y = -@jump
      
      # set the current animation, based on the player's speed
      if @vel.y < 0
        @currentAnim = @anims.jump
      else if  @vel.y > 0
        @currentAnim = @anims.fall
      else if( @vel.x != 0 )
        @currentAnim = @anims.walk
      else
        @currentAnim = @anims.idle
        
      @currentAnim.flip.x = @flip
      
      # shoot dat gun
      # if ig.input.pressed("shoot")
      #   # debugger
      #   @receiveDamage(2,@)
      #   return
      #   x = @pos.x + (if @flip then -6 else 6)
      #   y = @pos.y + 6
      #   ig.game.spawnEntity EntityProjectile, x, y,
      #     flip: @flip
      
      # move!
      @parent()
      
    collideWith: (other, axis) ->
      if other.collides is ig.Entity.COLLIDES.FIXED and @touches(other)
         overlap = undefined
         size = undefined
         if axis is "y"
           size = @size.y
           if @pos.y < other.pos.y
             overlap = @pos.y + @size.y - other.pos.y
           else
             overlap = @pos.y - (other.pos.y + other.size.y)
         else
           size = @size.x
           if @pos.x < other.pos.x
             overlap = @pos.x + @size.x - other.pos.x
           else
             overlap = @pos.x - (other.pos.x + other.size.x)
         overlap = Math.abs(overlap)
         # if debug is enabled
         console.log @name, "collided with", other.name, "on the", axis, "axis, but they are still overlapping by", overlap, "pixels"  if overlap > 0
         @receiveDamage 1, other  if overlap > size / 2
         
      # # find out if standing
      # # console.log @body.m_contactList
      # edge = @body.m_contactList
      # @standing = false
      # @pushing = false
      # while edge    
      #   # Get the normal vector for this contact
      #   normal = edge.contact.m_manifold.normal
      #   # If the normal vector for this contact is pointing upwards
      #   # (y is less than 0), then this body is "standing" on something
      #   if normal.y < 0 
      #     @standing = true
      #     
      #   if 0 < normal.x > 0
      #     @pushing = true
      #   edge = edge.next
      # 
      # # if not @body.IsSleeping()
      # @vel = @body.GetLinearVelocity()
      # # console.log "x: #{@vel.x}"
      # # console.log "y: #{@vel.y}"
      # if ig.input.state("left")
      #   @body.ApplyForce new b2.Vec2(-20, 0), @body.GetPosition()
      #   @flip = true
      # else if ig.input.state("right")
      #   @body.ApplyForce new b2.Vec2(20, 0), @body.GetPosition()
      #   @flip = false
      #   
      # if ig.input.state("jump") and @standing
      #   @body.ApplyImpulse new b2.Vec2(0, -10), @body.GetPosition()
      #   @currentAnim = @anims.jump
      #   
      # # How do we land?
      # 
      # if ig.input.state("jet")
      #   @body.ApplyForce new b2.Vec2(0, -30), @body.GetPosition()
      #   @currentAnim = @anims.jet
      # else
      # 
      #   # Are we falling?
      #   if @vel.y < 1
      #     @currentAnim = @anims.idle
      #   else if @vel.y > 2
      #     @currentAnim = @anims.fall
      #     
      #   # Running?
      #   if @standing and @vel.x isnt 0
      #     @currentAnim = @anims.run
      #   
      #   # pushing? against wall?
      #   if @standing and @pushing 
      #     @currentAnim = @anims.push
      #     
      #   # pushing and moving
      #   if @standing and @pushing and @vel.x isnt 0
      #     @currentAnim = @anims.push
      # 
      #     
      # @parent()