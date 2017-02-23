local tick = require "lib.tick"
local coil = require "lib.coil"
local flux = require "lib.flux"
local _ = require "lib.lume"
local shash = require "lib.shash"
local Save = require "core.save"
local View = require "core.view"
local Entity = require "core.entity"
local Object = require "lib.classic"

local Game = Object:extend()

function Game:new()
  self.entities = {}
  self.save = Save("save.ini")
  self.save:set({plays = (self.save:get("plays") or 0) + 1})
  self.screen = View(v2(0, 0), v2(512, 512), v2(2,2))
  self.world = shash.new(1)

  self.i = Entity(self)
  self.i:loadImage("data/images/player/player", 16, 16)
  self.i:addAnimation("idle", {1,2,3,4}, 9, true)
  self.i:play("idle")

  self.d = Entity(self)
  self.d:loadImage("data/images/player/player", 16, 16)
  self.d:addAnimation("idle", {1,2,3,4}, 9, true)
  self.d:play("idle")
  self.d:setX(64)
  self.d:setY(64)
end

function Game:stop()
  self.world:clear()
end

function Game:add(obj)
  self.entities[obj] = obj
  self.world:add(obj, obj.x, obj.y, obj.w, obj.h)
end

function Game:remove(obj)
  if self.entities[obj] then
    self.entities[obj] = nil
    self.world:remove(obj)
  end
end

function Game:update(dt)
  for key, obj in pairs(self.entities) do
    if obj.update then
      obj:update(dt)
    end
  end

  local s = 200
  if juno.keyboard.isDown "left" then
    self.i.accel.x = -s
  elseif juno.keyboard.isDown "right" then
    self.i.accel.x = s
  else
    self.i.accel.x = 0
  end

  if juno.keyboard.isDown "up" then
    self.i.accel.y = -s
  elseif juno.keyboard.isDown "down" then
    self.i.accel.y = s
  else
    self.i.accel.y = 0
  end
end

function Game:key(key, char)
  if key == "tab" then
    juno.debug.setVisible(G.debug and not juno.debug.getVisible())
  elseif key == "`" then
    juno.debug.setFocused(G.debug and not juno.debug.getFocused())
  elseif key == "escape" then
    os.exit()
  elseif key == "r" and G.debug then
    juno.onLoad()
  end
end

function Game:draw()
  for key, obj in pairs(self.entities) do
    if obj.visible then
      obj:draw(self.screen)
    end
  end
  self.screen:draw(0, 0)
end

return Game
