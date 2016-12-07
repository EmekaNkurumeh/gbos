class GameLoop
  new: () =>
    @tickers = {}
      
  add: (obj) =>
    table.insert @tickers,obj
  
  update: (dt) =>
    for obj in *@tickers do
      if obj then
        obj\tick(dt)
        
        
GameLoop