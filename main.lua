local Game = require("core.game")

function juno.onLoad()
  G.Game = Game()
end

function juno.onUpdate(dt)
  require("lib.stalker").update(dt)
  G.Game:update(dt)
  G.tick = G.tick + 1
end

function juno.onKeyDown(key, char)
  G.Game:key(key, char)
end

function juno.onDraw()
  G.Game:draw()
end

function juno.onQuit()
  G.Game:stop()
end
