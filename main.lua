local Renderer = require("renderer")
local GameLoop = require("gameloop")
local stalker = require("lib.stalker")
local Layer, View
do
  local _obj_0 = require("view")
  Layer, View = _obj_0.Layer, _obj_0.View
end
juno.onLoad = function()
  G.View = View(v2(0, 0), v2(512, 512), v2(G.scale, G.scale))
  G.Renderer = Renderer()
  G.GameLoop = GameLoop()
  G.image = juno.Buffer.fromFile("data/images/sheet.png")
end
juno.onUpdate = function(dt)
  G.tick = G.tick + 1
  stalker.update(dt)
  G.GameLoop:update(dt)
end
juno.onKeyDown = function(k)
  local _exp_0 = k
  if "tab" == _exp_0 then
    juno.debug.setVisible(not juno.debug.getVisible())
  elseif "`" == _exp_0 then
    juno.debug.setFocused(not juno.debug.getFocused())
  elseif "escape" == _exp_0 then
    os.exit()
  elseif "r" == _exp_0 then
    juno.onLoad()
  end
end
juno.onDraw = function()
  G.View:draw(nil, 0, 0)
  juno.graphics.copyPixels(G.image, 0, 0, {
    x = 1,
    y = 1,
    w = 15,
    h = 15
  }, 19)
end
