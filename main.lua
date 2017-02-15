local Game = require("core.game")
local Entity = require("core.entity")
local stalker = require("lib.stalker")
local moon = require("moon")
juno.onLoad = function()
  G.Game = Game()
  local i = Entity(G.Game)
  i:newImage("data/images/player/player", true)
  i:addAnimation("idle", 1, 4)
  i:setAnimation("idle")
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
