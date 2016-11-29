pop = table.remove
psh = table.insert

class GameLoop
  new: () =>
    @tickers = {}
      
  addLoop: (obj) =>
    psh(@tickers,obj)
  
  update: (dt)=>
    for obj in *@tickers do
      if obj != nil then
        obj\tick(dt)
        
        
GameLoop