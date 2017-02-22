local _ = require "lib.lume"
local Object = require "lib.classic"
local tick = require "lib.tick"
local coil = require "lib.coil"
local flux = require "lib.flux"
local shash = require "lib.shash"

local Entity = Object:extend()

new: (self.world) =>
  self.x = 0
  self.y = 0
  self.w = 16
  self.h = 16
  self.angle = 0
  self.accel = v2 0,0
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
  self.world:add(self)

-- loadImage: (file, w, h) =>
--   self.image = png file
--   w = w or self.image:getWidth()
--   h = h or self.image:getHeight()
--   self.frames = {}
--   for y = 0, self.image:getHeight()  / h - 1
--     for x = 0, self.image:getWidth() / w - 1
--       table.insert self.frames, {x: x * w, y: y * h, :w, :h}
--
-- addAnimation: (name, frames, fps, loop) =>
--   self.animations[name] =  {
--     :frames,
--     period: (fps ()= 0) and 1 / math.abs(fps) or 1,
--     loop: (loop == nil) and true or loop
--   }
--
-- play: (name, reset) =>
--   last = self.animation
--   self.animation = self.animations[name]
--   if reset or self.animation ()= last
--     self.frame_counter = 1
--     self.animation_timer = self.animation.period
--     self.frame = self.frames[self.frame_counter]
--
-- stop: () =>
--   self.animation = nil
--
-- setX: (self.x = self.x) => self.world.world:update self., self.x, self.y, self.w, self.h
--
-- setY: (self.y = self.y) => self.world.world:update self., self.x, self.y, self.w, self.h
--
-- setWidth: (self.w = self.w) => self.world.world:update self., self.x, self.y, self.w, self.h
--
-- setHeight: (self.h = self.h) => self.world.world:update self., self.x, self.y, self.w, self.h
--
-- updateMovement: (dt) =>
--   if dt == 0 then return
--   self.world.world:each self., (obj) ->
--     self.accel.x = -self.accel.x
--     self.accel.y = -self.accel.y
--
--   self.velocity.x += self.accel.x * dt
--   self.velocity.y += self.accel.y * dt
--   if math.abs(self.velocity.x) > 255 then
--     self.velocity.x = 255 * _.sign(self.velocity.x)
--   if math.abs(self.velocity.y) > 255 then
--     self.velocity.y = 255 * _.sign(self.velocity.y)
--   self.x += self.velocity.x * dt
--   self.y += self.velocity.y * dt
--   if self.accel.x == 0 self.velocity.x -= self.velocity.x * .01
--   if self.accel.y == 0 self.velocity.y -= self.velocity.y * .01
--
--   self.world.world:update self., self.x, self.y, self.w, self.h
--
-- updateAnimation: (dt) =>
--   if not self.animation return
--   self.animation_timer -= dt
--   if self.animation_timer <= 0
--     if self.frame_counter < #self.animation.frames
--       self.frame_counter += 1
--     else
--       if self.animation.loop
--         self.frame_counter = 1
--       else
--         return self.stop()
--     self.animation_timer += self.animation.period
--     self.frame = self.frames[self.frame_counter]
--
-- update: (dt) =>
--   self.updateMovement dt
--   self.updateAnimation dt
--
-- draw: (screen) =>
--   screen:set self.image, self.x, self.y, self.frame, self.scale.x, self.scale.y

return Entity
