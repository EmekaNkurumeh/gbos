xpcall((function()
  dofile("init.lua")
  return require("moonscript")
end), (function()
  return os.exit()
end))
local loadkit = require("lib.loadkit")
v2 = require("core.vec2")
list = require("lib.list")
png = loadkit.make_loader("png", function(data)
  return juno.Buffer.fromString(data:read("*a"))
end)
json = loadkit.make_loader("json", function(data)
  return require("lib.json").decode(data:read("*a"))
end)
G = {
  title = "gbos",
  width = 128,
  height = 128,
  scale = 4,
  tick = 0
}
return {
  title = G.title,
  width = G.width * G.scale,
  height = G.height * G.scale
}
