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
  indentity: "gbos"
}

export v2 = require "core.vec2"

math.clamp = (_, min, max) ->
  (_ < min) and min or (_ > max and max) or _

math.tau = math.pi * 2

table.merge = (...) ->
  res = {}
  for i = 1, select "#", ... do
    t = select i, ...
    if t
      for k, v in pairs t do
        res[k] = v
  res

{
  title: G.title,
  width: G.width * G.scale,
  height: G.height * G.scale
}
