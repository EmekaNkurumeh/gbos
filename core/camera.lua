local coil = require "lib.coil"
local _ = require "lib.lume"
local Rect = require "core.rect"
local Game = require "core.game"

local Camera = Rect:extend()

function Camera:new(x, y)
  self.x, self.y = 0, 0
  self.width, self.height = Game.width, Game.height

  self:set(x, y, nil, nil)

  self.scale = Rect(2, 2)

  self.shakeTimer = 0
  self.shakeAmount = 0
end

function Camera:shake(time, amount)
  self.shakeTimer = time
  self.shakeAmount = amount
end

function Camera:move(dx, dy)
  self.x = self.x + (dx or 0)
  self.y = self.y + (dy or 0)
end

function Camera:zoom(dsx, dsy)
  local dsx = dsx or 1
  self.scale.x = self.scale.x * dsx
  self.scale.y = self.scale.y * (dsy or dsx)
end

function Camera:setX(x)
  local x = self.bounds and _.clamp(x, self.x, self.bounds.width) or x
  self:set(x, nil, nil, nil)
end

function Camera:setY(y)
  local y = self.bounds and _.clamp(y, self.y, self.bounds.height) or y
  self:set(nil, y, nil, nil)
end

function Camera:setWidth(width)
  self:set(nil, nil, width, nil)
end

function Camera:setHeight(height)
  self:set(nil, nil, nil, height)
end

function Camera:goTo(x, y)
  self:setX(x)
  self:setY(y)
end

function Camera:resize(w, h)
  self:setWidth(w)
  self:setHeight(h)
end

function Camera:setScale(x, y)
  self.scale:set(x, y, nil, nil)
end

function Camera:getBounds()
  return (table.unpack or unpack)(self.bounds)
end

function Camera:setBounds(w, h)
  self.bounds = {
    width = w,
    height = h
  }
end

function Camera:update(dt)
  if self.shakeTimer ~= 0 then
    self.shakeTimer = self.shakeTimer - dt
    if self.shakeTimer <= 0 then
      self.shakeTimer = 0
      self.shakeAmount = 0
    end
  end
end

function Camera:draw(obj, x, y, rect, sx, sy)
  rect = _.extend({x = 0, y = 0, w = obj:getWidth(), h = obj:getHeight()}, rect)
  Game.framebuffer:copyPixels(obj, x, y, rect, sx or 1, sy or sx)
end

function Camera:render()
  for key, obj in pairs(Game.entities) do
    if obj.visible then
      obj:draw()
    end
  end

  if self.shakeTimer >= 1 then
    local shake = Game.framebuffer:clone()
    shake:clear(0, 0, 0)

    shake:copyPixels(Game.framebuffer,
      _.random() * self.shakeAmount,
      _.random() * self.shakeAmount)

    Game.framebuffer = shake
  end

  local rx, ry = self.x, self.y
  local rw, rh = self.w, self.h
  local sx, sy = self.scale.x, self.scale.y

  juno.graphics.copyPixels(Game.framebuffer, 0, 0, {x = rx, y = ry, w = rw, h = rh}, sx, sy)

  Game.framebuffer:clear()
  Game.framebuffer:reset()
end


return Camera
