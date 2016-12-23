Renderer = require "renderer"
GameLoop = require "gameloop"
stalker = require "lib.stalker"
import View, Layer from require "view"

juno.onLoad = () ->
  G.View = View(v2(0,0),v2(128,128),v2(G.scale,G.scale))
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
    when "r"
      juno.onLoad!
  return

juno.onDraw = () ->
  G.View\draw nil, 0,0
  return
