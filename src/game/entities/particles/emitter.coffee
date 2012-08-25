ig.module("game.entities.particles.emitter")
.requires("impact.entity").defines =>
  @ParticleEmitter = ig.Class.extend(
    pos:
      x: 0
      y: 0

    particleClass: null
    emitAngleMin: 0
    emitAngleMax: 0
    emitStrengthMin: 100
    emitStrengthMax: 100
    emitterLife: 0
    lifeMin: 2
    lifeMax: 2
    velMin:
      x: 0
      y: 0

    velMax:
      x: 200
      y: 0

    accelMin:
      x: 0
      y: 0

    accelMax:
      x: 0
      y: 0

    posOffsetMin:
      x: 0
      y: 0

    posOffsetMax:
      x: 0
      y: 0

    invertDir: false
    customData: null
    owner: null
    _spawnTimer: null
    _emitterLifeTimer: null
    _dead: false
    init: (owner) ->
      @owner = owner
      @_spawnTimer = new ig.Timer()

    emit: ->
      return  if @_dead
      if @emitterLife > 0
        @_emitterLifeTimer = new ig.Timer(@emitterLife)  unless @_emitterLifeTimer?
        if @_emitterLifeTimer.delta() >= 0
          @died()
          return
      if @_spawnTimer.delta() >= 0
        @_spawn()
        @_spawnTimer.reset()

    setParticleData: (data) ->
      for i of data
        switch i
          when "class"
            @particleClass = data[i]
          when "spawnTime"
            @_spawnTimer.set data[i]
          when "emitAngleMin", "emitAngleMax"
            value = Number(data[i])
            value += 360  if value < 0
            value -= 360  if value > 360
            this[i] = value
          else
            this[i] = data[i]

    died: ->
      @_dead = true

    _spawn: ->
      return  unless @particleClass?
      angleRad = Number(@emitAngleMin + (@emitAngleMax - @emitAngleMin) * Math.random()).toRad()
      angleRad -= 3.14159265  if @invertDir
      dir = (if @invertDir then -1 else 1)
      cos = Math.cos(angleRad)
      sin = Math.sin(angleRad)
      settings =
        emitter: this
        data: @customData
        life: @lifeMin + (@lifeMax - @lifeMin) * Math.random()
        pos:
          x: @pos.x + (@posOffsetMin.x + (@posOffsetMax.x - @posOffsetMin.x) * Math.random()) * dir
          y: @pos.y + (@posOffsetMin.y + (@posOffsetMax.y - @posOffsetMin.y) * Math.random()) * dir

        vel:
          x: cos * (@emitStrengthMin + (@emitStrengthMax - @emitStrengthMin) * Math.random())
          y: sin * (@emitStrengthMax + (@emitStrengthMax - @emitStrengthMin) * Math.random())

        accel:
          x: @accelMin.x + (@accelMax.x - @accelMin.x) * Math.random()
          y: @accelMin.y + (@accelMax.y - @accelMin.y) * Math.random()

      ig.game.spawnEntity @particleClass, settings.pos.x, settings.pos.y, settings
  )