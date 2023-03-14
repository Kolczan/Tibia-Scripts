--[[
	This is a XenoBot example script, intended to
	teach new users about the scripting API and 
	act as script that is usable in actual play.
	
	enemyAlert_classic.lua - alerting when enemies are
	on screen using the classic coding style

	** DO NOT EDIT THIS FILE. INSTEAD, COPY IT TO
	"Documents\XenoBot\Scripts" AND EDIT THE COPY. **
]]--


--set the names of your enemies here
local enemies = 
{
	"Cachero",
	"Bubble",
	"Eternal Oblivion",
}

-------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------

--this continuously loops, executing the code inside over and over again
while (true) do
	--this loops over every element in the enemies table
	for _, enemy in ipairs(enemies) do
		--this constructs a new creature with the enemies name
		local creature = Creature.New(enemy)
		--this checks if the creature obtained above is alive and on screen, and alerts if so
		if (creature:isOnScreen(multiFloor) and creature:isVisible() and creature:isAlive()) then
			alert()
			break --break exits the inner-most loop
		end
	end
    
    --this causes the loop to wait 1 second before checking again
	wait(1000)
end