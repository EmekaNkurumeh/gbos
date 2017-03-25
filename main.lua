local Game = require "core.game"
local Entity = require "core.entity"
local Input = require "core.input"


function juno.onLoad()
  Game.init()
  i = Entity(16, 16)
  i:loadImage("data/images/player/player.png", 16, 16)
  i:addAnimation("idle", {1,2,3,4}, 9, true)
  i:play("idle")

  d = Entity(16, 16)
  d:loadImage("data/images/player/player.png", 16, 16)
  d:addAnimation("idle", {1,2,3,4}, 9, true)
  d:play("idle")
  d:setX(16)
  d:setY(64)

  Input.register({
    left    = {"left", "a"},
    right   = {"right", "d"},
    up      = {"up", "w"},
    down    = {"down", "s"},
    jump    = {"space", "x"},
    select  = {"return", "space", "x", "c"},
    pause   = {"escape", "p"},
    action  = {"c"},
    mute    = {"m"},
  })

end

function juno.onUpdate(dt)
  if G.debug then require("lib.stalker").update() end
  if G.debug then require("lib.lovebird").update() end
  Game.update(dt)

  G.tick = G.tick + 1

  local s = 200
  if Input.isDown("left") then
    i.accel.x = -s
  elseif Input.isDown("right") then
    i.accel.x = s
  else
    i.accel.x = 0
  end

  if Input.isDown("up") then
    i.accel.y = -s
  elseif Input.isDown("down") then
    i.accel.y = s
  else
    i.accel.y = 0
  end

  if Input.wasPressed("action") then
    Game.camera:shake(2, 3)
  end

end

function juno.onKeyDown(key, char)
  Game.key(key, char)
end

function juno.onDraw()
  Game.framebuffer:drawRect(0,0,32,32)
  Game.render()
end

function juno.onQuit()
  Game.stop()
end
