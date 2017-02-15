Game = require "core.game"
Entity = require "core.entity"
stalker = require "lib.stalker"
moon = require "moon"

juno.onLoad = ->
  G.Game = Game!
  i = Entity G.Game
  i\newImage "data/images/player/player", true
  i\addAnimation "idle", 1, 4
  i\setAnimation "idle"
  return

juno.onUpdate = (dt) ->
  stalker.update dt
  G.Game\update dt
  G.tick += 1
  return

juno.onKeyDown = (key, char) ->
  G.Game\key key, char

juno.onDraw = ->
  G.Game\draw!
  return

juno.onQuit = ->
  G.Game\stop!
  return
