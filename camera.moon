class Camera
  X: (@_x) =>

  Y: (@_y) =>
  
  @@clamp: (_, min, max) => (_ < min) and min or (_ > max and max) or _
  
  new: (pos,size,scale,@rot) =>
    @_x,@_y = pos.x,pos.y
    @_w,@_h = size.x,size.y
    @_sx,@_sy = scale.x,scale.y

  set: (screen) =>
    juno.graphics.drawBuffer screen,0,0,{x:@_x,y:@_y,w:@_w,h:@_h},@_rot,@_sx,@_sy

  unset: (screen) =>
    screen:reset()
    juno.graphics.reset()

  move: (dx,dy) =>
    @_x += (dx or 0)
    @_y += (dy or 0)
  
  rotate: (dr) =>
    @_rot += dr

  zoom: (dsx,dsy) =>
    dsx or= 1
    @_sx *= dsx
    @_sy *= (dsy or dsx)

  goto: (x,y) =>
    if x then @X x
    if y then @Y y
  
  setScale: (dsx,dsy) =>
    @_sx = dsx or @_sx
    @_sy = dsy or @_sy
    
Camera