local tick = require "lib.tick"
local coil = require "lib.coil"
local flux = require "lib.flux"
local _ = require "lib.lume"
local shash = require "lib.shash"
local Save = require "core.save"
local Object = require "lib.classic"

local Game = Object:extend()

function Game:new()
  error("use Game.init")
end

function Game.init(state)
  Game.entities = {}
  Game.save = Save("save.ini")
  Game.save:set({plays = (Game.save:get("plays") or 0) + 1})
  Game.world = shash.new(1)
  Game.x, Game.y = 0, 0
  Game.w, Game.h = 512, 512
  Game.sx, Game.sy = 2, 2
  Game.drx, Game.dry = 0, 0
  Game.canvas = juno.Buffer.fromBlank(Game.w, Game.h)
  Game.state = state
  Game.shakeTimer = 0
  Game.shakeAmount = 0
end

function Game.stop()
  Game.world:clear()
end

function Game.add(obj)
  Game.entities[obj] = obj
  Game.world:add(obj, obj.x, obj.y, obj.w, obj.h)
end

function Game.remove(obj)
  if Game.entities[obj] then
    Game.entities[obj] = nil
    Game.world:remove(obj)
  end
end

function Game.shake(time, amount)
  Game.shakeTimer = time
  Game.shakeAmount = amount
end

function Game.move(dx, dy)
  Game.x = Game.x + (dx or 0)
  Game.y = Game.y + (dy or 0)
end

function Game.zoom(dsx, dsy)
  local dsx = dsx or 1
  Game.sx = Game.sx * dsx
  Game.sy = Game.sy * (dsy or dsx)
end

function Game.setX(x)
  Game.x = Game._bounds and _.clamp(x, Game._bounds.x1, Game._bounds.x2) or x
end

function Game.setY(y)
  Game.y = Game._bounds and _.clamp(y, Game._bounds.y1, Game._bounds.y2) or y
end

function Game.goTo(x, y)
  Game.setX(x or Game.x)
  Game.setY(y or Game.y)
end

function Game.setScale(dsx, dsy)
  Game.sx = dsx or Game.sx
  Game.sy = dsy or Game.sy
end

function Game.getBounds()
  return (table.unpack or unpack)(Game._bounds)
end

function Game.setBounds(x, y, w, h)
  Game._bounds = {w = w, h = h, x1 = x, y1 = y, x2 = x + w, y2 = y + h}
end

function Game.update(dt)
  for key, obj in pairs(Game.entities) do
    if obj.update then
      obj:update(dt)
    end
  end
  if Game.shakeTimer ~= 0 then
    Game.shakeTimer = Game.shakeTimer - dt
    if Game.shakeTimer <= 0 then
      Game.shakeTimer = 0
      Game.shakeAmount = 0
    end
  end
  collectgarbage()
  collectgarbage()
end

function Game.key(key, char)
  if key == "tab" then
    local mode = not juno.debug.getVisible()
    juno.debug.setVisible(G.debug and mode)
  elseif key == "`" then
    local mode = not juno.debug.getFocused()
    juno.debug.setFocused(G.debug and mode)
  elseif key == "escape" then
    juno.onQuit()
    os.exit()
  elseif key == "r" and G.debug then
    juno.onLoad()
  end
end

function Game.draw(obj, x, y, rect, sx, sy)
  rect = _.extend({x = 0, y = 0, w = obj:getWidth(), h = obj:getHeight()}, rect)
  Game.canvas:copyPixels(obj, x, y, rect, sx or 1, sy or sx)
  Game.canvas:reset()
end

function Game.render()
  for key, obj in pairs(Game.entities) do
    if obj.visible then
      obj:draw()
      Game.canvas:reset()
    end
  end
  if Game.shakeTimer >= 1 then
    local shake = Game.canvas:clone()
    shake:clear(0, 0, 0)
    shake:copyPixels(Game.canvas,
      _.random() * Game.shakeAmount,
      _.random() * Game.shakeAmount)
    Game.canvas = shake
  end

  local x, y = Game.drx, Game.dry
  local rx, ry = Game.x, Game.y
  local rw, rh = Game.w, Game.h
  
  juno.graphics.copyPixels(Game.canvas, x, y, {x = rx, y = ry, w = rw, h = rh}, Game.sx, Game.sy)
  Game.canvas:clear()
end


return Game
