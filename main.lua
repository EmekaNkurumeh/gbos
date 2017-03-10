local Game = require "core.game"
local Entity = require "core.entity"


function juno.onLoad()
  Game.init()
  i = Entity()
  i:loadImage("data/images/player/player", 16, 16)
  i:addAnimation("idle", {1,2,3,4}, 9, true)
  i:play("idle")

  d = Entity()
  d:loadImage("data/images/player/player", 16, 16)
  d:addAnimation("idle", {1,2,3,4}, 9, true)
  d:play("idle")
  d:setX(64)
  d:setY(64)
end

function juno.onUpdate(dt)
  require("lib.stalker").scan(dt)
  if G.debug then require("lib.lovebird").update() end
  Game.update(dt)
  G.tick = G.tick + 1

  local s = 200
  if juno.keyboard.isDown "left" then
    i.accel.x = -s
  elseif juno.keyboard.isDown "right" then
    i.accel.x = s
  else
    i.accel.x = 0
  end

  if juno.keyboard.isDown "up" then
    i.accel.y = -s
  elseif juno.keyboard.isDown "down" then
    i.accel.y = s
  else
    i.accel.y = 0
  end

end

function juno.onKeyDown(key, char)
  Game.key(key, char)
end

function juno.onDraw()
  Game.render()
end

function juno.onQuit()
  Game.stop()
end
