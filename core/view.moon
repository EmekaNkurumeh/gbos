class View
  new: (pos, size, scale) =>
    @_x,@_y = pos.x, pos.y
    @_w,@_h = size.x, size.y
    @_sx,@_sy = scale.x, scale.y
    @canvas = juno.Buffer.fromBlank @_w, @_h

  set: (obj, x, y, rect, sx = 1, sy = sx) =>
    rect = table.merge {x: 0, y: 0, w: obj\getWidth!, h: obj\getHeight!}, rect
    @canvas\copyPixels obj, x, y, rect, sx, sy

  unset: =>
    @canvas\clear!

  draw: (drx = 0, dry = 0) =>
    juno.graphics.copyPixels @canvas, drx, dry, {x: @_x, y: @_y, w: @_w, h: @_h}, @_sx, @sy
    @unset!

  move: (dx, dy) =>
    @_x += (dx or 0)
    @_y += (dy or 0)

  zoom: (dsx, dsy) =>
    dsx or= 1
    @_sx *= dsx
    @_sy *= (dsy or dsx)

  setX: (x) =>
    @_x = if @_bounds then math.clamp x, @_bounds.x1, @_bounds.x2 else x

  setY: (y) =>
    @_y = if @_bounds then math.clamp y, @_bounds.y1, @_bounds.y2 else y

  goTo: (x, y) =>
    if x then @setX x
    if y then @setY y

  setScale: (dsx, dsy) =>
    @_sx = dsx or @_sx
    @_sy = dsy or @_sy

  getBounds: => (table.unpack or unpack) @_bounds

  setBounds: (x, y, w, h) =>
    @_bounds = {:w, :h, x1: x, y1: y, x2: x + w, y2: y + h}

View
