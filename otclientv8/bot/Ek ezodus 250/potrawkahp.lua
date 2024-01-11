macro(10, "Blessed Steak", function()
	if manapercent() < 20 and not isInPz() then
		useWith(9086, player)
	end
end)