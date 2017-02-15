local Game = require("core.game")
local stalker = require("lib.stalker")
juno.onLoad = function()
  G.Game = Game()
end
juno.onUpdate = function(dt)
  stalker.update(dt)
  G.Game:update(dt)
  G.tick = G.tick + 1
end
juno.onKeyDown = function(key, char)
  return G.Game:key(key, char)
end
juno.onDraw = function()
  G.Game:draw()
end
juno.onQuit = function()
  G.Game:stop()
end
