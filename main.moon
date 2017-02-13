Game = require "core.game"
stalker = require "lib.stalker"

juno.onLoad = ->
  G.Game = Game!
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
