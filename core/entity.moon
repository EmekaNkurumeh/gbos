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
    @velocity = v2 0,0
    @animation = nil
    @frame_counter = 1
    @animations = {}
    @animation_timer = 0
    @tween = flux.group!
    @timer = tick.group!
    @task = coil.group!
    @world\add @

  loadImage: (file, w, h) =>
    @image = png file
    w = w or @image\getWidth!
    h = h or @image\getHeight!
    @frames = {}
    for y = 0, @image\getHeight!  / h - 1
      for x = 0, @image\getWidth! / w - 1
        table.insert @frames, {x: x * w, y: y * h, :w, :h}

  addAnimation: (name, frames, fps, loop) =>
    @animations[name] =  {
      :frames,
      period: (fps != 0) and 1 / math.abs(fps) or 1,
      loop: (loop == nil) and true or loop
    }

  play: (name, reset) =>
    last = @animation
    @animation = @animations[name]
    if reset or @animation != last
      @frame_counter = 1
      @animation_timer = @animation.period
      @frame = @frames[@frame_counter]

  stop: () =>
    @animation = nil

  setX: (@x = @x) => @world.world\update @, @x, @y, @w, @h

  setY: (@y = @y) => @world.world\update @, @x, @y, @w, @h

  setWidth: (@w = @w) => @world.world\update @, @x, @y, @w, @h

  setHeight: (@h = @h) => @world.world\update @, @x, @y, @w, @h

  updateMovement: (dt) =>
    if dt == 0 then return
    @world.world\each @, (obj) ->
      @accel.x = -@accel.x
      @accel.y = -@accel.y

    @velocity.x += @accel.x * dt
    @velocity.y += @accel.y * dt
    if math.abs(@velocity.x) > 255 then
      @velocity.x = 255 * _.sign(@velocity.x)
    if math.abs(@velocity.y) > 255 then
      @velocity.y = 255 * _.sign(@velocity.y)
    @x += @velocity.x * dt
    @y += @velocity.y * dt
    if @accel.x == 0 @velocity.x -= @velocity.x * .01
    if @accel.y == 0 @velocity.y -= @velocity.y * .01

    @world.world\update @, @x, @y, @w, @h

  updateAnimation: (dt) =>
    if not @animation return
    @animation_timer -= dt
    if @animation_timer <= 0
      if @frame_counter < #@animation.frames
        @frame_counter += 1
      else
        if @animation.loop
          @frame_counter = 1
        else
          return @stop!
      @animation_timer += @animation.period
      @frame = @frames[@frame_counter]

  update: (dt) =>
    @updateMovement dt
    @updateAnimation dt

  draw: (screen) =>
    screen\set @image, @x, @y, @frame, @scale.x, @scale.y

Entity
