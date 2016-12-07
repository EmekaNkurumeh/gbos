class Camera
  new: (x,y,w,h,@rot) =>
    @pos = require("vec2")\new x,y
    @size = require("vec2")\new w,h
    @scale = require("vec2")\new 1,1
  set: (screen) =>
    juno.graphics.drawBuffer screen,0,0,{x:@x,y:@y,w:@w,h:@h},@rot,@scale.x,@scale.y
  unset: () =>
  
Camera