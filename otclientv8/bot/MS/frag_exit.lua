macro(250, "Exit on 3 frags", function()
if (killsToRs() <= 4) then
modules.game_interface.forceExit()
end
end)