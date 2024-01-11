local m = macro(1000, "Ksieciu antiRS msg", function() end)

local frags = 0
onTextMessage(function(mode, text)
    if not m.isOn() then return end
    if not text:lower():find("the murder of") then return end
    say("Don't bother, I have anti-rs and shit EQ. Don't waste our time.")
    frags = frags + 1
    if killsToRs() <= 4 or frags > 3 then
        modules.game_interface.forceExit()
    end
end)