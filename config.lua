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
v2 = require("core.vec2")
return {
  title = G.title,
  width = G.width * G.scale,
  height = G.height * G.scale
}
