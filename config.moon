export *
G = {
  title: "gamebox",
  width: 128,
  height: 128,
  scale: 4,
  tick: 0,
}

math.clamp = (_, min, max) ->
  (_ < min) and min or (_ > max and max) or _
math.tau = math.pi * 2
v2 = require "vec2"

{
  title: G.title,
  width: G.width * G.scale,
  height: G.height * G.scale
}
