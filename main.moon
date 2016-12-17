Renderer = require "renderer"
GameLoop = require "gameloop"
stalker = require "lib.stalker"

pi = math.pi
rand = math.random

juno.onLoad = () ->
  G.Renderer = Renderer!
  G.GameLoop = GameLoop!
  math.randomseed(os.time())
  rand()
  rand()
  G.screen = juno.Buffer.fromBlank juno.graphics.getSize!
  G.time = 0
  G.CIRC = {
    {x:0,y:0,r:4},
    {x:0,y:0,r:4},
    {x:0,y:0,r:4}
  }
  return

date = ->
  if math.floor(juno.time.getTime! % 6) == 5
    os.execute "echo \"tup: #{G.tim}\""
    G.xc = 1

juno.onUpdate = (dt) ->
  stalker.update dt
  G.fps = juno.time.getFps()
  G.GameLoop\update(dt)
  G.;t
  G.time += 1
  interval = 1
  amp = 8
  G.CIRC.o = 8 * math.sin G.time * .5 * pi
  if math.floor(juno.time.getTime! % 6) == 5
    os.execute "echo \"tup: #{G.tim}\""


  return

juno.onDraw = () ->
  G.Renderer\draw!
  -- print(G.time)
  G.screen\drawCircle ((G.width)/2)-16,((G.height)/2),4
  G.screen\drawCircle ((G.width)/2),((G.height)/2)+G.CIRC.o,4
  G.screen\drawCircle ((G.width)/2)+16,((G.height)/2),4
  juno.graphics.drawBuffer G.screen,0,0,nil,0,G.scale
  G.screen\clear!
  return
