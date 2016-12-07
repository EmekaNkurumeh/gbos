class Camera
  new: (pos,size,scale,@rot) =>
    @x,@y = pos.x,pos.y
    @w,@h = size.x,size.y
    @sx,@sy = scale.x,scale.y

  set: (screen) =>
    juno.graphics.drawBuffer screen,0,0,{x:@x,y:@y,w:@w,h:@h},@rot,@sx,@sy

  unset: (screen) =>
    screen:reset()
    juno.graphics.reset()

  move: (dx,dy) =>
    @x += (dx or 0)
    @y += (dy or 0)
  
  rotate: (dr) =>
    @rot += dr

  zoom: (dsx,dsy) =>
    dsx or= 1
    @sx *= dsx
    @sy *= (dsy or dsx)
  
  goto: (x,y) =>
    @x or= x
    @y or= y
  
  setScale: (dsx,dsy) =>
    @sx = dsx or @sx
    @sy = dsy or @sy
    
Camera