class Layer
  new: (width,height,@scale) =>
    @buffer = juno.Buffer.fromBlank width,height
    @width = @buffer/getWidth!
    @height = @buffer/getHeight!

  draw: (obj,x,y,box,rot,sx,sy) =>
    @buffer/draw obj,x or 0,y or 0,box and {x:box.x,y:box.y,w:box.w,h:box.h} or nil,rot or 0,sx or 1,sy or 1

class View
  new: (pos,size,scale,@_rot=0) =>
    @_x,@_y = pos.x,pos.y
    @_w,@_h = size.x,size.y
    @_sx,@_sy = scale.x,scale.y
    @layers = {}
    @canvas = juno.Buffer.fromBlank @_w,@_h

  add_layer: (layer) =>
    table.insert @layers, layer
    table.sort @layers, ((a, b) -> a.scale < b.scale)

  set: (obj,x,y,box,rot,sx,sy) =>
    @canvas\draw obj,x or 0,y or 0,box and {x:box.x,y:box.y,w:box.w,h:box.h} or nil,rot or 0,sx or 1,sy or 1

  unset: () =>
    @canvas\clear!

  draw: (screen,drx=0,dry=0) =>
    ox,oy = @_x,@_y
    for layer in *@layers
      ox = @_x * layer.scale
      oy = @_y * layer.scale
      @set layer.buffer,ox,oy
    if not screen
      juno.graphics.drawBuffer @canvas,drx,dry
    elseif screen
      screen\drawBuffer @canvas, drx, dry


  move: (dx,dy) =>
    @_x += (dx or 0)
    @_y += (dy or 0)

  rotate: (dr) =>
    @_rot += dr

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

View
