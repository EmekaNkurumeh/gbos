local _ = require("lib.lume")

G = {
  title = "gbos",
  width = 128,
  height = 128,
  scale = 4,
  tick = 0,
  debug = true
  -- debug = _.find(sol._argv, "--debug") or _.find(sol._argv, "-d")
}

return {
  title = G.title,
  width = G.width * G.scale,
  height = G.height * G.scale
}
