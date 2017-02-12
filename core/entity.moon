tick = require "tick"
coil = require "coil"
flux = require "flux"
_ = require "lume"
shash = require "shash"


class Entity
  new: () =>
    @x = 0
    @y = 0
    @angle = 0
    @accel = v2 0,0
    @scale = v2 1,1
    @offset = v2 0,0
    @solid = true
    @moves = true
    @collidable = true
    @velocity = v2 1,1
    @frame = 0
    @animations = {}
    @anim_timer = 0
    @tween = flux.group!
    @timer = tick.group!
    @task = coil.group!

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
    print @x,@y


  draw: () =>
