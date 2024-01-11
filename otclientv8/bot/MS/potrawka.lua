macro(600000, "potrawka mana",  function()
  if mppercent() <= 15 then
    g_game.use(findItem(9086))
  end
end)