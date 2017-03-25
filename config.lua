local _ = require("lib.lume")

G = {
  title = "gbos",
  width = 128,
  height = 128,
  scale = 4,
  tick = 0,
  debug = true
  -- debug = _.find(juno._argv, "--debug") or _.find(juno._argv, "-d")
}

return {
  title = G.title,
  width = G.width * G.scale,
  height = G.height * G.scale
}
