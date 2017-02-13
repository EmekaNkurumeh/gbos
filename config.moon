xpcall (->
  dofile "init.lua"
  require "moonscript"),
  (-> os.exit!)

export G = {
  title: "gbos",
  width: 128,
  height: 128,
  scale: 4,
  tick: 0,
}

export v2 = require "core.vec2"

{
  title: G.title,
  width: G.width * G.scale,
  height: G.height * G.scale
}
