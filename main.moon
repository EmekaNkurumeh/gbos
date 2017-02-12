Renderer = require "core.renderer"
GameLoop = require "core.gameloop"
stalker = require "lib.stalker"
import Layer, View from require "core.view"
import Save from require "core.save"

juno.onLoad = () ->
  G.View = View v2(0,0), v2(512,512), v2(G.scale,G.scale)
  G.Renderer = Renderer!
  G.GameLoop = GameLoop!
  G.image = juno.Buffer.fromFile "data/images/sheet.png"
  G.Save = Save "save.ini"
  return

juno.onUpdate = (dt) ->
  G.tick += 1
  stalker.update dt
  G.GameLoop\update(dt)
  return

juno.onKeyDown = (k) ->
  switch k
    when "tab"
      juno.debug.setVisible not juno.debug.getVisible!
    when "`"
      juno.debug.setFocused not juno.debug.getFocused!
    when "escape"
      os.exit!
    when "r"
      juno.onLoad!
  return

juno.onDraw = () ->
  G.View\draw nil, 0,0
  juno.graphics.copyPixels G.image, 0 ,0, {x:1, y:1, w:15, h:15}, 19
  return

juno.onQuit = () ->
  G.Save\close!

