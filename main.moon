Renderer = require "renderer"
GameLoop = require "gameloop"
stalker = require "lib.stalker"

juno.onLoad = () ->
  G.Renderer = Renderer!
  G.GameLoop = GameLoop!
  G.screen = juno.Buffer.fromBlank juno.graphics.getSize!
  G.time = 0
  return

juno.onUpdate = (dt) ->
  G.time += dt
  stalker.update dt
  G.GameLoop\update(dt)
  return

juno.onDraw = () ->
  G.Renderer\draw!
  --juno.graphics.copyPixels G.screen, 0, 0, nil, G.scale
  G.screen\clear!
  return
