macro(250, "Exit <4 frags", function()
if (killsToRs() <= 4) then
modules.game_interface.forceExit()
end
end)