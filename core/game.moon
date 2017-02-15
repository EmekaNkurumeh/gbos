tick = require "lib.tick"
coil = require "lib.coil"
flux = require "lib.flux"
_ = require "lib.lume"
shash = require "lib.shash"
Save = require "core.save"
View = require "core.view"

class Game
  new: =>
    @entities = {}
    @save = Save "save.ini"
    @screen = View v2(0, 0), v2(512, 512), v2(G.scale, G.scale)
    @world = shash.new 16
    @debug = {}
    juno.debug.addIndicator (-> "#{@world\info "entities"} entities", @world\info "entities"), 0, 1000

  stop: =>
    @world\clear!
    @save\close!

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
