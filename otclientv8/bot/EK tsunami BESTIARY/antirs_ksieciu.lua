local m = macro(1000, "RS msg", function() end)

local frags = 0
onTextMessage(function(mode, text)
    if not m.isOn() then return end
    if not text:lower():find("the murder of") then return end
    say("Don't bother, I have anti-rs and shit EQ. Don't waste our time.")
    frags = frags + 1
    if killsToRs() <= 2 or frags > 5 then
        modules.game_interface.forceExit()
    end
end)