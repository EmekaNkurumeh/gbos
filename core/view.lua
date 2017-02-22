local _ = require "lib.lume"
local Object = require "lib.classic"

local View = Object:extend()

function View:new(pos, size, scale)
  self.type = "view"
  self._x, self._y = pos.x, pos.y
  self._w, self._h = size.x, size.y
  self._sx, self._sy = scale.x, scale.y
  self.canvas = juno.Buffer.fromBlank(self._w, self._h)
end

function View:set(obj, x, y, rect, sx, sy)
  local sx = sx or 1
  local sy = sy or sx
  rect = _.extend({x = 0, y = 0, w = obj:getWidth(), h = obj:getHeight()}, rect)
  self.canvas:copyPixels(obj, x, y, rect, sx, sy)
end

function View:unset()
  self.canvas:clear()
end

function View:draw(drx, dry)
  local drx = drx or 0
  local dry = dry or 0
  juno.graphics.copyPixels(self.canvas, drx, dry, {x = self._x, y = self._y, w = self._w, h = self._h}, self._sx, self.sy)
  self:unset()
end

function View:move(dx, dy)
  self._x = self._x + (dx or 0)
  self._y = self._y + (dy or 0)
end

function View:zoom(dsx, dsy)
  local dsx = dsx or 1
  self._sx = self._sx * dsx
  self._sy = self._sy * (dsy or dsx)
end

function View:setX(x)
  self._x = self._bounds and _.clamp(x, self._bounds.x1, self._bounds.x2) or x
end

function View:setY(y)
  self._y = self._bounds and _.clamp(y, self._bounds.y1, self._bounds.y2) or y
end

function View:goTo(x, y)
  self:setX(x or self.x)
  self:setY(y or self.y)
end

function View:setScale(dsx, dsy)
  self._sx = dsx or self._sx
  self._sy = dsy or self._sy
end

function View:getBounds()
  return (table.unpack or unpack)(self._bounds)
end

function View:setBounds(x, y, w, h)
  self._bounds = {w = w, h = h, x1 = x, y1 = y, x2 = x + w, y2 = y + h}
end

return View
