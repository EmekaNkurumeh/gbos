xpcall((function()
  dofile("init.lua")
  return require("moonscript")
end), (function()
  return os.exit()
end))
G = {
  title = "gbos",
  width = 128,
  height = 128,
  scale = 4,
  tick = 0
}
v2 = require("vec2")
math.clamp = function(_, min, max)
  return (_ < min) and min or (_ > max and max) or _
end
math.tau = math.pi * 2
table.merge = function(...)
  local res = { }
  for i = 1, select("#", ...) do
    local t = select(i, ...)
    if t then
      for k, v in pairs(t) do
        res[k] = v
      end
    end
  end
  return res
end
return {
  title = G.title,
  width = G.width * G.scale,
  height = G.height * G.scale
}
