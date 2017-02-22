tick = require "lib.tick"
coil = require "lib.coil"
flux = require "lib.flux"
_ = require "lib.lume"
shash = require "lib.shash"
Save = require "core.save"
View = require "core.view"
Entity = require "core.entity"

class Game
  new: =>
    @entities = {}
    @save = Save "save.ini"
    @save\set({plays: (@save\get("plays") or 0) + 1})
    print "plays: #{@save\get("plays")}"
    @screen = View v2(0, 0), v2(512, 512), v2(2,2)
    @world = shash.new 1
    @i = Entity @
    @i\loadImage "data/images/player/player", 16, 16
    @i\addAnimation "idle", {1,2,3,4}, 9, true
    @i\play "idle"

    @d = Entity @
    @d\loadImage "data/images/player/player", 16, 16
    @d\addAnimation "idle", {1,2,3,4}, 9, true
    @d\play "idle"
    @d\setX 64
    @d\setY 64

  stop: =>
    @world\clear!

  add: (obj) =>
    @entities[obj] = obj
    @world\add obj, obj.x, obj.y, obj.w, obj.h

  remove: (obj) =>
    if @entities[obj]
      @entities[obj] = nil
      @world\remove obj

  update: (dt) =>
    for key, obj in pairs @entities do
      if obj.update then
        obj\update dt
    s = 200
    if juno.keyboard.isDown "left"
      @i.accel.x = -s
    elseif juno.keyboard.isDown "right"
      @i.accel.x = s
    else
      @i.accel.x = 0
    if juno.keyboard.isDown "up"
      @i.accel.y = -s
    elseif juno.keyboard.isDown "down"
      @i.accel.y = s
    else
      @i.accel.y = 0

  key: (key, char) =>
    switch key
      when "tab"
        juno.debug.setVisible not juno.debug.getVisible!
      when "`"
        juno.debug.setFocused not juno.debug.getFocused!
      when "escape"
        os.exit!
      when "r"
        juno.onLoad!

  draw: =>
    for key, obj in pairs @entities do
      if obj.visible then
        obj\draw @screen

    @screen\draw 0, 0
