macro(10, "Blessed Steak", function()
	if hppercent() < 20 and not isInPz() then
		g_game.use(findItem(9079))
	end
end)

