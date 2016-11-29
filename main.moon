Renderer = require "renderer"
GameLoop = require "gameloop"

juno.onLoad = () ->
  G.Renderer = Renderer!
  G.GameLoop = GameLoop!
  G.time = 0
  return

juno.onUpdate = (dt) ->
  G.time += dt
  (require "stalker").update dt
  G.GameLoop\update(dt)
  return

juno.onDraw = () ->
  G.Renderer\draw!
  return