xpcall (->
  dofile "init.lua"
  require "moonscript"),
  (-> os.exit!)

loadkit = require "lib.loadkit"

export v2 = require "core.vec2"

export list = require "lib.list"

export png = loadkit.make_loader "png", (data) ->
    juno.Buffer.fromString data\read "*a"

export json = loadkit.make_loader "json", (data) ->
    require"lib.json".decode data\read "*a"

export G = {
  title: "gbos",
  width: 128,
  height: 128,
  scale: 4,
  tick: 0,
}

{
  title: G.title,
  width: G.width * G.scale,
  height: G.height * G.scale
}
