local loadkit = require("lib.loadkit")
local _ = require("lib.lume")

v2 = require("core.vec2")

png = loadkit.make_loader("png", function(data)
  return juno.Buffer.fromString(data:read("*a"))
end)

G = {
  title = "gbos",
  width = 128,
  height = 128,
  scale = 4,
  tick = 0,
  debug = _.find(juno._argv, "--debug") or _.find(juno._argv, "-d") 
}

return {
  title = G.title,
  width = G.width * G.scale,
  height = G.height * G.scale
}
