pop = table.remove
psh = table.insert

class Renderer
  new: (@num_layer = 5) =>
    @drawers = {}
    for i = 0, @num_layers do
      @drawers[i] = {}
      
  addRenderer: (obj,layer) =>
    l = layer or 0
    psh(@drawers[l],obj)
  
  draw: ()=>
    for layer = 0, #@drawers do
      for draw = 0, #@drawers[layer] do
        obj = @drawers[layer][draw]
        if obj != nil then
          obj:draw()
        
        
Renderer