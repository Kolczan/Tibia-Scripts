local healthId = 9079
local healthPercent = 30
macro(600000, "potrawka EK HP",  function()
  if hppercent() <= healthPercent then
    useWith(healthId, player) 
  end
end)