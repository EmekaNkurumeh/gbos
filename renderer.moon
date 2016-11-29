class Renderer
  new: (@layers = 5) =>
    @buffers = {}
    for i = 1, @layers do
      @buffers[i] = {}
      
  addRenderer: (obj,layer) =>
    l = layer or 1
    table.insert @buffers[l],obj
  
  draw: () =>
    for layer = 1, #@buffers do
      for obj in *@buffers[layer] do
        if obj[i] then
          obj[i]\draw!
        
        
Renderer