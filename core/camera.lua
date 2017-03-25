local coil = require "lib.coil"
local _ = require "lib.lume"
local Rect = require "core.rect"
local Game = require "core.game"

local Camera = Rect:extend()

function Camera:new(x, y)
  self.x, self.y = 0, 0
  self.width, self.height = G.width, G.height

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
  local x = self.x + (dx or 0)
  local y = self.y + (dy or 0)
  self:goTo(x, y)
end

function Camera:zoom(dsx, dsy)
  local dsx = dsx or 1
  self.scale.x = self.scale.x * dsx
  self.scale.y = self.scale.y * (dsy or dsx)
end

function Camera:setX(x)
  local x = self.bounds and _.clamp(x, 0, self.bounds.width) or x
  self:set(x, nil, nil, nil)
end

function Camera:setY(y)
  local y = self.bounds and _.clamp(y, 0, self.bounds.height) or y
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

function Camera:render(obj, x, y, rect, sx, sy)
  rect = _.extend({x = 0, y = 0, w = obj:getWidth(), h = obj:getHeight()}, rect)
  Game.framebuffer:copyPixels(obj, x, y, rect, sx or 1, sy or sx)
end

return Camera
