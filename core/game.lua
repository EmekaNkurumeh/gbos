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

  Game.framebuffer = juno.Buffer.fromBlank(Game.width, Game.height)

  local Camera = require "core.camera"
  Game.camera = Camera(0, 0, 512, 512)

  Game.state = state
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

function Game.update(dt)
  for key, obj in pairs(Game.entities) do
    if obj.update then
      obj:update(dt)
    end
  end
  Game.camera:update()
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

function Game.render()
  Game.camera:render()
end


return Game
