local _ = require "lib.lume"
local Object = require "lib.classic"

local Camera = Object:extend()

function Camera:new(x, y, w, h, sx, sy)
  self.type = "camera"
  self.x, self.y = x, y
  self.w, self.h = w, h
  self.sx, self.sy = sx, sy
  self.canvas = sol.Buffer.fromBlank(self.w, self.h)
end

function Camera:set(obj, x, y, rect, sx, sy)
  local sx = sx or 1
  local sy = sy or sx
  rect = _.extend({x = 0, y = 0, w = obj:getWidth(), h = obj:getHeight()}, rect)
  self.canvas:copyPixels(obj, x, y, rect, sx, sy)
end

function Camera:unset()
  self.canvas:clear()
end

function Camera:draw(drx, dry)
  local drx = drx or 0
  local dry = dry or 0
  sol.graphics.copyPixels(self.canvas, drx, dry, {x = self.x, y = self.y, w = self.w, h = self.h}, self.sx, self.sy)
  self:unset()
end

function Camera:move(dx, dy)
  self.x = self.x + (dx or 0)
  self.y = self.y + (dy or 0)
end

function Camera:zoom(dsx, dsy)
  local dsx = dsx or 1
  self.sx = self.sx * dsx
  self.sy = self.sy * (dsy or dsx)
end

function Camera:setX(x)
  self.x = self.bounds and _.clamp(x, self.bounds.x1, self.bounds.x2) or x
end

function Camera:setY(y)
  self.y = self.bounds and _.clamp(y, self.bounds.y1, self.bounds.y2) or y
end

function Camera:goTo(x, y)
  self:setX(x or self.x)
  self:setY(y or self.y)
end

function Camera:setScale(dsx, dsy)
  self.sx = dsx or self.sx
  self.sy = dsy or self.sy
end

function Camera:getBounds()
  return (table.unpack or unpack)(self.bounds)
end

function Camera:setBounds(x, y, w, h)
  self.bounds = {w = w, h = h, x1 = x, y1 = y, x2 = x + w, y2 = y + h}
end

return Camera
