local haste = "utani tempo hur"
macro(500, "HasteIfNoMonster", function()
	if getMonsters(1) == 0 and not hasHaste() and not isInPz() then
	say(haste)
	end
end)