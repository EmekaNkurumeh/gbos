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

  Game.width = 512
  Game.height = 512

  Game.framebuffer = sol.Buffer.fromBlank(Game.width, Game.height)

  local Camera = require "core.camera"
  Game.camera = Camera(0, 0)
  Game.camera:setBounds(Game.width, Game.height)

  Game.state = state
end

function Game.stop()
  Game.world:clear()
end

function Game.add(obj)
  Game.entities[obj] = obj
  Game.world:add(obj, obj.x, obj.y, obj.width, obj.height)
end

function Game.remove(obj)
  if Game.entities[obj] then
    Game.entities[obj] = nil
    Game.world:remove(obj)
  end
end

function Game.update(dt)
  Game.camera:update(dt)
  for key, obj in pairs(Game.entities) do
    if obj.update then
      obj:update(dt)
    end
  end
  collectgarbage()
  collectgarbage()
end

function Game.key(key, char)
  if key == "tab" then
    local mode = not sol.debug.getVisible()
    sol.debug.setVisible(G.debug and mode)
  elseif key == "`" then
    local mode = not sol.debug.getFocused()
    sol.debug.setFocused(G.debug and mode)
  elseif key == "escape" then
    sol.onQuit()
    os.exit()
  elseif key == "r" and G.debug then
    sol.onLoad()
  end
end

function Game.render()
  local cam = Game.camera
  for key, obj in pairs(Game.entities) do
    if obj.visible and cam:overlaps(obj) then
      obj:draw()
      if G.debug then
        Game.framebuffer:drawBox(obj.x, obj.y, obj.width, obj.height, 1, 1, 1, .1)
      end
    end
  end

  if cam.shakeTimer ~= 0 then
    print(cam.shakeTimer)
    local shake = Game.framebuffer:clone()
    shake:clear(0, 0, 0)

    shake:copyPixels(Game.framebuffer,
      _.random() * cam.shakeAmount,
      _.random() * cam.shakeAmount)

    Game.framebuffer = shake
  end

  local rx, ry = cam.x, cam.y
  local rw, rh = cam.width, cam.height
  local sx, sy = cam.scale.x, cam.scale.y

  sol.graphics.copyPixels(Game.framebuffer, 0, 0, {x = rx, y = ry, w = rw, h = rh}, sx, sy)

  Game.framebuffer:clear()
  Game.framebuffer:reset()
end


return Game
