local utamoHp = 30
local exuraHp = 85
local safeMana = 25
macro(100, "utamo / exana", function()
    if hppercent() <= 47 and not hasManaShield() and manapercent() > safeMana then
        say("utamo vita")
    elseif hasManaShield() and (hppercent() >= 85 or manapercent() < safeMana) then
        say("exana vita")
    end
end)