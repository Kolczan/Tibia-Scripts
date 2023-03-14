--[[
	This is a XenoBot example script, intended to
	teach new users about the scripting API and 
	act as script that is usable in actual play.
	
	supplyCountHUD.lua - displays a HUD with supply counts.
	This is a relatively advanced script!

	** DO NOT EDIT THIS FILE. INSTEAD, COPY IT TO
	"Documents\XenoBot\Scripts" AND EDIT THE COPY. **
]]--

--set the title of the HUD
local title = "===== XenoBot supply HUD ====="

--set the names of supplies to display
local supplies = 
{
	"strong mana potion",
	"great spirit potion",
	"power bolt",
}

--set the top left x and y coordinates of the HUD
local location =
{
	x = 25,
	y = 5
}

--set the colors for the HUD
local colors = 
{
	label = {140, 110, 140},
	count = {225, 225, 225},
	title = {255, 255, 0}
}

-------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------

--this creates the title HUD
local HUDTitle = HUD.CreateTextDisplay(location.x, location.y, title, unpack(colors.title))
location.y = location.y + 20 -- just offsets the y axis to below the header

--this loops over supplies table and creates the HUD elements for each supply
local HUDData = {}
for index, supply in ipairs(supplies) do
	local data = {}

	--find the item id
	data.itemId = Item.GetItemIDFromDualInput(supply)
	
	--create the label HUD
	data.label = HUD.CreateTextDisplay(
							-- +36 to put it to the right of the icon
							location.x + 36,
							-- +32 pixels to the y axis for every item
							location.y + ((index - 1) * 32),
							-- supply name
							supply,
							-- text color
							unpack(colors.label)
						)
	
	--create the count HUD
	data.count = HUD.CreateTextDisplay(
							location.x + 36,
							-- +14 puts it below the label
							location.y + ((index - 1) * 32) + 14,
							-- we don't know the count yet
							"",
							unpack(colors.count)
						)
	
	--create the icon HUD
	data.icon = HUD.CreateItemDisplay(
							location.x,
							location.y + ((index - 1) * 32),
							-- the item id to draw
							data.itemId,
							-- 32 square pixels in size
							32,
							-- draw the item as a full stack
							100
						)
						
	--store the data to use later
	HUDData[index] = data
end


--this continuously loops, executing the code inside over and over again
while (true) do
	--this loops over every element in the HUDData table
	for index, data in ipairs(HUDData) do
		--this updates the count label of each supply HUD
		data.count:SetText(Self.ItemCount(data.itemId))
	end
	
	--this causes the loop to wait 1 second before looping again
	wait(1000)
end