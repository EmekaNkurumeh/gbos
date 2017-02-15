tick = require "lib.tick"
coil = require "lib.coil"
flux = require "lib.flux"
_ = require "lib.lume"
shash = require "lib.shash"

class Entity
  new: (@world) =>
    @x = 0
    @y = 0
    @w = 16
    @h = 16
    @angle = 0
    @accel = v2 0,0
    @scale = v2 1,1
    @offset = v2 0,0
    @solid = true
    @moves = true
    @visible = true
    @collidable = true
    @velocity = v2 1,1
    @frame = nil
    @animations = {}
    @anim_timer = 0
    @tween = flux.group!
    @timer = tick.group!
    @task = coil.group!
    @world\add @

  newImage: (file, frames) =>
    @image = png file
    if frames
      @animations.frames = json(file).frames

  addAnimation: (name, start, stop) =>
    @animations[name] =  {:start, :stop}

  setAnimation: (name) =>
    @frame_counter = 0
    @frame = @animations[name]

  setX: (@x = @x) => G.Game.world\update @, @x, @y, @w, @h

  setY: (@y = @y) => G.Game.world\update @, @x, @y, @w, @h

  setWidth: (@w = @w) => G.Game.world\update @, @x, @y, @w, @h

  setHeight: (@h = @h) => G.Game.world\update @, @x, @y, @w, @h

  updateMovement: (dt) =>
    if dt = 0 then return
    @velocity.x += @accel.x * dt
    @velocity.y += @accel.y * dt
    if math.abs(@velocity.x) > math.huge then
      @velocity.x = math.huge * _.sign(@velocity.x)
    if math.abs(@velocity.y) > math.huge then
      @velocity.y = math.huge * _.sign(@velocity.y)
    @x += @velocity.x * dt
    @y += @velocity.y * dt

  update: (dt) =>
    @world.world\each @, (obj) ->
      obj.x = @x
      obj.y = @y

    @anim_timer += dt
    if @anim_timer > .100
      if @frame_counter < @frame.stop - @frame.start
        @frame_counter += 1
      else
        @frame_counter = 0
      @anim_timer = 0

  draw: (screen) =>
    -- screen\set @image, @x, @y, nil, @scale.x, @scale.y
    frame = @animations.frames[@frame.start + @frame_counter].frame
    screen\set @image, @x, @y, frame, @scale.x, @scale.y


Entity
