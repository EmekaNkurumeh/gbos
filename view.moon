class Layer
  new: (@scale,width,height) =>
    @buffer = juno.Buffer.fromBlank width,height
    @width = @buffer\getWidth!
    @height = @buffer\getHeight!

  draw: (obj,x = 0,y = 0,box,sx = 1,sy = 1) =>
    @buffer\copyPixels obj,x,y,box and {x:box.x,y:box.y,w:box.w,h:box.h} or nil,sx,sy

class View
  new: (pos,size,scale,) =>
    @_x,@_y = pos.x,pos.y
    @_w,@_h = size.x,size.y
    @_sx,@_sy = scale.x,scale.y
    @layers = {}
    @canvas = juno.Buffer.fromBlank @_w,@_h

  add_layer: (layer) =>
    table.insert @layers, layer
    table.sort @layers, ((a, b) -> a.scale < b.scale)

  set: (obj,x,y,sx = @_sx,sy = @_sy) =>
    @canvas\copyPixels obj,x,y,{x:@_x,y:@_y,w:@_w,h:@_h},sx,sy

  unset: () =>
    @canvas\clear!

  draw: (screen,drx=0,dry=0) =>
    for layer in *@layers
      @set layer.buffer,@_x,@_y,layer.scale,layer.scale
    @canvas\drawBox @_x,@_y,@_w,@_h
    if not screen
      juno.graphics.drawBuffer @canvas,drx,dry
    elseif screen
      screen\drawBuffer @canvas, drx, dry
    @unset!

  move: (dx,dy) =>
    @_x += (dx or 0)
    @_y += (dy or 0)

  zoom: (dsx,dsy) =>
    dsx or= 1
    @_sx *= dsx
    @_sy *= (dsy or dsx)

  setX: (x) =>
    @_x = if @_bounds then math.clamp x,@_bounds.x1,@_bounds.x2 else x

  setY: (y) =>
    @_y = if @_bounds then math.clamp y,@_bounds.y1,@_bounds.y2 else y

  goTo: (x,y) =>
    if x then @setX x
    if y then @setY y

  setScale: (dsx,dsy) =>
    @_sx = dsx or @_sx
    @_sy = dsy or @_sy

  getBounds: => (table.unpack or unpack) @_bounds

  setBounds: (x,y,w,h) =>
    @_bounds = {:w,:h,x1:x,y1:y,x2:x+w,y2:y+h}

{:Layer,:View}
