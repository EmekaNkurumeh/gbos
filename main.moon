Renderer = require "renderer"
GameLoop = require "gameloop"
stalker = require "lib.stalker"

juno.onLoad = () ->
  G.view = require"view"(v2(0,0),v2(128,128),v2(G.scale,G.scale))
  G.screen = juno.Buffer.fromBlank juno.graphics.getSize!
  G.Renderer = Renderer!
  G.GameLoop = GameLoop!
  return

juno.onUpdate = (dt) ->
  G.tick += 1
  stalker.update dt
  G.GameLoop\update(dt)
  return

juno.onKeyDown = (k) ->
  switch k
    when "tab"
      juno.debug.setVisible(not juno.debug.getVisible!)
    when "`"
      juno.debug.setFocused(not juno.debug.getFocused!)
    when "escape"
      os.exit!

juno.onDraw = () ->
  G.view\set G.screen, nil, nil, {23/255, 16/255, 54/255}
  G.screen\drawCircle 64,64,8,unpack{1,0,0}
  -- G.Renderer\draw!
  G.view\unset G.screen
  return
