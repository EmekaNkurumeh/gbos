local _ = require "lib.lume"
local Object = require "lib.classic"
local tick = require "lib.tick"
local coil = require "lib.coil"
local flux = require "lib.flux"
local shash = require "lib.shash"

local Entity = Object:extend()

function Entity:new(world)
  self.x = 0
  self.y = 0
  self.w = 16
  self.h = 16
  self.angle = 0
  self.accel = v2(0,0)
  self.scale = v2(1,1)
  self.offset = v2(0,0)
  self.solid = true
  self.moves = true
  self.visible = true
  self.collidable = true
  self.velocity = v2(0,0)
  self.animation = nil
  self.frame_counter = 1
  self.animations = {}
  self.animation_timer = 0
  self.tween = flux.group()
  self.timer = tick.group()
  self.task = coil.group()
  self.world = world
  self.world:add(self)
end

function Entity:loadImage(file, w, h)
  self.image = png(file)
  local w = w or self.image:getWidth()
  local h = h or self.image:getHeight()
  self.frames = {}
  for y = 0, self.image:getHeight()  / h - 1 do
    for x = 0, self.image:getWidth() / w - 1 do
      table.insert(self.frames, {x = x * w, y = y * h, w = w, h = h})
    end
  end
end

function Entity:addAnimation(name, frames, fps, loop)
  self.animations[name] =  {
    frames = frames,
    period = (fps ~= 0) and 1 / math.abs(fps) or 1,
    loop = (loop == nil) and true or loop
  }
end

function Entity:play(name, reset)
  local last = self.animation
  self.animation = self.animations[name]
  if reset or self.animation ~= last then
    self.frame_counter = 1
    self.animation_timer = self.animation.period
    self.frame = self.frames[self.frame_counter]
  end
end

function Entity:stop()
  self.animation = nil
end

function Entity:setX(x)
  self.x = x
  self.world.world:update(self, self.x, self.y, self.w, self.h)
end

function Entity:setY(y)
  self.y = y
  self.world.world:update(self, self.x, self.y, self.w, self.h)
end

function Entity:setWidth(w)
  self.w = w
  self.world.world:update(self, self.x, self.y, self.w, self.h)
end

function Entity:setHeight(h)
  self.h = h
  self.world.world:update(self, self.x, self.y, self.w, self.h)
end

function Entity:updateMovement(dt)
  if dt == 0 then return end
  self.world.world:each(self, function(obj)
    self.accel.x = -self.accel.x
    self.accel.y = -self.accel.y
  end)

  self.velocity.x = self.velocity.x + (self.accel.x * dt)
  self.velocity.y = self.velocity.y + (self.accel.y * dt)

  if math.abs(self.velocity.x) > 255 then
    self.velocity.x = 255 * _.sign(self.velocity.x)
  end

  if math.abs(self.velocity.y) > 255 then
    self.velocity.y = 255 * _.sign(self.velocity.y)
  end

  self.x = self.x + (self.velocity.x * dt)
  self.y = self.y + (self.velocity.y * dt)

  if self.accel.x == 0 then self.velocity.x = self.velocity.x - (self.velocity.x * .01)end
  if self.accel.y == 0 then self.velocity.y = self.velocity.y - (self.velocity.y * .01) end

  self.world.world:update(self, self.x, self.y, self.w, self.h)
end

function Entity:updateAnimation(dt)
  if not self.animation then return end
  self.animation_timer = self.animation_timer - dt
  if self.animation_timer <= 0 then
    if self.frame_counter < #self.animation.frames then
      self.frame_counter = self.frame_counter + 1
    else
      if self.animation.loop then
        self.frame_counter = 1
      else
        return self:stop()
      end
    end
    self.animation_timer = self.animation_timer + self.animation.period
    self.frame = self.frames[self.frame_counter]
  end
end

function Entity:update(dt)
  self:updateMovement(dt)
  self:updateAnimation(dt)
end

function Entity:draw(screen)
  screen:set(self.image, self.x, self.y, self.frame, self.scale.x, self.scale.y)
end

return Entity
