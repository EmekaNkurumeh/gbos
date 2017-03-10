local Object = require "lib.classic"

local Vector = Object:extend()

function Vector:new(angle, mag)
  self.type = "Vector"
  self.angle = tonumber(angle)
  self.mag = tonumber(mag)
end

function Vector:clone()
  return self(self.angle, self.mag)
end

function Vector:distance(v)
  if type(v) == "table" and v.type == self.type then
    return math.sqrt((self.angle - v.angle)^2 + (self.mag - v.mag)^2)
  else
    return math.sqrt((self.angle - v)^2 + (self.mag - v)^2)
  end
end

function Vector:middle(v)
  if type(v) == "table" and v.type == self.type then
    return self((self.angle + v.angle) / 2, (self.mag + v.mag) / 2)
  else
    return self((self.angle + v) / 2, (self.mag + v) / 2)
  end
end

function Vector:__add(v)
  if type(v) == "table" and v.type == self.type then
    return self(self.angle + v.angle, self.mag + v.mag)
  else
    return self(self.angle + v, self.mag + v)
  end
end

function Vector:__sub(v)
  if type(v) == "table" and v.type == self.type then
    return self(self.angle - v.angle, self.mag - v.mag)
  else
    return self(self.angle - v, self.mag - v)
  end
end

function Vector:__mul(v)
  if type(v) == "table" and v.type == self.type then
    return self(self.angle * v.angle, self.mag * v.mag)
  else
    return self(self.angle * v, self.mag * v)
  end
end

function Vector:__div(v)
  if type(v) == "table" and v.type == self.type then
    return self(self.angle / v.angle, self.mag / v.mag)
  else
    return self(self.angle / v, self.mag / v)
  end
end

function Vector:__mod(v)
  if type(v) == "table" and v.type == self.type then
    return self(self.angle % v.angle, self.mag % v.mag)
  else
    return self(self.angle % v, self.mag % v)
  end
end

function Vector:__unm()
  return self(-self.angle, -self.mag)
end

function Vector:__eq(v)
  if type(v) == "table" and v.type == self.type then
    return (self.angle == v.angle) and (self.mag == v.mag)
  else
    return (self.angle == v) and (self.mag == v)
  end
end

function Vector:__lt(v)
  if type(v) == "table" and v.type == self.type then
    return (self.angle < v.angle) and (self.mag < v.mag)
  else
    return (self.angle < v) and (self.mag < v)
  end
end

function Vector:__le(v)
  if type(v) == "table" and v.type == self.type then
    return (self.angle <= v.angle) and (self.mag <= v.mag)
  else
    return (self.angle <= v) and (self.mag <= v)
  end
end

function Vector:__len(v)
  return self.angle + self.mag
end

function Vector:__tostring()
  return ("{%d, %d}"):format(self.angle, self.mag)
end

function Vector:__concat(v)
  if type(v) == "table" and v.type == self.type then
    local angle = self.angle * v.angle
    local mag = self.mag * v.mag
    return angle + mag
  else
    local angle = self.angle * v
    local mag = self.mag * v
    return angle + mag
  end
end

return Vector
