class Layer
  new: (@scale,width,height) =>
    @buffer = juno.Buffer.fromBlank width,height
    @width = @buffer\getWidth!
    @height = @buffer\getHeight!

  draw: (obj,x = 0,y = 0,box,rot = 0,sx = 1,sy = 1) =>
    @buffer\draw obj,x,y,box and {x:box.x,y:box.y,w:box.w,h:box.h} or nil,rot,sx,sy

Layer
