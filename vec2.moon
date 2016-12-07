typeof = (val) ->
  xval = type(val) == "table"
  xpcall ->
    if xval and val.__class.__name
      xval = val.__class.__name
    else
      xval = type val,
    -> xval = "table"
  xval
class vec2
  new: (@x,@y) => @x,@y
  
  __add: (v) => 
    if typeof(v) == "vec2"
      vec2 @x+v.x,@y+v.y
    else 
      vec2 @x+v,@y+v
      
  __sub: (v) =>  
    if typeof(v) == "vec2"
      vec2 @x-v.x,@y-v.y
    else 
      vec2 @x-v,@y-v
      
  __mul: (v) =>  
    if typeof(v) == "vec2"
      vec2 @x*v.x,@y*v.y
    else 
      vec2 @x*v,@y*v
      
  __div: (v) =>  
    if typeof(v) == "vec2"
      vec2 @x/v.x,@y/v.y
    else 
      vec2 @x/v,@y/v
      
  __mod: (v) =>  
    if typeof(v) == "vec2"
      vec2 @x%v.x,@y%v.y
    else 
      vec2 @x%v,@y%v
      
  __unm: => vec2 -@x,-@y
  
  __eq: (v) =>  
    if typeof(v) == "vec2"
      if @x == v.x and @y == v.y then true else false
    else 
      if @x+@y == v then true else false
      
  __lt: (v) =>  
    if typeof(v) == "vec2"
      if @x < v.x and @y < v.y then true else false
    else 
      if @x+@y < v then true else false
      
  __le: (v) =>  
    if typeof(v) == "vec2"
      if @x <= v.x and @y <= v.y then true else false 
    else 
      if @x+@y <= v then true else false
      
  __concat: (v) =>
    if typeof(v) == "vec2" 
      vec2 tonumber("#{@x}#{v.x}"),tonumber("#{@y}#{v.y}")
    else
      vec2 tonumber("#{@x}#{v}"),tonumber("#{@y}#{v}")
      
  __len: => @x+@y
  
  __tostring: => "(#{@x},#{@y})"
  
  move: (v) => 
    if typeof(v) == "vec2"
      @ += v
    else 
      @x += v
      @y += v
  
  distance: (v) => math.sqrt ((@x-v.x)^2)+((@y-v.y)^2)
  
  middle: (v) => vec2 (@x+v.x)/2,(@y+v.y)/2
  
  clone: => @
  
  vec2