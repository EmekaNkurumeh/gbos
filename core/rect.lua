local Object = require "lib.classic"

local Rect = Object:extend()

function Rect:new(x, y, width, height)
  self.x = x or 0
  self.y = y or 0
  self.width = width or 0
  self.height = height or 0
  self.touching = {
    left = false,
    right = false,
    top = false,
    bottom = false
  }
end

function Rect:set(x, y, width, height)
  self.x = x or self.x
  self.y = y or self.y
  self.width = width or self.width
  self.height = height or self.height
end

function Rect:top(v)
  if v then self.y = v end
  return self.y
end

function Rect:bottom(v)
  if v then self.y  = v - self.height end
  return self.y + self.height
end

function Rect:left(v)
  if v then self.x = v end
  return self.x
end

function Rect:right(v)
  if v then self.x = v - self.width end
  return self.x + self.width
end

function Rect:middleX(v)
  if v then x = v - self.width / 2 end
  return self.x + self.width / 2
end

function Rect:middleY(v)
  if v then y = v - self.height / 2 end
  return self.y + self.height / 2
end

function Rect:overlapsX(r)
  return self:right() > r:left() and self:left() < r:right()
end

function Rect:overlapsY(r)
  return self:bottom() > r:top() and self:top() < r:bottom()
end

function Rect:overlaps(r)
  return self:overlapsX(r) and self:overlapsY(r)
end

function Rect:reject(r)
  if not self:overlaps(r) then return end
  local dx = self:middleX() - r:middleX()
  local dy = self:middleY() - r:middleY()
  if math.abs(dx) > math.abs(dy) then
    if dx > 0 then
      self:left(r:right())
      self.touching.left = true
    else
      self:right(r:left())
      self.touching.right = true
    end
  else
    if dy > 0 then
      self:top(r:bottom())
      self.touching.bottom = true
    else
      self:bottom(r:top())
      self.touching.top = true
    end
  end
end

return Rect
