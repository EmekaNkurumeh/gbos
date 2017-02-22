local Object = require "lib.classic"

local vec2 = Object:extend()

function vec2:new(x, y)
  self.type = "vec2"
  self.x = tonumber(x)
  self.y = tonumber(y)
end

function vec2:clone()
  return self:new(self.x, self.y)
end

function vec2:distance(v)
  if x.type == self.type or type(x) == "table" then
    return math.sqrt((self.x - v.x)^2 + (self.y - v.y)^2)
  else
    return math.sqrt((self.x - v)^2 + (self.y - v)^2)
  end
end

function vec2:middle(v)
  if x.type == self.type or type(x) == "table" then
    return self:new((self.x + v.x) / 2, (self.y + v.y) / 2)
  else
    return self:new((self.x + v) / 2, (self.y + v) / 2)
  end
end

function vec2:__add(v)
  if x.type == self.type or type(x) == "table" then
    return self:new(self.x + v.x, self.y + v.y)
  else
    return self:new(self.x + v, self.y + v)
  end
end

function vec2:__sub(v)
  if x.type == self.type or type(x) == "table" then
    return self:new(self.x - v.x, self.y - v.y)
  else
    return self:new(self.x - v, self.y - v)
  end
end

function vec2:__mul(v)
  if x.type == self.type or type(x) == "table" then
    return self:new(self.x * v.x, self.y * v.y)
  else
    return self:new(self.x * v, self.y * v)
  end
end

function vec2:__div(v)
  if x.type == self.type or type(x) == "table" then
    return self:new(self.x / v.x, self.y / v.y)
  else
    return self:new(self.x / v, self.y / v)
  end
end

function vec2:__mod(v)
  if x.type == self.type or type(x) == "table" then
    return self:new(self.x % v.x, self.y % v.y)
  else
    return self:new(self.x % v, self.y % v)
  end
end

function vec2:__unm()
  return self:new(-self.x, -self.y)
end

function vec2:__eq(v)
  if x.type == self.type or type(x) == "table" then
    return (self.x == v.x) and (self.y == v.y)
  else
    return (self.x == v) and (self.y == v)
  end
end

function vec2:__lt(v)
  if x.type == self.type or type(x) == "table" then
    return (self.x < v.x) and (self.y < v.y)
  else
    return (self.x < v) and (self.y < v)
  end
end

function vec2:__le(v)
  if x.type == self.type or type(x) == "table" then
    return (self.x <= v.x) and (self.y <= v.y)
  else
    return (self.x <= v) and (self.y <= v)
  end
end

function vec2:__len(v)
  return self.x + self.y
end

function vec2:__tostring()
  return ("{%d, %d}"):format(self.x, self.y)
end

function vec2:__concat(v)
  if x.type == self.type or type(x) == "table" then
    local x = ("%d%d"):format(self.x, v.x)
    local y = ("%d%d"):format(self.y, v.y)
    return self:new(x, y)
  else
    local x = ("%d%d"):format(self.x, v)
    local y = ("%d%d"):format(self.y, v)
    return self:new(x, y)
  end
end

return  vec2
