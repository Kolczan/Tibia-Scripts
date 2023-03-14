--[[
	XenoLuaLib

	Global
	Module
	Client
	HUD
	Channel
	Creature
	Container
	Item
	Map
	Self

	table
	string
	compats
]]

DIALOG_NEXT_PAGE_BUTTON = 0x0EADBEE1
DIALOG_PREVIOUS_PAGE_BUTTON = 0x0EADBEE2
DIALOG_MAX_ITEMS = 24
DIALOG_ITEMS_PER_PAGE = 20

NORTH = 0
EAST = 1
SOUTH = 2
WEST = 3
SOUTHWEST = 4
SOUTHEAST = 5
NORTHWEST = 6
NORTHEAST = 7
DIRECTIONS = {"north", "east", "south", "west", "southwest", "southeast", "northwest", "northeast"}

SPEAK_SAY = 0
SPEAK_YELL = 2
SPEAK_WHISPER = 3
SPEAK_NPC = 4

SLOT_HEAD = 0
SLOT_AMULET = 1
SLOT_BACKPACK = 2
SLOT_ARMOR = 3
SLOT_SHIELD = 4
SLOT_WEAPON = 5
SLOT_LEGS = 6
SLOT_FEET = 7
SLOT_RING = 8
SLOT_AMMO = 9
EQUIPMENT_SLOTS = {"head", "amulet", "backpack", "armor", "shield", "weapon", "legs", "feet", "ring", "ammo"}

WEAPON_IDS = {660, 661, 662, 663, 664, 665, 666, 667, 668, 669, 670, 671, 672, 673, 674, 679, 680, 681, 682, 683, 684, 685, 686, 687, 688, 689, 690, 691, 692, 693, 779, 780, 781, 782, 783, 784, 785, 786, 787, 788, 789, 790, 791, 792, 793, 794, 795, 796, 797, 798, 801, 802, 803, 804, 805, 806, 807, 808, 809, 810, 3208, 3264, 3265, 3266, 3267, 3268, 3269, 3270, 3271, 3272, 3273, 3274, 3275, 3276, 3278, 3279, 3280, 3281, 3282, 3283, 3284, 3285, 3286, 3288, 3289, 3290, 3291, 3292, 3293, 3294, 3295, 3296, 3297, 3299, 3300, 3301, 3302, 3303, 3304, 3305, 3306, 3307, 3308, 3309, 3310, 3311, 3312, 3313, 3314, 3315, 3316, 3317, 3318, 3319, 3320, 3322, 3323, 3324, 3325, 3326, 3327, 3328, 3329, 3330, 3331, 3332, 3333, 3334, 3335, 3336, 3337, 3338, 3339, 3340, 3341, 3342, 3343, 3344, 3345, 3346, 3348, 3453, 6527, 6553, 7379, 7380, 7381, 7382, 7383, 7384, 7385, 7386, 7387, 7388, 7389, 7390, 7391, 7392, 7402, 7403, 7404, 7405, 7406, 7407, 7408, 7409, 7410, 7411, 7412, 7413, 7414, 7415, 7416, 7417, 7418, 7419, 7420, 7421, 7422, 7423, 7424, 7425, 7426, 7427, 7428, 7429, 7430, 7431, 7432, 7433, 7434, 7435, 7436, 7437, 7449, 7450, 7451, 7452, 7453, 7454, 7455, 7456, 7773, 7774, 8096, 8097, 8098, 8099, 8100, 8101, 8102, 8103, 8104, 9373, 9375, 9376, 9384, 9385, 9386, 9387, 9396, 10388, 10389, 10390, 10391, 10392, 10406, 11657, 11692, 11693, 12673, 12683, 13987, 13991, 14001, 14040, 14043, 14089, 14250, 16160, 16161, 16162, 16175, 17812, 17813, 17824, 17828, 17859, 20064, 20065, 20066, 20067, 20068, 20069, 20070, 20071, 20072, 20073, 20074, 20075, 20076, 20077, 20078, 20079, 20080, 20081, 21171, 21172, 21173, 21174, 21176, 21177, 21178, 21179, 21180, 21219}


os.execute = nil
io.popen = nil

math.randomseed(os.time())

--- Registers a function name to run as a special loop type in the bot.
-- Used to register TIMER_TICK or WALKER_SELECTLABEL functions
-- @class Global
-- @param eventType the type of function you want to register
-- @param functionName the function name you want to register
-- @return void returns nothing
function registerEventListener(eventType, functionName)
	if (eventType == TIMER_TICK) then
		return Module.New(functionName, functionName)
	end
	return registerNativeEventListener(eventType, functionName)
end

--- Compares two numbers
-- Returns true if numbers given are equal, false if not
-- @class Global
-- @param a number one
-- @param b number two
-- @return boolean true or false
function eq(a, b)
	return a == b
end

--- Compares two numbers
-- Returns true if numbers given are unequal, false if not
-- @class Global
-- @param a number one
-- @param b number two
-- @return boolean true or false
function neq(a, b)
	return a ~= b
end

--- Compares two numbers
-- Returns true if first number given is greater than second, false if not
-- @class Global
-- @param a number one
-- @param b number two
-- @return boolean true or false
function gt(a, b)
	return a > b
end

--- Compares two numbers
-- Returns true if first number given is less than second, false if not
-- @class Global
-- @param a number one
-- @param b number two
-- @return boolean true or false
function lt(a, b)
	return a < b
end

--- Displays a green text message.
-- Used to print debug or informational messages to the client
-- @class Global
-- @param s the message to display
-- @param ... optional; any further variables tokenized in the string
-- @return void returns nothing
function print(s, ...)
	displayInformationMessage(#{...} > 0 and s:format(...) or s)
end

--- Sleeps for designated time.
-- Used to delay the script environment for a specified time (has to be greater than/equal to 100 ms)
-- @class Global
-- @param a the time to sleep for
-- @param b optional; will cause function to randomly choose a number between a and b
-- @return void returns nothing
function wait(a, b)
	if not b then sleep(a) else sleep(math.random(a, b)) end
end

--- Compares two positions on the map.
-- Returns true if positions given are adjacent to eachother
-- @class Global
-- @param pos1 the initial position table.
-- @param pos2 the destination position table to compare.
-- @return boolean true or false
function isPositionAdjacent(pos1, pos2)
	return (math.abs(pos1.x - pos2.x) <= 1 and math.abs(pos1.y - pos2.y) <= 1 and pos1.z == pos2.z)
end

--- Compares two positions on the map.
-- Returns the max distance between two specific positions, either x or y
-- @class Global
-- @param pos1 the initial position table.
-- @param pos2 the destination position table to compare.
-- @return number the distance between positions given
function getDistanceBetween(pos1, pos2)
	return math.max(math.abs(pos1.x - pos2.x), math.abs(pos1.y - pos2.y))
end

--- Get specific position coordinates in direction and range from position
-- Returns the position coordinates from the direction and range.
-- @class Global
-- @param pos the initial position table.
-- @param dir the direction to search for.
-- @param len the range distance from the initial position.
-- @return table the destination position table
function getPositionFromDirection(pos, dir, len)
	local n = len or 1
	if (dir == NORTH) then
		pos.y = pos.y - n
	elseif (dir == SOUTH) then
		pos.y = pos.y + n
	elseif (dir == WEST) then
		pos.x = pos.x - n
	elseif (dir == EAST) then
		pos.x = pos.x + n
	elseif (dir == NORTHWEST) then
		pos.y = pos.y - n
		pos.x = pos.x - n
	elseif (dir == NORTHEAST) then
		pos.y = pos.y - n
		pos.x = pos.x + n
	elseif (dir == SOUTHWEST) then
		pos.y = pos.y + n
		pos.x = pos.x - n
	elseif (dir == SOUTHEAST) then
		pos.y = pos.y + n
		pos.x = pos.x + n
	end
	return pos
end

--- Toggle all features.
-- Enables or disables walker looter and targeter
-- @class Global
-- @param status true enables, false disables
-- @return void returns nothing
function setBotEnabled(status)
	setWalkerEnabled(status)
	setLooterEnabled(status)
	setTargetingEnabled(status)
end

--
--      888b     d888               888          888               .d8888b.  888                            
--      8888b   d8888               888          888              d88P  Y88b 888                            
--      88888b.d88888               888          888              888    888 888                            
--      888Y88888P888  .d88b.   .d88888 888  888 888  .d88b.      888        888  8888b.  .d8888b  .d8888b  
--      888 Y888P 888 d88""88b d88" 888 888  888 888 d8P  Y8b     888        888     "88b 88K      88K      
--      888  Y8P  888 888  888 888  888 888  888 888 88888888     888    888 888 .d888888 "Y8888b. "Y8888b. 
--      888   "   888 Y88..88P Y88b 888 Y88b 888 888 Y8b.         Y88b  d88P 888 888  888      X88      X88 
--      888       888  "Y88P"   "Y88888  "Y88888 888  "Y8888       "Y8888P"  888 "Y888888  88888P'  88888P' 
--

Module = {}
libModules = {}
Module.__index = Module
modulesRegistered = false

--- This function should not be used by the regular user and is therefore not explained
function libOnTimer()
	if (#libModules > 0) then
		for i, m in ipairs(libModules) do
			if (m._tempDelay < (os.clock()*1000) and m._tempDelay > 0 and not m._active) then
				m.delayTime = 0
				m._active = true
			end
			if (m._active) then
				m:Execute()
			end
		end
	end
end

--- This function should not be used by the regular user and is therefore not explained
function libDestroyTimer(name)
	for i, m in ipairs(libModules) do
		if (m:Name() == name) then
			m:Stop()
			table.remove(libModules, i)
			break
		end
	end
end

--- Creates a new module.
-- Registers the specified function to loop as a module
-- @class Module
-- @param name the name to identify the module as
-- @param moduleFunction the function to be executed
-- @param startOnCreate optional; whether to execute on create or not default is true
function Module.New(name, moduleFunction, startOnCreate)
	local m = {}
	startOnCreate = (startOnCreate ~= false) and true or false
	if (moduleFunction) then -- adding new
		if (not modulesRegistered) then
			registerNativeEventListener(TIMER_TICK, 'libOnTimer')
			modulesRegistered = true
		end
		libDestroyTimer(name) -- replace any with same name
		setmetatable(m, Module)
		m._name = name
		m._function = moduleFunction
		m._active = startOnCreate
		m._tempDelay = 0
		table.insert(libModules, m)
	else -- retrieving
		for i, mod in ipairs(libModules) do
			if (mod:Name() == name) then
				m = mod
				break
			end
		end
	end
	return m
end

setmetatable(Module, {__call = function(_, ...) return Module.New(...) end})

--- Executes a specific module.
-- Manually triggers the module function
-- @class Module
-- @return ambiguous anything the function being called might return
function Module:Execute()
	self = type(self) == 'table' and self or Module.New(self)
	
	if (type(self._function) == 'string') then
		self._function = _G[self._function]
	end
	return self:_function()
end

--- Returns the module name.
-- Returns the name that the module was registered under
-- @class Module
-- @return string the module name
function Module:Name()
	return self._name
end

--- Returns the module running status.
-- Returns whether or not the module function is currently running
-- @class Module
-- @return boolean module status
function Module:IsActive()
	self = type(self) == 'table' and self or Module.New(self)
	return self._active
end

--- Starts the module.
-- Sets the module to active to start executing the function
-- @class Module
-- @return void returns nothing
function Module:Start()
	self = type(self) == 'table' and self or Module.New(self)
	self._active = true
end

--- Delays the module.
-- Pauses the module for a specific amount of time
-- @class Module
-- @param delayTime amount of time in milliseconds to delay the module
-- @return void returns nothing
function Module:Delay(delayTime)
	self = type(self) == 'table' and self or Module.New(self)
	self._tempDelay = (os.clock() * 1000) + delayTime
	self._active = false
end

--- Stops the module.
-- Stops the module permanently
-- @class Module
-- @return void returns nothing
function Module:Stop()
	self = type(self) == 'table' and self or Module.New(self)
	self._active = false
	self._tempDelay = 0
end

--
--       .d8888b.  888 d8b                   888         .d8888b.  888                              
--      d88P  Y88b 888 Y8P                   888        d88P  Y88b 888                              
--      888    888 888                       888        888    888 888                              
--      888        888 888  .d88b.  88888b.  888888     888        888  8888b.  .d8888b  .d8888b    
--      888        888 888 d8P  Y8b 888 "88b 888        888        888     "88b 88K      88K        
--      888    888 888 888 88888888 888  888 888        888    888 888 .d888888 "Y8888b. "Y8888b.   
--      Y88b  d88P 888 888 Y8b.     888  888 Y88b.      Y88b  d88P 888 888  888      X88      X88   
--       "Y8888P"  888 888  "Y8888  888  888  "Y888      "Y8888P"  888 "Y888888  88888P'  88888P'   
--

Client = {}

--- Hide equipment window.
-- Minimizes the equipment window
-- @class Client
-- @return void returns nothing
Client.HideEquipment = minimizeEquipment

--- Show equipment window.
-- Maximizes the equipment window
-- @class Client
-- @return void returns nothing
Client.ShowEquipment = maximizeEquipment

--
--      888    888 888     888 8888888b.       .d8888b.  888
--      888    888 888     888 888  "Y88b     d88P  Y88b 888
--      888    888 888     888 888    888     888    888 888
--      8888888888 888     888 888    888     888        888  8888b.  .d8888b  .d8888b
--      888    888 888     888 888    888     888        888     "88b 88K      88K
--      888    888 888     888 888    888     888    888 888 .d888888 "Y8888b. "Y8888b.
--      888    888 Y88b. .d88P 888  .d88P     Y88b  d88P 888 888  888      X88      X88
--      888    888  "Y88888P"  8888888P"       "Y8888P"  888 "Y888888  88888P'  88888P' 
--

HUD = {}
HUD.__index = HUD


HUD.GetMainWindowDimensions = HUDGetDimensions
function HUD.GetContainerDimensions()
	local dimensions = HUDGetContainerDimensions()
	local dimensionsParsed = {}
	local current = 1
	for i = 1, #dimensions, 5 do
		local temp = {}
		temp.x = dimensions[i+0]
		temp.y = dimensions[i+1]
		temp.w = dimensions[i+2]
		temp.h = dimensions[i+3]
		temp.containerID = dimensions[i+4]
		dimensionsParsed[current] = temp
		current = current + 1
	end
	return dimensionsParsed
end

--- Draws text or items in the game window.
-- Draws a Head-Up Display with the specified text/item
-- @class HUD
-- @param x coordinate of the game window on the x-axis
-- @param y coordinate of the game window on the y-axis
-- @param value the text or itemid to draw on the screen
-- @param r intensity of the color red (0-255) OR the item size if drawing an item
-- @param g intensity of the color green (0-255) OR the item count if drawing an item
-- @param b intensity of the color blue (0-255) OR do not enter this if drawing an item
-- @return object HUD
function HUD.New(x, y, value, r, g, b)
	local c = {}
	setmetatable(c, HUD)
	if (type(value) == 'number') then
		c._pointer = HUDCreateItemImage(x, y, value, r, g)
	else
		c._pointer = HUDCreateText(x, y, value, r, g, b)
	end
	return c
end

setmetatable(HUD, {__call = function(_, ...) return HUD.New(...) end})

--- Please refer to the explanation of HUD.New()
HUD.CreateTextDisplay = HUD.New

--- Please refer to the explanation of HUD.New()
HUD.CreateItemDisplay = HUD.New

--- Change HUD coordinates.
-- Adjust an existing display's coordinates
-- @class HUD
-- @param x coordinate of the client window on the x-axis
-- @param y coordinate of the client window on the y-axis
-- @return boolean true or false
function HUD:SetPosition(x, y)
	return HUDUpdateLocation(self._pointer, x, y)
end

--- Change HUD text.
-- Adjust an existing display's text
-- @class HUD
-- @param text the content to draw on the screen
-- @return boolean true or false
function HUD:SetText(text)
	return HUDUpdateTextText(self._pointer, text)
end

--- Change HUD text color.
-- Adjust an existing display's text color
-- @class HUD
-- @param r intensity of the color red (0-255)
-- @param g intensity of the color green (0-255)
-- @param b intensity of the color blue (0-255)
-- @return boolean true or false
function HUD:SetTextColor(r, g, b)
	return HUDUpdateTextColor(self._pointer, r, g, b)
end

--- Change HUD item id.
-- Adjust an existing display's item clientid
-- @class HUD
-- @param id the client itemid representing the sprite to draw
-- @return boolean true or false
function HUD:SetItemID(id)
	return HUDUpdateItemImageID(self._pointer, id)
end

--- Change HUD item size.
-- Adjust an existing display's item size
-- @class HUD
-- @param size the size of the item to draw
-- @return boolean true or false
function HUD:SetItemSize(size)
	return HUDUpdateItemImageSize(self._pointer, size)
end

--- Change HUD item count.
-- Adjust an existing display's item badge count
-- @class HUD
-- @param count the number badge to display on the sprite
-- @return boolean true or false
function HUD:SetItemCount(count)
	return HUDUpdateItemImageCount(self._pointer, count)
end


--- Change destroy this HUD object.
-- Destroys the HUD
-- @class HUD
-- @return boolean true or false
function HUD:Destroy()
	local r = HUDDestroyObject(self._pointer)
	self = nil
	return r
end


--
--       .d8888b.  888                                          888      .d8888b.  888                            
--      d88P  Y88b 888                                          888     d88P  Y88b 888                            
--      888    888 888                                          888     888    888 888                            
--      888        88888b.   8888b.  88888b.  88888b.   .d88b.  888     888        888  8888b.  .d8888b  .d8888b  
--      888        888 "88b     "88b 888 "88b 888 "88b d8P  Y8b 888     888        888     "88b 88K      88K      
--      888    888 888  888 .d888888 888  888 888  888 88888888 888     888    888 888 .d888888 "Y8888b. "Y8888b. 
--      Y88b  d88P 888  888 888  888 888  888 888  888 Y8b.     888     Y88b  d88P 888 888  888      X88      X88 
--       "Y8888P"  888  888 "Y888888 888  888 888  888  "Y8888  888      "Y8888P"  888 "Y888888  88888P'  88888P' 
--

Channel = {}
libChannels = {}
Channel.__index = Channel
channelEventsRegistered = false

--- Create new channel.
-- Opens a new channel window with a specified name and callbacks
-- @class Channel
-- @param name the name of the channel
-- @param speakCallback the function to trigger on user input
-- @param closeCallback the function to trigger when the user closes the channel
-- @return object Channel
function Channel.New(name, speakCallback, closeCallback)
	if (not channelEventsRegistered) then
		channelEventsRegistered = true
		registerEventListener(EVENT_SELF_CHANNELSPEECH, "libOnCustomChannelSpeak")
		registerEventListener(EVENT_SELF_CHANNELCLOSE, "libOnCustomChannelClose")
	end
	local c = {}
	setmetatable(c, Channel)
	c._name = name
	c._id = luaOpenCustomChannel(name)
	c._speakCallback = speakCallback
	c._closeCallback = closeCallback
	table.insert(libChannels, c)
	return c
end

setmetatable(Channel, {__call = function(_, ...) return Channel.New(...) end})

--- Please refer to the explanation of Channel.New()
Channel.Open = Channel.New

--- Get Channel Name.
-- Returns the name of the channel object
-- @class Channel
-- @return string channel name
function Channel:Name()
	return self._name
end

--- Get Channel ID.
-- Returns the id of the channel object
-- @class Channel
-- @return number channel id
function Channel:ID()
	return self._id
end

--- Closes Channel.
-- Closes the channel and destroys it's object
-- @class Channel
-- @return void returns nothing
function Channel:Close()
	luaCloseCustomChannel(self._id)
	for i, c in ipairs(libChannels) do
		if (c:ID() == self._id) then
			c:CloseCallback()
			table.remove(libChannels, i)
			break
		end
	end
end

--- Sends orange message.
-- Displays an orange message in the channel
-- @class Channel
-- @param sender the text to show where character's names are displayed
-- @param text the message to display
-- @return void returns nothing
function Channel:SendOrangeMessage(sender, text)
	luaSendChannelMessage(self._id, CHANNEL_ORANGE, sender, text)
end

--- Sends red message.
-- Displays a red message in the channel
-- @class Channel
-- @param sender the text to show where character's names are displayed
-- @param text the message to display
-- @return void returns nothing
function Channel:SendRedMessage(sender, text)
	luaSendChannelMessage(self._id, CHANNEL_RED, sender, text)
end

--- Sends yellow message.
-- Displays a yellow message in the channel
-- @class Channel
-- @param sender the text to show where character's names are displayed
-- @param text the message to display
-- @return void returns nothing
function Channel:SendYellowMessage(sender, text)
	luaSendChannelMessage(self._id, CHANNEL_YELLOW, sender, text)
end

--- This function should not be used by the regular user and is therefore not explained
function Channel:SpeakCallback(message)
	if (self._speakCallback == nil) then return 0 end
	return self._speakCallback(self, message)
end

--- This function should not be used by the regular user and is therefore not explained
function Channel:CloseCallback()
	if (self._closeCallback == nil) then return 0 end
	return self._closeCallback(self)
end

--- This function should not be used by the regular user and is therefore not explained
function libOnCustomChannelClose(channel)
	for i, c in ipairs(libChannels) do
		if (c:ID() == math.floor(channel)) then
			c:CloseCallback()
			table.remove(libChannels, i)
			break
		end
	end
end

--- This function should not be used by the regular user and is therefore not explained
function libOnCustomChannelSpeak(channel, message)
	for i, c in ipairs(libChannels) do
		if (c:ID() == math.floor(channel)) then
			c:SpeakCallback(message)
			break
		end
	end
end

--
--       .d8888b.                            888                                   .d8888b.  888                            
--      d88P  Y88b                           888                                  d88P  Y88b 888                            
--      888    888                           888                                  888    888 888                            
--      888        888d888  .d88b.   8888b.  888888 888  888 888d888  .d88b.      888        888  8888b.  .d8888b  .d8888b  
--      888        888P"   d8P  Y8b     "88b 888    888  888 888P"   d8P  Y8b     888        888     "88b 88K      88K      
--      888    888 888     88888888 .d888888 888    888  888 888     88888888     888    888 888 .d888888 "Y8888b. "Y8888b. 
--      Y88b  d88P 888     Y8b.     888  888 Y88b.  Y88b 888 888     Y8b.         Y88b  d88P 888 888  888      X88      X88 
--       "Y8888P"  888      "Y8888  "Y888888  "Y888  "Y88888 888      "Y8888       "Y8888P"  888 "Y888888  88888P'  88888P' 
--

Creature = {}
Creature.__index = Creature

--- Creates a creature object.
-- Creates and returns a creature object using it's a name, creature id, or index
-- @class Creature
-- @param value the creature's name, id, or index
-- @return object Creature
function Creature.New(value)
	local c = {}
	setmetatable(c, Creature)
	-- Metatable overrides
	Creature.__tostring = function(a)
		return a:Name()
	end
	Creature.__eq = function(a, b)
		return a:ID() == b:ID()
	end
	Creature.__concat = function(a, b)
		return a:Name() .. ', ' .. b:Name()
	end
	if (value == nil) then
		c._id = -1
		c._listindex = -1
		c._name = ""
	else
		if (type(value) == 'string') then
			c._name = value
			c._id = getCreatureID(value)
			c._listindex = getCreatureListIndex(c._id)
		elseif (type(value) == 'number') then
			if (value < 1300) then
				value = getCreatureIDFromIndex(value)
			end

			c._id = value
			c._listindex = getCreatureListIndex(c._id)
			c._name = getCreatureName(c._listindex)
		end
	end
	return c
end

setmetatable(Creature, {__call = function(_, ...) return Creature.New(...) end})

--- Please refer to the explanation of Creature.New()
Creature.GetByName = Creature.New

--- Please refer to the explanation of Creature.New()
Creature.GetByID = Creature.New

--- Please refer to the explanation of Creature.New()
Creature.GetFromIndex = Creature.New

--- This function should not be used by the regular user and is therefore not explained
function Creature.iParamHelper(...)
	local params = {...}
	local distance = 10
	local sort = nil
	local checks = {}   
	if (type(params[1]) == "table") then -- we have a table of checks
		function FindFunction(name)
			if (name == "distance" or name == "dist") then
				return Creature.DistanceFromSelf
			end
			for key, value in pairs(Creature) do
				if (string.lower(key) == name) then -- we lower the name before it comes in
					return value
				end
			end
			return nil
		end
		for key, value in pairs(params[1]) do
			local name = string.lower(key)
			if (name == "sort") then
				sort = value
			else
				local func = FindFunction(name)
				local compare = value
				assert(func, "Creature.iParamHelper(): '" .. name .. "' is not a valid Creature property")          
				if (type(value) ~= "table") then
					compare = {}
					compare[1] = eq
					compare[2] = value
				end
				assert(type(compare[1]) == "function", "Creature.iParamHelper(): '" .. tostring(compare[1]) .. "' is not a valid compare function")
				checks[#checks+1] = {func, compare}
			end
		end
	else -- no table of checks
		 distance = params[1] or 10
		 sort = params[2]
	end
	return distance, sort, checks
end

--- This function should not be used by the regular user and is therefore not explained
function Creature.iCheckHelper(checks, creature)
	for _, check in ipairs(checks) do
		if (not check[2][1](check[1](creature), check[2][2])) then
			return false
		end
	end
	return true
end

--- This function should not be used by the regular user and is therefore not explained
function Creature.iCheckConstructor(params, check, value)
	local checks = {[check] = value}
	if (type(params[1]) == "table") then
		for k, v in pairs(params[1]) do
			checks[k] = v
		end
	else
		if (params[1]) then
			checks["distance"] = {lt, params[1]+1}
		end
		checks["sort"] = params[2]
	end
	return checks
end

--- Returns an iterator of spectating creatures.
-- Returns a (name, creature) iterator to the next creature which matches the parameters.
-- @class Creature
-- @param distance the distance the creature must be within to be considered
-- @param sort function by which to sort the iterators
-- @return string name, object Creature
function Creature.iCreatures(...)
	local distance, sort, checks = Creature.iParamHelper(...)
	local spectators = Self.GetSpectators()
	local index = 1
	if (sort) then
		table.sort(spectators, sort)
	end
	return function()
		local cid = spectators[index]
		while (cid) do
			index = index + 1
			if (cid:DistanceFromSelf() <= distance and Creature.iCheckHelper(checks, cid)) then
				return cid:Name(), cid
			end
			cid = spectators[index]
		end
		return nil, nil
	end
end

--- Returns an iterator of spectating players.
-- Returns a (name, creature) iterator to the next player which matches the parameters.
-- @class Creature
-- @param distance the distance the player must be within to be considered
-- @param multifloor look on current floor or all floors
-- @return string name, object Creature
function Creature.iPlayers(...)
	return Creature.iCreatures(Creature.iCheckConstructor({...}, "isplayer", true))
end

--- Returns an iterator of spectating allies.
-- Returns a (name, creature) iterator to the next ally which matches the parameters.
-- @class Creature
-- @param distance the distance the ally must be within to be considered
-- @return string name, object Creature
function Creature.iAllies(...)
	return Creature.iCreatures(Creature.iCheckConstructor({...}, "iswarally", true))
end

--- Returns an iterator of spectating enemies.
-- Returns a (name, creature) iterator to the next enemy which matches the parameters.
-- @class Creature
-- @param distance the distance the enemy must be within to be considered
-- @param sort function by which to sort the iterators
-- @return string name, object Creature
function Creature.iEnemies(...)
	return Creature.iCreatures(Creature.iCheckConstructor({...}, "iswarenemy", true))
end

--- Returns an iterator of spectating party members.
-- Returns a (name, creature) iterator to the next party member which matches the parameters.
-- @class Creature
-- @param distance the distance the party member must be within to be considered
-- @param sort function by which to sort the iterators
-- @return string name, object Creature
function Creature.iPartyMembers(...)
	return Creature.iCreatures(Creature.iCheckConstructor({...}, "ispartymember", true))
end

--- Returns an iterator of spectating monsters.
-- Returns a (name, creature) iterator to the next monster which matches the parameters.
-- @class Creature
-- @param distance the distance the monster must be within to be considered
-- @param sort function by which to sort the iterators
-- @return string name, object Creature
function Creature.iMonsters(...)
	return Creature.iCreatures(Creature.iCheckConstructor({...}, "ismonster", true))
end

--- Returns an iterator of spectating npcs.
-- Returns a (name, creature) iterator to the next npc which matches the parameters.
-- @class Creature
-- @param distance the distance the npc must be within to be considered
-- @param sort function by which to sort the iterators
-- @return string name, object Creature
function Creature.iNpcs(...)
	return Creature.iCreatures(Creature.iCheckConstructor({...}, "isnpc", true))
end

--- Check if creature is valid.
-- Returns true if the creature object is valid/possible
-- @class Creature
-- @return boolean true or false
function Creature:isValid()
	self = type(self) == 'table' and self or Creature.New(self)
	return (self._id > 0 and self._listindex <= CREATURES_HIGH and self._listindex >= CREATURES_LOW)
end

--- Get creature name.
-- Returns the creature object's name
-- @class Creature
-- @return string creature name
function Creature:Name()
	self = type(self) == 'table' and self or Creature.New(self)
	return self._name
end

--- Get creature id.
-- Returns the creature object's creature id
-- @class Creature
-- @return number creature id
function Creature:ID()
	self = type(self) == 'table' and self or Creature.New(self)
	return self._id
end

--- Get creature index.
-- Returns the creature object's creature index
-- @class Creature
-- @return number creature index
function Creature:Index()
	self = type(self) == 'table' and self or Creature.New(self)
	return self._listindex
end

--- Get creature look direction.
-- Returns the creature's look direction, directions defined in constants
-- @class Creature
-- @return number creature look direction
function Creature:LookDirection()
	self = type(self) == 'table' and self or Creature.New(self)
	return getCreatureLookDirection(self._listindex)
end

--- Get creature look position.
-- Returns the position coordinates from the creature object's look direction and range.
-- @class Creature
-- @param range optional; the range around the creature object's position to be considered
-- @return table x, y, z coordinates of the creature object's look direction and range.
function Creature:LookPosition(range)
	self = type(self) == 'table' and self or Creature.New(self)
	return getPositionFromDirection(self:Position(), self:LookDirection(), range or 1)
end

--- Get creature speed.
-- Returns the creature's speed
-- @class Creature
-- @return number creature speed
function Creature:Speed()
	self = type(self) == 'table' and self or Creature.New(self)
	return getCreatureSpeed(self._listindex)
end

--- Get creature outfit.
-- Returns the creature's outfit in a table
-- @class Creature
-- @return table creature looktypes
function Creature:Outfit()
	self = type(self) == 'table' and self or Creature.New(self)
	return getCreatureOutfit(self._listindex)
end

--- Get creature health percent.
-- Returns the creature's health percent
-- @class Creature
-- @return number creature health percent
function Creature:HealthPercent()
	self = type(self) == 'table' and self or Creature.New(self)
	return getCreatureHealthPercent(self._listindex)
end

--- Is creature you.
-- Returns true if you are the creature object
-- @class Creature
-- @return boolean true or false
function Creature:isSelf()
	self = type(self) == 'table' and self or Creature.New(self)
	return self._id == getSelfID()
end

--- Is creature target.
-- Returns true if the creature object is your target
-- @class Creature
-- @return boolean true or false
function Creature:isTarget()
	self = type(self) == 'table' and self or Creature.New(self)
	return self._id == getSelfTargetID()
end

--- Is creature followed.
-- Returns true if the creature object is followed by you
-- @class Creature
-- @return boolean true or false
function Creature:isFollowed()
	self = type(self) == 'table' and self or Creature.New(self)
	return self._id == getSelfFollowID()
end

--- Is creature player.
-- Returns true if the creature object is a player
-- @class Creature
-- @return boolean true or false
function Creature:isPlayer()
	self = type(self) == 'table' and self or Creature.New(self)
	return self:isValid() and isCreaturePlayer(self._listindex) or self:isSelf()
end

--- Is creature NPC.
-- Returns true if the creature object is a NPC
-- @class Creature
-- @return boolean true or false
function Creature:isNpc()
	self = type(self) == 'table' and self or Creature.New(self)
	return self:isValid() and isCreatureNpc(self._listindex)
end

--- Is creature monster.
-- Returns true if the creature object is a monster
-- @class Creature
-- @return boolean true or false
function Creature:isMonster()
	self = type(self) == 'table' and self or Creature.New(self)
	return self:isValid() and isCreatureMonster(self._listindex)
end

--- Is creature summon.
-- Returns true if the creature object is a summon
-- @class Creature
-- @return boolean true or false
function Creature:isSummon()
	self = type(self) == 'table' and self or Creature.New(self)
	return self:isValid() and isCreatureSummon(self._listindex)
end

--- Is creature self summon.
-- Returns true if the creature object is a self summon
-- @class Creature
-- @return boolean true or false
function Creature:isSelfSummon()
	self = type(self) == 'table' and self or Creature.New(self)
	return self:isValid() and isCreatureSelfSummon(self._listindex)
end

--- Is creature strange summon.
-- Returns true if the creature object is a strange summon
-- @class Creature
-- @return boolean true or false
function Creature:isStrangeSummon()
	self = type(self) == 'table' and self or Creature.New(self)
	return self:isValid() and isCreatureStrangeSummon(self._listindex)
end

--- Is creature mother.
-- Returns true if the creature object is a mother
-- @class Creature
-- @return boolean true or false
function Creature:isMother()
	self = type(self) == 'table' and self or Creature.New(self)
	return self:isValid() and isCreatureMother(self._listindex)
end

--- Is creature friendly.
-- Returns true if the creature object is a friendly
-- @class Creature
-- @return boolean true or false
function Creature:isFriendly()
	self = type(self) == 'table' and self or Creature.New(self)
	return self:isWarAlly() or self:isPartyMember() or self:isSelf()
end

--- Is creature innocent.
-- Returns true if the creature object is innocent
-- @class Creature
-- @return boolean true or false
function Creature:isInnocent()
	self = type(self) == 'table' and self or Creature.New(self)
	return (self:Skull() == SKULL_YELLOW or self:Skull() == SKULL_NONE) and not self:isWarEnemy()
end

--- Get creature skull.
-- Returns the creature's skull type
-- @class Creature
-- @return number containing creature's skull type
function Creature:Skull()
	self = type(self) == 'table' and self or Creature.New(self)
	return getCreatureSkull(self._listindex)
end

--- Is creature white skulled.
-- Returns true if the creature object is white skulled
-- @class Creature
-- @return boolean true or false
function Creature:isWhiteSkull()
	self = type(self) == 'table' and self or Creature.New(self)
	return self:Skull() == SKULL_WHITE
end

--- Is creature red skulled.
-- Returns true if the creature object is red skulled
-- @class Creature
-- @return boolean true or false
function Creature:isRedSkull()
	self = type(self) == 'table' and self or Creature.New(self)
	return self:Skull() == SKULL_RED
end

--- Is creature orange skulled.
-- Returns true if the creature object is orange skulled
-- @class Creature
-- @return boolean true or false
function Creature:isOrangeSkull()
	self = type(self) == 'table' and self or Creature.New(self)
	return self:Skull() == SKULL_ORANGE
end

--- Is creature yellow skulled.
-- Returns true if the creature object is yellow skulled
-- @class Creature
-- @return boolean true or false
function Creature:isYellowSkull()
	self = type(self) == 'table' and self or Creature.New(self)
	return self:Skull() == SKULL_YELLOW
end

--- Is creature black skulled.
-- Returns true if the creature object is black skulled
-- @class Creature
-- @return boolean true or false
function Creature:isBlackSkull()
	self = type(self) == 'table' and self or Creature.New(self)
	return self:Skull() == SKULL_BLACK
end

--- Get creature shield.
-- Returns the creature's party shield type
-- @class Creature
-- @return number creature shield type
function Creature:PartyStatus()
	self = type(self) == 'table' and self or Creature.New(self)
	return getCreaturePartyStatus(self._listindex)
end

--- Is creature party leader.
-- Returns true if the creature object is the party leader
-- @class Creature
-- @return boolean true or false
function Creature:isPartyLeader()
	self = type(self) == 'table' and self or Creature.New(self)
	return (self:PartyStatus() == PARTY_YELLOW or self:PartyStatus() == PARTY_YELLOW_SHAREDEXP or self:PartyStatus() == PARTY_YELLOW_NOSHAREDEXP_BLINK or self:PartyStatus() == PARTY_YELLOW_NOSHAREDEXP)
end

--- Is creature party member.
-- Returns true if the creature object is a party member
-- @class Creature
-- @return boolean true or false
function Creature:isPartyMember()
	self = type(self) == 'table' and self or Creature.New(self)
	return (self:isPartyLeader() or self:PartyStatus() == PARTY_BLUE or self:PartyStatus() == PARTY_BLUE_SHAREDEXP or self:PartyStatus() == PARTY_BLUE_NOSHAREDEXP_BLINK or self:PartyStatus() == PARTY_BLUE_NOSHAREDEXP)
end

--- Is creature invited to party.
-- Returns true if the creature object is invited to the party
-- @class Creature
-- @return boolean true or false
function Creature:isInvitedToParty()
	self = type(self) == 'table' and self or Creature.New(self)
	return self:PartyStatus() == PARTY_WHITEBLUE
end

--- Is creature inviting to party.
-- Returns true if the creature object is inviting to the party
-- @class Creature
-- @return boolean true or false
function Creature:isInvitingToParty()
	self = type(self) == 'table' and self or Creature.New(self)
	return self:PartyStatus() == PARTY_WHITEYELLOW
end

--- Is creature sharing exp.
-- Returns true if the creature object is sharing exp in the party
-- @class Creature
-- @return boolean true or false
function Creature:isSharingExp()
	self = type(self) == 'table' and self or Creature.New(self)
	return (self:PartyStatus() == PARTY_BLUE_SHAREDEXP or self:PartyStatus() == PARTY_YELLOW_SHAREDEXP)
end

--- Get creature pvp icon.
-- Returns the creature's war icon type
-- @class Creature
-- @return number creature war icon type
function Creature:WarIcon()
	self = type(self) == 'table' and self or Creature.New(self)
	return getCreaturePvPIcon(self._listindex)
end

--- Get creature pvp icon.
-- Returns the creature's war icon type
-- @class Creature
-- @return number creature war icon type
function Creature:PvPIcon()
	self = type(self) == 'table' and self or Creature.New(self)
	return getCreaturePvPIcon(self._listindex)
end

--- Is creature war enemy.
-- Returns true if the creature object is a war enemy
-- @class Creature
-- @return boolean true or false
function Creature:isWarEnemy()
	self = type(self) == 'table' and self or Creature.New(self)
	return self:PvPIcon() == PVP_ENEMY
end

--- Is creature war ally.
-- Returns true if the creature object is a war ally
-- @class Creature
-- @return boolean true or false
function Creature:isWarAlly()
	self = type(self) == 'table' and self or Creature.New(self)
	return self:PvPIcon() == PVP_ALLY
end

--- Is creature in war.
-- Returns true if the creature object is in a war
-- @class Creature
-- @return boolean true or false
function Creature:isInWar()
	self = type(self) == 'table' and self or Creature.New(self)
	return (self:PvPIcon() == PVP_INWAR or self:isWarAlly() or self:isWarEnemy())
end

--- Is creature in your guild.
-- Returns true if the creature object is in your guild
-- @class Creature
-- @return boolean true or false
function Creature:isGuildmate()
	self = type(self) == 'table' and self or Creature.New(self)
	return (self:PvPIcon() == PVP_GUILDMATE)
end

--- Is creature in a guild.
-- Returns true if the creature object is in a guild
-- @class Creature
-- @return boolean true or false
function Creature:isInAGuild()
	self = type(self) == 'table' and self or Creature.New(self)
	return (self:PvPIcon() == PVP_HASGUILD)
end

--- Get creature position.
-- Returns the creature's position in x,y,z
-- @class Creature
-- @return table x,y,z coordinates of creature
function Creature:Position()
	self = type(self) == 'table' and self or Creature.New(self)
	return getCreaturePosition(self._listindex)
end

--- Is creature reachable.
-- Returns true if the creature is reachable
-- @class Creature
-- @return string Not implemented
function Creature:isReachable()
	return "Not implemented"-- isPathFound(self:Position())
end

--- Is creature adjacent.
-- Returns true if the creature is right next to you
-- @class Creature
-- @return boolean true or false
function Creature:isAdjacent()
	self = type(self) == 'table' and self or Creature.New(self)
	return isPositionAdjacent(self:Position(), getSelfPosition())
end

--- Is creature on screen.
-- Returns true if the creature position is on your screen
-- @class Creature
-- @param multiFloor optional; skip same floor check if true
-- @return boolean true or false
function Creature:isOnScreen(multiFloor)
	self = type(self) == 'table' and self or Creature.New(self)
	local selfloc = getSelfPosition()
	local thisloc = self:Position()
	return (math.abs(selfloc.x - thisloc.x) <= 7 and math.abs(selfloc.y - thisloc.y) <= 5 and (selfloc.z == thisloc.z or multiFloor))
end

--- Is creature alive.
-- Returns true if the creature is alive
-- @class Creature
-- @return boolean true or false
function Creature:isAlive()
	self = type(self) == 'table' and self or Creature.New(self)
	return getCreatureHealthPercent(self._listindex) > 0
end

--- Is creature visible.
-- Returns true if the creature is visible
-- @class Creature
-- @return boolean true or false
function Creature:isVisible()
	self = type(self) == 'table' and self or Creature.New(self)
	return getCreatureVisible(self._listindex)
end

--- Get creature distance.
-- Returns the creature's sqms from you
-- @class Creature
-- @return number sqms from your distance
function Creature:DistanceFromSelf()
	self = type(self) == 'table' and self or Creature.New(self)
	return getDistanceBetween(self:Position(), getSelfPosition())
end

--- Get creature distance from position.
-- Returns the creature's sqms from position
-- @class Creature
-- @param x coordinate in the map on the x-axis
-- @param y coordinate in the map on the y-axis
-- @param z coordinate in the map on the z-axis
-- @return number sqms from position
function Creature:DistanceFromPosition(x, y, z)
	self = type(self) == 'table' and self or Creature.New(self)
	return getDistanceBetween(self:Position(), {x = x, y = y, z = z})
end

--- Is creature located.
-- Returns true if the creature object is located at position or in specified range
-- @class Creature
-- @param x coordinate in the map on the x-axis
-- @param y coordinate in the map on the y-axis
-- @param z coordinate in the map on the z-axis
-- @param range optional; the range around pos to be considered
-- @return boolean true or false
function Creature:isLocation(x, y, z, range)
	range = range or 0
	self = type(self) == 'table' and self or Creature.New(self)
	return getDistanceBetween(self:Position(), {x = x, y = y, z = z}) <= range
end

--- Attack creature.
-- Sets the creature as the target
-- @class Creature
-- @return boolean true or false
function Creature:Attack()
	self = type(self) == 'table' and self or Creature.New(self)
	local ret = attackCreature(self._id)
	if (ret == 1) then
		wait(500)
	end --we need to sleep, we CANT be spamming attack. DO NOT EVER DO IT.
	return ret
end

--- Follow creature.
-- Sets the creature to be followed
-- @class Creature
-- @return boolean true or false
function Creature:Follow()
	self = type(self) == 'table' and self or Creature.New(self)
	local ret = followCreature(self._id)
	if (ret == 1) then
		wait(500)
	end --we need to sleep, we CANT be spamming follow. DO NOT EVER DO IT.
	return ret
end

--
--       .d8888b.                    888             d8b                                .d8888b.  888                            
--      d88P  Y88b                   888             Y8P                               d88P  Y88b 888                            
--      888    888                   888                                               888    888 888                            
--      888         .d88b.  88888b.  888888  8888b.  888 88888b.   .d88b.  888d888     888        888  8888b.  .d8888b  .d8888b  
--      888        d88""88b 888 "88b 888        "88b 888 888 "88b d8P  Y8b 888P"       888        888     "88b 88K      88K      
--      888    888 888  888 888  888 888    .d888888 888 888  888 88888888 888         888    888 888 .d888888 "Y8888b. "Y8888b. 
--      Y88b  d88P Y88..88P 888  888 Y88b.  888  888 888 888  888 Y8b.     888         Y88b  d88P 888 888  888      X88      X88 
--       "Y8888P"   "Y88P"  888  888  "Y888 "Y888888 888 888  888  "Y8888  888          "Y8888P"  888 "Y888888  88888P'  88888P' 
--

Container = {}
Container.__index = Container

--- Creates a container object from value.
-- Creates and returns a container object using it's a name, itemid, or index
-- @class Container
-- @param value the containers's name, itemid, or index
-- @return object Container
function Container.New(value)
	local c, isString = {}, type(value) == 'string'
	if (value == nil) then
		c._index = -1
	else
		setmetatable(c, Container)
		if (isString or value > 99) then
			local index = -1
			while (index < 16) do
				index = index + 1
				if (getContainerOpen(index)) then
					local name = isString and value or getItemNameByID(value)
					if (getContainerName(index) == name:titlecase()) then
						break
					end
				end
			end
			value = index
		end
		c._index = getContainerOpen(value) and value or -1
	end
	return c
end

setmetatable(Container, {__call = function(_, ...) return Container.New(...) end})

--- Get free container slot.
-- Returns the first free container slot found
-- @class Container
-- @return number the first free slot found
function Container.GetFreeSlot()
	local index = -1
	while (index < 16) do
		index = index + 1
		if (not getContainerOpen(index)) then
			return index
		end
	end
	return -1
end

--- Returns an iterator of a container.
-- Returns a (spot, container) iterator to the next item in the container.
-- @class Container
-- @return integer spot, table itemData
function Container.iContainers()
	local index = 0
	return function()
		local cont = Container.New(index)
		while (index < 16) do
			index = index + 1
			if (cont:isOpen()) then
				 return index-1, cont
			end
			cont = Container.New(index)
		end
		return nil, nil
	end
end

--- Creates a container object from first container.
-- Creates a container object from the first open container
-- @class Container
-- @return object Container
function Container.GetFirst()
   return Container.GetNextOpen(-1)
end

--- Creates a container object from last container.
-- Creates a container object from the last open container
-- @class Container
-- @return object Container
function Container.GetLast()
	local index = -1
	local last = Container.New(-1)
	while (index < 16) do
		index = index + 1
		if (getContainerOpen(index)) then
			last = Container.New(index)
		end
	end
	return last
end

--- Get open containers.
-- Returns the open container indexes in a table
-- @class Container
-- @return table container indexes
function Container.GetAll()
	local index = -1
	local indexes = {}
	while (index < 16) do
		index = index + 1
		if (getContainerOpen(index)) then
			table.insert(indexes, index)
		end
	end
	return indexes
end

--- Creates a container object from the next container.
-- Creates a container object from the next open container based on an index
-- @class Container
-- @param index the index to base 'next' container on
-- @return object Container
function Container.GetNextOpen(index)
	local found = false
	while (not found and index < 16) do
		index = index + 1
		found = getContainerOpen(index)
	end
	if (not found) then
		index = -1
	end
	return Container.New(index)
end

--- Creates a container object from the next relative container.
-- Creates a container object from the next open container relative to the current container object
-- @class Container
-- @return object Container
function Container:GetNext()
	self = type(self) == 'table' and self or Container.New(self)
	return Container.GetNextOpen(self._index)
end

--- Get container's index.
-- Returns the container's index number
-- @class Container
-- @return number container index
function Container:Index()
	self = type(self) == 'table' and self or Container.New(self)
	return self._index
end

--- Get container's id.
-- Returns the container's itemid
-- @class Container
-- @return number container itemid
function Container:ID()
	self = type(self) == 'table' and self or Container.New(self)
	return getContainerID(self._index)
end

--- Get container's name.
-- Returns the container's name
-- @class Container
-- @return string container name
function Container:Name()
	self = type(self) == 'table' and self or Container.New(self)
	return getContainerName(self._index)
end

--- Get container's item count.
-- Returns the amount of occupied slots in the container
-- @class Container
-- @return number taken slots
function Container:ItemCount()
	self = type(self) == 'table' and self or Container.New(self)
	return getContainerItemCount(self._index)
end

--- Get container's item capacity.
-- Returns the total amount of slots the container has
-- @class Container
-- @return number total slots
function Container:ItemCapacity()
	self = type(self) == 'table' and self or Container.New(self)
	return getContainerItemCapacity(self._index)
end

--- Is container open.
-- Returns true if the container is open, false if not
-- @class Container
-- @return boolean true or false
function Container:isOpen()
	self = type(self) == 'table' and self or Container.New(self)
	return getContainerOpen(self._index)
end

--- Is container empty.
-- Returns true if the container is empty, false if not
-- @class Container
-- @return boolean true or false
function Container:isEmpty()
	self = type(self) == 'table' and self or Container.New(self)
	return getContainerItemCount(self._index) == 0
end

--- Is container full.
-- Returns true if the container is full, false if not
-- @class Container
-- @return boolean true or false
function Container:isFull()
	self = type(self) == 'table' and self or Container.New(self)
	return getContainerItemCount(self._index) == getContainerItemCapacity(self._index)
end

--- Get container's item capacity.
-- Returns the amount of vacant slots in the container
-- @class Container
-- @return number vacant slots
function Container:EmptySlots()
	self = type(self) == 'table' and self or Container.New(self)
	return getContainerItemCapacity(self._index) - getContainerItemCount(self._index)
end

--- Closes container.
-- Closes the container
-- @class Container
-- @return boolean true or false
function Container:Close()
	self = type(self) == 'table' and self or Container.New(self)
	return closeContainer(self._index)
end

--- Minimizes container.
-- Minimizes the container
-- @class Container
-- @return boolean true or false
function Container:Minimize()
	self = type(self) == 'table' and self or Container.New(self)
	return minimizeContainer(self._index)
end

--- Opens items in the container.
-- Opens items based on their itemids in the container
-- @class Container
-- @param ... itemids to open in the container
-- @return void returns nothing
function Container:OpenChildren(...)
	self = type(self) == 'table' and self or Container.New(self)
	local items = {}
	for i, id in ipairs({...}) do
		if (type(id) == 'table') then
			items[i] = {Item.GetItemIDFromDualInput(id[1]), id[2], id[3]}
		else
			items[i] = {Item.GetItemIDFromDualInput(id), false, false}
		end
	end
	for _, id in ipairs(items) do
		for i = 0, self:ItemCount()-1 do
			local item = self:GetItemData(i)
			if (item.id == id[1]) then
				local opento = Container.GetFreeSlot()
				while (self:UseItem(i, id[3]) ~= 1) do
					wait(300)
				end
				if (id[2] == true) then
					wait(500)
					Container.Minimize(opento)
				end
				break
			end
		end
		wait(800)
	end
end

--- Get specific itemid count in container.
-- Returns the amount of a specific itemid in the container
-- @class Container
-- @param id the itemid to count
-- @return number the amount of supplied itemid
function Container:CountItemsOfID(id)
	self = type(self) == 'table' and self or Container.New(self)
	local count = 0
	for spot = 0, self:ItemCount()-1 do
		local item = self:GetItemData(spot)
		if (item.id == id) then
			count = count + math.max(item.count, 1)
		end
	end
	return count
end

--- Get specific free stackable slot count of itemid in container.
-- Returns the amount of free stackable slots of itemid in the container
-- @class Container
-- @param id the itemid to count
-- @return number the amount of free stackable slots of itemid
function Container:CountStackableSlotsOfID(id)
	self = type(self) == 'table' and self or Container.New(self)
	local slotCount = 0
	if (Item.isStackable(id)) then
		local c = Container.New(self._index)
		for spot = 0, c:ItemCount()-1 do
			if (c:GetItemData(spot).id == id and c:GetItemData(spot).count < 100) then
				slotCount = slotCount + (100 - c:GetItemData(spot).count)
			end
		end
	end
	return slotCount
end

--- Get item data from spot in the container.
-- Returns the item data from the specified slot in the container
-- @class Container
-- @param spot the specific slot to query
-- @return table containing item data
function Container:GetItemData(spot)
	self = type(self) == 'table' and self or Container.New(self)
	return getContainerSpotData(self._index, spot)
end

--- Returns an iterator of items in the container.
-- Returns a (spot, container) iterator to the next item in the container.
-- @class Container
-- @return integer spot, table itemData
function Container:iItems()
	self = type(self) == 'table' and self or Container.New(self)
	local index = -1
	local me = self
	return function()
		index = index + 1
		if (index >= me:ItemCount()) then
			return nil, nil
		else
			return index, me:GetItemData(index)
		end
	end
end

--- Uses item in the container.
-- Uses an item in a specific spot in the container
-- @class Container
-- @param spot the specific slot to use
-- @param openInSameWindow optional; if true, open the item in the same window
-- @return boolean true or false
function Container:UseItem(spot, openInSameWindow)
	self = type(self) == 'table' and self or Container.New(self)
	return containerUseItem(self._index, spot, openInSameWindow or false)
end

--- Uses item in the container on another item in a container.
-- Uses an item in a specific spot in the container on a specific spot in a specific container.
-- @class Container
-- @param spotfrom the specific slot the item to be used is at
-- @param contto the container index you want to use the item in
-- @param spotto the specific slot you want to use the item with in the new container
-- @return boolean true or false
function Container:UseItemWithContainerItem(spotfrom, contto, spotto)
	self = type(self) == 'table' and self or Container.New(self)
	return containerUseWithContainer(self._index, spotfrom, contto, spotto)
end

--- Uses item in the container with the ground.
-- Uses an item in a specific spot in the container on a specific position
-- @class Container
-- @param spot the specific slot to use
-- @param x coordinate in the map on the x-axis
-- @param y coordinate in the map on the y-axis
-- @param z coordinate in the map on the z-axis
-- @return boolean true or false
function Container:UseItemWithGround(spot, x, y, z)
	self = type(self) == 'table' and self or Container.New(self)
	return containerUseItemWithGround(self._index, spot, x, y, z)
end

--- Uses item in the container with a creature.
-- Uses an item in a specific spot in the container on a specific creature
-- @class Container
-- @param spot the specific slot to use
-- @param id the creature id to use the item with
-- @return boolean true or false
function Container:UseItemWithCreature(spot, id)
	self = type(self) == 'table' and self or Container.New(self)
	return containerUseItemWithCreature(self._index, spot, id)
end

--- Moves an item in the container to equipment.
-- Moves an item in the container to a specific equipment slot
-- @class Container
-- @param spot the specific slot to use
-- @param slot the equipment slot to move to
-- @param count optional; amount of item stack to move (default is entire stack)
-- @return boolean true or false
function Container:MoveItemToEquipment(spot, slot, count)
	self = type(self) == 'table' and self or Container.New(self)
	return containerMoveItemToSlot(self._index, spot, slot, count or -1)
end

--- Moves an item in the container to the ground.
-- Moves an item in the container to a specific position
-- @class Container
-- @param spot the specific slot to use
-- @param x coordinate in the map on the x-axis
-- @param y coordinate in the map on the y-axis
-- @param z coordinate in the map on the z-axis
-- @param count optional; amount of item stack to move (default is entire stack)
-- @return boolean true or false
function Container:MoveItemToGround(spot, x, y, z, count)
	self = type(self) == 'table' and self or Container.New(self)
	return containerMoveItemToGround(self._index, spot, x, y, z, count or -1)
end

--- Moves an item in the container to another container.
-- Moves an item in the container to a different open container
-- @class Container
-- @param spotfrom the specific slot the item is initially in
-- @param containerto the container index you want to move the item to
-- @param spotto the specific slot you want to move the item to in the new container
-- @param count optional; amount of item stack to move (default is entire stack)
-- @return boolean true or false
function Container:MoveItemToContainer(spotfrom, containerto, spotto, count)
	self = type(self) == 'table' and self or Container.New(self)
	return containerMoveItemToContainer(self._index, spotfrom, containerto, spotto, count or -1)
end

--- Go back in container.
-- Goes "back" to the containers parent
-- @class Container
-- @return boolean true or false
function Container:GoBack()
	self = type(self) == 'table' and self or Container.New(self)
	return containerBack(self._index)
end

--
--      8888888 888                                .d8888b.  888                            
--        888   888                               d88P  Y88b 888                            
--        888   888                               888    888 888                            
--        888   888888  .d88b.  88888b.d88b.      888        888  8888b.  .d8888b  .d8888b  
--        888   888    d8P  Y8b 888 "888 "88b     888        888     "88b 88K      88K      
--        888   888    88888888 888  888  888     888    888 888 .d888888 "Y8888b. "Y8888b. 
--        888   Y88b.  Y8b.     888  888  888     Y88b  d88P 888 888  888      X88      X88 
--      8888888  "Y888  "Y8888  888  888  888      "Y8888P"  888 "Y888888  88888P'  88888P' 
--

Item = {}

--- Get item name from id.
-- Returns the item's name by providing it's itemid
-- @class Item
-- @param id the itemid
-- @return string the item's name
Item.GetName = getItemNameByID

--- Item has name.
-- Returns whether an itemname was found for the specific itemid or not
-- @class Item
-- @param id the specific itemid to check
-- @return boolean true or false
function Item.hasName(id)
	return (Item.GetName(id) ~= "<invalid>" and Item.GetName(id) ~= "unknown")
end

--- Get itemid from name.
-- Returns the itemid by providing it's name
-- @class Item
-- @param name the item's name
-- @return number the itemid
Item.GetID = getItemIDByName

--- Item has id.
-- Returns whether an itemid was found for the specific itemname or not
-- @class Item
-- @param name the specific itemname to check
-- @return boolean true or false
function Item.hasID(name)
	return Item.GetID(name) ~= 0
end

--- Is item container.
-- Returns true if the item is a container, false if not
-- @class Item
-- @return boolean true or false
Item.isContainer = isItemContainer

--- Is item corpse.
-- Returns true if the item is a corpse, false if not
-- @class Item
-- @return boolean true or false
Item.isCorpse = isItemCorpse

--- Is item stackable.
-- Returns true if the item is stackable, false if not
-- @class Item
-- @return boolean true or false
Item.isStackable = isItemStackable

--- Is item use withable.
-- Returns true if the item is able to be used with another object
-- @class Item
-- @return boolean true or false
Item.isUseWithable = isItemUseWithable

--- Is item food.
-- Returns true if the item is edible, false if not
-- @class Item
-- @return boolean true or false
Item.isFood = isItemFood

--- Is item walkable.
-- Returns true if the item is walkable, false if not
-- @class Item
-- @return boolean true or false
Item.isWalkable = isItemWalkable

--- Is item furniture.
-- Returns true if the item is furniture, false if not
-- @class Item
-- @return boolean true or false
Item.isFurniture = isItemFurniture

--- Is item field.
-- Returns true if the item is a field, false if not
-- @class Item
-- @return boolean true or false
Item.isField = isItemField

--- Get item weight.
-- Returns the weight of itemid
-- @class Item
-- @param id the specific itemid to get the weight of
-- @return number the weight of itemid
Item.GetWeight = getItemWeight

--- Item has weight.
-- Returns whether a specific item has a weight or not
-- @class Item
-- @param item the specific itemid or itemname to check
-- @return boolean true or false
function Item.hasWeight(item)
	item = Item.GetItemIDFromDualInput(item)
	return Item.GetWeight(item) ~= 0
end

--- Get item value.
-- Returns the value of itemid
-- @class Item
-- @param id the specific itemid to get the value of
-- @return number the value of itemid
Item.GetValue = getItemValue

--- Item has value.
-- Returns whether a specific item has a value or not
-- @class Item
-- @param item the specific itemid or itemname to check
-- @return boolean true or false
function Item.hasValue(item)
	item = Item.GetItemIDFromDualInput(item)
	return Item.GetValue(item) ~= 0
end

--- Get item cost.
-- Returns the cost of itemid
-- @class Item
-- @param id the specific itemid to get the cost of
-- @return number the cost of itemid
Item.GetCost = getItemCost

--- Item has cost.
-- Returns whether a specific item has a cost or not
-- @class Item
-- @param item the specific itemid or itemname to check
-- @return boolean true or false
function Item.hasCost(item)
	item = Item.GetItemIDFromDualInput(item)
	return Item.GetCost(item) ~= 0
end

--- Get active id of ring.
-- Returns the corresponding active id of the unequipped ring item
-- @class Item
-- @param itemid the itemid of an unequipped ring
-- @return number the active itemid
function Item.GetRingActiveID(itemid)
	local rings = {
		[349] = 349,
		[3004] = 3004,
		[3006] = 3006,
		[3007] = 3007,
		[3048] = 3048,
		[3049] = 3086,
		[3050] = 3087,
		[3051] = 3088,
		[3052] = 3089,
		[3053] = 3090,
		[3091] = 3094,
		[3092] = 3095,
		[3093] = 3096,
		[3097] = 3099,
		[3098] = 3100,
		[3245] = 3245,
		[6299] = 6300,
		[9393] = 9392,
		[9585] = 9585,
		[9593] = 9593,
		[16114] = 16264,
	}
	return rings[itemid] or 0
end

--- Get itemid from dual input.
-- Returns the itemid by providing it's name or id
-- @class Item
-- @param input the item's id or name
-- @return number the itemid
function Item.GetItemIDFromDualInput(input)
	return (type(input) == "string" and Item.GetID(input)) or input
end

--- Get itemname from dual input.
-- Returns the itemname by providing it's id or name
-- @class Item
-- @param input the item's name or id
-- @return string the itemname
function Item.GetItemNameFromDualInput(input)
	return (type(input) == "number" and Item.GetName(input)) or input
end

--- Make dual input table into id table.
-- Returns a table with itemid of the selected input type
-- @class Item
-- @param input the item's name or id
-- @return table the ids of input
function Item.MakeDualInputTableIntoIDTable(input)
	local t = {}
	for i = 1, #input do
		t[i] = Item.GetItemIDFromDualInput(input[i])
	end
	return t
end

--
--      888b     d888                        .d8888b.  888                            
--      8888b   d8888                       d88P  Y88b 888                            
--      88888b.d88888                       888    888 888                            
--      888Y88888P888  8888b.  88888b.      888        888  8888b.  .d8888b  .d8888b  
--      888 Y888P 888     "88b 888 "88b     888        888     "88b 88K      88K      
--      888  Y8P  888 .d888888 888  888     888    888 888 .d888888 "Y8888b. "Y8888b. 
--      888   "   888 888  888 888 d88P     Y88b  d88P 888 888  888      X88      X88 
--      888       888 "Y888888 88888P"       "Y8888P"  888 "Y888888  88888P'  88888P' 
--                             888                                                    
--                             888                                                    
--                             888
--

Map = {}

--- Get item data of the top moveable item.
-- Returns the item data of the top moveable item located at a specific position
-- @class Map
-- @param x coordinate in the map on the x-axis
-- @param y coordinate in the map on the y-axis
-- @param z coordinate in the map on the z-axis
-- @return table containing item data
Map.GetTopMoveItem = getTileMoveID

--- Get item data of the top useable item.
-- Returns the item data of the top useable item located at a specific position
-- @class Map
-- @param x coordinate in the map on the x-axis
-- @param y coordinate in the map on the y-axis
-- @param z coordinate in the map on the z-axis
-- @return table containing item data
Map.GetTopUseItem = getTileUseID

--- Get item data of the top item use with target.
-- Returns the item data of the top target object located at a specific position
-- @class Map
-- @param x coordinate in the map on the x-axis
-- @param y coordinate in the map on the y-axis
-- @param z coordinate in the map on the z-axis
-- @return table containing item data
Map.GetTopTargetObject = getTileUseTargetID

--- Is tile walkable.
-- Returns true if the tile at the certain position is walkable, false if not
-- @class Map
-- @param x coordinate in the map on the x-axis
-- @param y coordinate in the map on the y-axis
-- @param z coordinate in the map on the z-axis
-- @return boolean true or false
Map.IsTileWalkable = getTileIsWalkable

--- Is tile on screen.
-- Returns true if the tile at the certain position is on screen, false if not
-- @class Map
-- @param x coordinate in the map on the x-axis
-- @param y coordinate in the map on the y-axis
-- @param z coordinate in the map on the z-axis
-- @return boolean true or false
function Map.IsTileOnScreen(x, y, z)
	return (math.abs(Self.Position().x - x) <= 7 and math.abs(Self.Position().y - y) <= 5)
end

--- Pickup item from map.
-- Picks up an item from a specific position of the map to a certain container
-- @class Map
-- @param x coordinate in the map on the x-axis
-- @param y coordinate in the map on the y-axis
-- @param z coordinate in the map on the z-axis
-- @param containerto the container index you want to move the item to
-- @param spotto the specific slot you want to move the item to in the container
-- @param count optional; amount of item stack to move (default is entire stack)
-- @return 1 for success or 0 for failure
Map.PickupItem = mapPickupItem

--- Move item on map.
-- Moves an item from a specific position of the map to another position
-- @class Map
-- @param xfrom source coordinate in the map on the x-axis
-- @param yfrom source coordinate in the map on the y-axis
-- @param xto destination coordinate in the map on the x-axis
-- @param yto destination coordinate in the map on the y-axis
-- @param count optional; amount of item stack to move (default is entire stack)
-- @return 1 for success or 0 for failure
Map.MoveItem = mapMoveItem

--- Is item at position.
-- Returns true if the specific item is at the certain position, false if not
-- @class Map
-- @param item the item's name or id
-- @param x coordinate in the map on the x-axis
-- @param y coordinate in the map on the y-axis
-- @param z coordinate in the map on the z-axis
-- @return boolean true or false
function Map.IsItemAtPosition(item, x, y, z)
	item = Item.GetItemIDFromDualInput(item)
	if (Map.GetTopMoveItem(x, y, z).id == item or Map.GetTopUseItem(x, y, z).id == item or Map.GetTopTargetObject(x, y, z).id == item) then
		return true
	end
	return false
end

--- Is item on screen.
-- Returns true if the specific item is on screen, false if not
-- @class Map
-- @param item the item's name or id
-- @return boolean true or false
function Map.IsItemOnScreen(item)
	item = Item.GetItemIDFromDualInput(item)
	for x = -7, 7, 1 do
		for y = -5, 5, 1 do
			if (Map.IsItemAtPosition(item, Self.Position().x + x, Self.Position().y + y, Self.Position().z)) then
				return true
			end
		end
	end
	return false
end

--- Get item positions.
-- Returns a table of the coordinates the specific item could be found at
-- @class Map
-- @param item the item's name or id
-- @return table coordinates of all occurrences of the specific item
function Map.GetItemPositions(item)
	local positions = {}
	item = Item.GetItemIDFromDualInput(item)
	for x = -7, 7, 1 do
		for y = -5, 5, 1 do
			if (Map.IsItemAtPosition(item, Self.Position().x + x, Self.Position().y + y, Self.Position().z)) then
				positions[#positions+1] = {x = Self.Position().x + x, y = Self.Position().y + y, z = Self.Position().z}
			end
		end
	end
	return positions
end

--- Get walkable tiles.
-- Returns a table of walkable tiles around a given position
-- @class Map
-- @param center the initial position table
-- @param range the radius around the specific position to be checked
-- @return table the coordinates of all walkable tiles
Map.GetWalkableTiles = function(center, range)
	local walkables = {}
	local base = center
	range = (range > 10) and 10 or range
	veryUnsafeFunctionEnterCriticalMode()
	for x = -range, range do
		for y = -range, range do
			if (Map.IsTileWalkable(base.x + x, base.y + y, base.z)) then
				table.insert(walkables, {x = base.x + x, y = base.y + y, z = base.z})
			end
		end
	end
	veryUnsafeFunctionExitCriticalMode()
	return walkables
end

--- Get direction to.
-- Returns the direction of a specific position two to specific position one
-- @class Map
-- @param pos1 the initial position table
-- @param pos2 the destination position table
-- @return number the direction of pos2 to pos1
Map.GetDirectionTo = function(pos1, pos2)
	local dir = NORTH
	if (pos1.x > pos2.x) then
		dir = WEST
		if (pos1.y > pos2.y) then
			dir = NORTHWEST
		elseif (pos1.y < pos2.y) then
			dir = SOUTHWEST
		end
	elseif (pos1.x < pos2.x) then
		dir = EAST
		if (pos1.y > pos2.y) then
			dir = NORTHEAST
		elseif (pos1.y < pos2.y) then
			dir = SOUTHEAST
		end
	else
		if (pos1.y > pos2.y) then
			dir = NORTH
		elseif (pos1.y < pos2.y) then
			dir = SOUTH
		end
	end
	return dir
end

--
--       .d8888b.           888  .d888      .d8888b.  888                            
--      d88P  Y88b          888 d88P"      d88P  Y88b 888                            
--      Y88b.               888 888        888    888 888                            
--       "Y888b.    .d88b.  888 888888     888        888  8888b.  .d8888b  .d8888b  
--          "Y88b. d8P  Y8b 888 888        888        888     "88b 88K      88K      
--            "888 88888888 888 888        888    888 888 .d888888 "Y8888b. "Y8888b. 
--      Y88b  d88P Y8b.     888 888        Y88b  d88P 888 888  888      X88      X88 
--       "Y8888P"   "Y8888  888 888         "Y8888P"  888 "Y888888  88888P'  88888P'
--

Self = {}

--- Self Speak.
-- Sends a message to the chosen channel
-- @class Self
-- @param msg the message/s you want to send
-- @param talkType the type of the message you want to send (available types: SPEAK_SAY, SPEAK_YELL, SPEAK_WHISPER, SPEAK_NPC)
-- @param wpm optional; the words per minute you want to send
-- @param range optional; the randomization for the words per minute value
-- @return void returns nothing
function Self.Speak(msg, talkType, wpm, range)
	local func = selfSay    
	if (talkType == SPEAK_YELL or talkType == "yell") then
		func = selfYell
	elseif (talkType == SPEAK_WHISPER or talkType == "whisper") then
		func = selfWhisper
	elseif (talkType == SPEAK_NPC or talkType == "npc") then
		func = selfNpcSay
	end
	wpm = wpm or 0
	range = range or 7
	local rangeFrom, rangeTo = math.max(wpm - range, 0), math.max(wpm + range, 0)
	if (type(msg) == 'table') then
		for i = 1, #msg do
			if (wpm > 0) then
				wait(((msg[i]:len() / 5) * (math.random(rangeFrom, rangeTo) / 60)) * 1000)
			end
			func(msg[i])
		end
	else
		if (wpm > 0) then
			wait(((msg:len() / 5) * (math.random(rangeFrom, rangeTo) / 60)) * 1000)
		end
		return func(msg)
	end
end

--- Self say.
-- Sends a message to the local chat
-- @class Self
-- @param msg the message/s you want to send
-- @param wpm optional; the words per minute you want to send
-- @param range optional; the randomization for the words per minute value
-- @return void returns nothing
function Self.Say(msg, wpm, range)
	Self.Speak(msg, SPEAK_SAY, wpm, range)
end

--- Self yell.
-- Sends a yelled message to the local chat
-- @class Self
-- @param msg the message/s you want to send
-- @param wpm optional; the words per minute you want to send
-- @param range optional; the randomization for the words per minute value
-- @return void returns nothing
function Self.Yell(msg, wpm, range)
	return Self.Speak(msg, SPEAK_YELL, wpm, range)
end

--- Self whisper.
-- Sends a whispered message to the local chat
-- @class Self
-- @param msg the message/s you want to send
-- @param wpm optional; the words per minute you want to send
-- @param range optional; the randomization for the words per minute value
-- @return void returns nothing
function Self.Whisper(msg, wpm, range)
	return Self.Speak(msg, SPEAK_WHISPER, wpm, range)
end

--- Self say to npc.
-- Sends a message to the npc channel
-- @class Self
-- @param msg the message/s you want to send
-- @param wpm optional; the words per minute you want to send
-- @param range optional; the randomization for the words per minute value
-- @return void returns nothing
function Self.SayToNpc(msg, wpm, range)
	return Self.Speak(msg, SPEAK_NPC, wpm, range)
end

--- Self private message.
-- Sends a private message to a specific player
-- @class Self
-- @param player the name of the recipient
-- @param msg the message you want to send
-- @return void returns nothing
function Self.PrivateMessage(player, msg)
	return selfPrivateMessage(player, msg)
end

--- Self travel
-- Travel to a specific destination
-- @class Self
-- @param destination the destination to travel to
-- @param usering optional; whether to give buddel in svargrond a dwarven ring or not
-- @return boolean true or false
function Self.Travel(destination, usering)
	destination = tostring(destination:lower())
	usering = usering or false
	local npcs = {
		{name = "Anderson", destinations = {["folda"] = {32046,31580,7}, ["tibia"] = {32234,31675,7}, ["vega"] = {32022,31692,7},}},
		{name = "Barry", destinations = {["magician"] = {32884,31156,7}, ["sunken"] = {32884,31164,7},}},
		{name = "Brodrosch", destinations = {["cormaya"] = {33309,31989,15}, ["farmine"] = {33024,31552,10},}},
		{name = "Bruce", destinations = {["alchemist"] = {32737,31113,7}, ["cemetery"] = {32745,31113,7},}},
		{name = "Buddel", destinations = {["barbarian camp"] = {32021,31294,7}, ["helheim"] = {32462,31174,7}, ["okolnir"] = {32224,31381,7}, ["svargrond"] = {32256,31197,7}, ["tyrsung"] = {32333,31227,7},}},
		{name = "Captain Bluebear", destinations = {["ab'dendriel"] = {32733,31668,6}, ["carlin"] = {32387,31821,6}, ["edron"] = {33193,31784,3}, ["liberty bay"] = {32283,32893,6}, ["oramond"] = {33479,31985,7}, ["port hope"] = {32530,32784,6}, ["roshamuul"] = {33493, 32568, 7}, ["svargrond"] = {32341,31108,6}, ["venore"] = {32954,32023,6}, ["yalahar"] = {32816,31272,6},}},
		{name = "Captain Breezelda", destinations = {["carlin"] = {32387,31821,6}, ["thais"] = {32312,32211,6}, ["venore"] = {32954,32023,6},}},
		{name = "Captain Chelop", destinations = {["thais"] = {32312,32211,6},}},
		{name = "Captain Cookie", destinations = {["liberty bay"] = {32298,32896,6},}},
		{name = "Captain Fearless", destinations = {["ab'dendriel"] = {32733,31668,6}, ["ankrahmun"] = {33091,32883,6}, ["carlin"] = {32387,31821,6}, ["darashia"] = {33289,32480,6}, ["edron"] = {33175,31764,6}, ["gray island"] = {33190, 31984, 7}, ["liberty bay"] = {32283,32893,6}, ["port hope"] = {32530,32784,6}, ["svargrond"] = {32341,31108,6}, ["thais"] = {32312,32211,6}, ["yalahar"] = {32816,31272,6},}},
		{name = "Captain Greyhound", destinations = {["ab'dendriel"] = {32733,31668,6}, ["edron"] = {33175,31764,6}, ["svargrond"] = {32341,31108,6}, ["thais"] = {32312,32211,6}, ["venore"] = {32954,32023,6}, ["yalahar"] = {32816,31272,6},}},
		{name = "Captain Gulliver", destinations = {["thais"] = {32312,32211,6},}},
		{name = "Captain Haba", destinations = {["hunt"] = {31942,31047,6}, ["svargrond"] = {32339,31117,7},}},
		{name = "Captain Jack", destinations = {["tibia"] = {32205,31756,6},}},
		{name = "Captain Max", destinations = {["calassa"] = {31920,32710,7}, ["liberty bay"] = {32298,32896,6}, ["yalahar"] = {32804,31270,6},}},
		{name = "Captain Seagull", destinations = {["carlin"] = {32387,31821,6}, ["edron"] = {33175,31764,6}, ["gray island"] = {33190, 31984, 7}, ["thais"] = {32312,32211,6}, ["venore"] = {32954,32023,6}, ["yalahar"] = {32816,31272,6},}},
		{name = "Captain Seahorse", destinations = {["ab'dendriel"] = {32733,31668,6}, ["ankrahmun"] = {33091,32883,6}, ["carlin"] = {32387,31821,6}, ["cormaya"] = {33288,31956,6}, ["gray island"] = {33190, 31984, 7}, ["liberty bay"] = {32283,32893,6}, ["port hope"] = {32530,32784,6}, ["thais"] = {32312,32211,6}, ["venore"] = {32954,32023,6},}},
		{name = "Captain Sinbeard", destinations = {["darashia"] = {33289,32480,6}, ["edron"] = {33175,31764,6}, ["liberty bay"] = {32283,32893,6}, ["port hope"] = {32530,32784,6}, ["venore"] = {32954,32023,6}, ["yalahar"] = {32816,31272,6},}},
		{name = "Captain Waverider", destinations = {["liberty bay"] = {32350,32856,7}, ["passage"] = {32132,32912,7}, ["peg leg"] = {32346,32625,7},}},
		{name = "Carlson", destinations = {["folda"] = {32046,31580,7}, ["senja"] = {32126,31665,7}, ["tibia"] = {32234,31675,7},}},
		{name = "Charles", destinations = {["ankrahmun"] = {33091,32883,6}, ["darashia"] = {33289,32480,6}, ["edron"] = {33175,31764,6}, ["liberty bay"] = {32283,32893,6}, ["thais"] = {32312,32211,6}, ["venore"] = {32954,32023,6}, ["yalahar"] = {32816,31272,6},}},
		{name = "Chemar", destinations = {["edron"] = {33193,31784,3}, ["farmine"] = {32983,31539,1}, ["femor hills"] = {32535,31837,4}, ["kazordoon"] = {32588, 31942, 0}, ["svargrond"] = {32254,31097,4},}},
		{name = "Dalbrect", destinations = {["passage"] = {32190,31957,6},}},
		{name = "Eremo", destinations = {["cormaya"] = {33288,31956,6},}},
		{name = "Gewen", destinations = {["darashia"] = {33269,32441,6}, ["edron"] = {33193,31784,3}, ["farmine"] = {32983,31539,1}, ["femor hills"] = {32535,31837,4}, ["svargrond"] = {32254,31097,4},}},
		{name = "Gurbasch", destinations = {["farmine"] = {33024,31552,10}, ["kazordoon"] = {32658, 31957, 15},}},
		{name = "Hal", destinations = {["alchemist"] = {32688,31187,7}, ["arena"] = {32688,31195,7},}},
		{name = "Harlow", destinations = {["vengoth"] = {32857,31549,7}, ["yalahar"] = {32837,31364,7},}},
		{name = "Imbul", destinations = {["banuta"] = {32826, 32631, 7}, ["center"] = {32628,32771,7}, ["chor"] = {32968,32799,7}, ["east"] = {32679,32777,7}, ["mountain hideout"] = {32987, 32730, 7},}},
		{name = "Iyad", destinations = {["darashia"] = {33269,32441,6}, ["edron"] = {33193,31784,3}, ["farmine"] = {32983,31539,1}, ["femor hills"] = {32535,31837,4}, ["kazordoon"] = {32588, 31942, 0},}},
		{name = "Jack Fate", destinations = {["ankrahmun"] = {33091,32883,6}, ["darashia"] = {33289,32480,6}, ["edron"] = {33175,31764,6}, ["goroma"] = {32161,32558,6}, ["liberty bay"] = {32283,32893,6}, ["port hope"] = {32530,32784,6}, ["thais"] = {32312,32211,6}, ["venore"] = {32954,32023,6}, ["yalahar"] = {32816,31272,6},}},
		{name = "Karith", destinations = {["ab'dendriel"] = {32733,31668,6}, ["ankrahmun"] = {33091,32883,6}, ["carlin"] = {32387,31821,6}, ["darashia"] = {33289,32480,6}, ["liberty bay"] = {32283,32893,6}, ["port hope"] = {32530,32784,6}, ["thais"] = {32312,32211,6}, ["venore"] = {32954,32023,6},}},
		{name = "Lorek", destinations = {["banuta"] = {32826, 32631, 7}, ["center"] = {32628,32771,7}, ["chor"] = {32968,32799,7}, ["mountain hideout"] = {32987, 32730, 7}, ["west"] = {32558,32780,7},}},
		{name = "Maris", destinations = {["fenrock"] = {32564,31313,7}, ["mistrock"] = {32640,31439,7}, ["yalahar"] = {32649,31292,6},}},
		{name = "Melian", destinations = {["darashia"] = {33269,32441,6}, ["edron"] = {33193,31784,3}, ["femor hills"] = {32535,31837,4}, ["kazordoon"] = {32588, 31942, 0}, ["svargrond"] = {32254,31097,4},}},
		{name = "Nielson", destinations = {["folda"] = {32046,31580,7}, ["senja"] = {32126,31665,7}, ["vega"] = {32022,31692,7},}},
		{name = "Old Adall", destinations = {["banuta"] = {32826, 32631, 7}, ["chor"] = {32968,32799,7}, ["east"] = {32679,32777,7}, ["mountain hideout"] = {32987, 32730, 7}, ["west"] = {32558,32780,7},}},
		{name = "Oliver", destinations = {["factory"] = {32895,31233,7}, ["sunken"] = {32895,31225,7},}},
		{name = "Pemaret", destinations = {["edron"] = {33175,31764,6}, ["eremo's island"] = {33315,31882,7},}},
		{name = "Peter", destinations = {["factory"] = {32860,31302,7}, ["trade"] = {32853,31302,7},}},
		{name = "Petros", destinations = {["ankrahmun"] = {33091,32883,6}, ["gray island"] = {33190, 31984, 7}, ["liberty bay"] = {32283,32893,6}, ["port hope"] = {32530,32784,6}, ["venore"] = {32954,32023,6}, ["yalahar"] = {32816,31272,6},}},
		{name = "Pino", destinations = {["darashia"] = {33269,32441,6}, ["farmine"] = {32983,31539,1}, ["femor hills"] = {32535,31837,4}, ["kazordoon"] = {32588, 31942, 0}, ["svargrond"] = {32254,31097,4},}},
		{name = "Rapanaio", destinations = {["isle of evil"] = {32667,31452,7}, ["kazordoon"] = {32700,31989,15},}},
		{name = "Reed", destinations = {["cemetery"] = {32798,31103,7}, ["magician"] = {32806,31103,7},}},
		{name = "Scrutinon", destinations = {["ab'dendriel"] = {32733,31668,6}, ["darashia"] = {33289,32480,6}, ["venore"] = {32954,32023,6},}},
		{name = "Sebastian", destinations = {["liberty bay"] = {32316,32702,7}, ["meriana"] = {32346,32625,7}, ["nargor"] = {32025,32812,7},}},
		{name = "Svenson", destinations = {["senja"] = {32126,31665,7}, ["tibia"] = {32234,31675,7}, ["vega"] = {32022,31692,7},}},
		{name = "Tarak", destinations = {["monument tower"] = {32941,31182,7}, ["yalahar"] = {32916,31199,7},}},
		{name = "Thorgrin", destinations = {["cormaya"] = {33309,31989,15}, ["kazordoon"] = {33309,31989,15},}},
		{name = "Tony", destinations = {["arena"] = {32695,31253,7}, ["foreign"] = {32695,31260,7},}},
		{name = "Uzon", destinations = {["darashia"] = {33269,32441,6}, ["edron"] = {33193,31784,3}, ["farmine"] = {32983,31539,1}, ["kazordoon"] = {32588, 31942, 0}, ["svargrond"] = {32254,31097,4},}},
	}
	local convertednames = {
		{input = {"ab dendriel", "abdendriel"}, say = "ab'dendriel", name = "ab'dendriel",},
		{input = {"barbarian", "camp", "krimhorn"}, say = "barbarian camp", name = "barbarian camp",},
		{input = {"darama"}, say = "darashia", name = "darashia",},
		{input = {"evil", "isleofevil"}, say = "isle of evil", name = "isle of evil",},
		{input = {"femor", "femur", "femur hills", "femurhils", "femorhills"}, say = "femor hills", name = "femor hills",},
		{input = {"grey island", "greyisland", "grayisland"}, say = "gray island", name = "gray island",},
		{input = {"kings", "isleofthekings", "isle of the kings"}, say = "passage", name = "passage",},
		{input = {"libertybay", "liberty"}, say = "liberty bay", name = "liberty bay",},
		{input = {"monument tower", "monument", "trip"}, say = "passage", name = "monument tower",},
		{input = {"pegleg"}, say = "peg leg", name = "peg leg",},
		{input = {"porthope"}, say = "port hope", name = "port hope",},
		{input = {"sea", "serpents", "sea serpent", "seaserpent", "seaserpents", "sea serpents"}, say = "hunt", name = "hunt",},
		{input = {"treasureisland", "treasure island"}, say = "passage", name = "passage",},
	}
	local function getNpcsAround()
		for k, v in ipairs(npcs) do
			npc = v.name
			for name, creature in Creature.iNpcs() do
				if (name == npc) then
					return k, creature
				end
			end
		end
		return nil
	end
	local destinationname
	for k, v in ipairs(convertednames) do
		if (table.contains(v.input, destination)) then
			destination = v.say
			destinationname = v.name
			break
		end
	end
	if (not destinationname) then
		destinationname = destination
	end
	local triesdone, triesmax = 0, math.random(1, 4)
	local destinationreached = false
	while (not destinationreached) do
		local index, npc = getNpcsAround()
		if (not npc) then
			print("XenoBot: Unable to find a travel NPC.")
			return false
		end
		if (not npcs[index].destinations[destinationname]) then
			print("XenoBot: '".. npc:Name() .. "' can not take you to '" .. destinationname:titlecase() .. "'.")
			return false
		end
		local tosay
		if (table.contains({"Barry", "Bruce", "Hal", "Oliver", "Peter", "Reed", "Tony"}, npc:Name())) then
			tosay = {"hi", "pass", destination}
		elseif (npc:Name() == "Captain Fearless" and destinationname == "darashia") then
			tosay = {"hi", destination, "yes", "yes"}
		elseif (npc:Name() == "Buddel") then
			if (usering) then
				tosay = {"hi", "go", destination, "yes"}
			else
				tosay = {"hi", "go", destination, "no", "yes"}
			end
		elseif (npc:Name() == "Scrutinon") then
			tosay = {"hi", "travel", destination}
		else
			tosay = {"hi", destination, "yes"}
		end
		if (npc:DistanceFromSelf() > 2) then
			local waittime = npc:DistanceFromSelf()*1500
			npc:Follow()
			wait(waittime, waittime+500)
			if (npc:DistanceFromSelf() > 2) then
				print("XenoBot: Unable to reach '".. npc:Name() .."'.")
				return false
			end
		end
		if (npc:Name() == "Buddel" and not usering) then
			local startposition = Self.Position()
			Self.SayToNpc(tosay, 65)
			wait(1500, 2000)
			if (getDistanceBetween(Self.Position(), startposition) < 5) then
				Self.SayToNpc({"go", destination, "yes"}, 65)
				wait(1500, 2000)
			end
			triesdone = triesdone+1
		else
			Self.SayToNpc(tosay, 65)
			wait(1500, 2000)
			triesdone = triesdone+1
		end
		local destinationposition = npcs[index].destinations[destinationname]
		if (Self.DistanceFromPosition(destinationposition[1], destinationposition[2], destinationposition[3]) > 2 and npc:Name() ~= "Buddel" and triesdone >= triesmax) then
			print("XenoBot: Could not travel to '".. destinationname:titlecase() .. "' with '".. npc:Name() .."'.")
			return false
		end
		if (Self.DistanceFromPosition(destinationposition[1], destinationposition[2], destinationposition[3]) <= 2) then
			destinationreached = true
		end
	end
	if (destinationreached) then
		return true
	end
	return false
end

--- Get self id.
-- Returns the creature id of your character
-- @class Self
-- @return number your creature id
Self.ID = getSelfID

--- Get self name.
-- Returns the name of your character
-- @class Self
-- @return string your character's name
function Self.Name()
	return getCreatureName(getCreatureListIndex(getSelfID()))
end

--- Get self target id.
-- Returns the creature id of your current target
-- @class Self
-- @return string your target's creature id
Self.TargetID = getSelfTargetID

--- Get self follow id.
-- Returns the creature id of the creature you are currently following
-- @class Self
-- @return number creature id of the creature you are currently following
Self.FollowID = getSelfFollowID

--- Get self position.
-- Returns the current position of your character
-- @class Self
-- @return table x, y, z coordinates of your character
Self.Position = getSelfPosition

--- Get self look direction.
-- Returns the current look direction of your character
-- @class Self
-- @return number look direction of your character
Self.LookDirection = getSelfLookDirection

--- Get self look position.
-- Returns the position coordinates from your look direction and range.
-- @class Self
-- @param range optional; the range around your position to be considered
-- @return x, y, z, coordinates of your look direction and range.
function Self.LookPosition(range)
	return getPositionFromDirection(Self.Position(), Self.LookDirection(), range or 1)
end

--- Get self speed.
-- Returns the speed of your character
-- @class Self
-- @return number speed of your character
Self.Speed = getSelfSpeed

--- Get self outfit.
-- Returns the outfit information of your character
-- @class Self
-- @return table mount, id, addons, head, body, legs, feet values of your character
Self.Outfit = getSelfOutfit

--- Get self skull.
-- Returns the skull type of your character
-- @class Self
-- @return number skull type of your character
Self.Skull = getSelfSkull

--- Get self party status.
-- Returns the party shield type of your character
-- @class Self
-- @return number party shield type of your character
Self.PartyStatus = getSelfPartyStatus

--- Get self pvp icon.
-- Returns the war icon type of your character
-- @class Self
-- @return number war icon type of your character
Self.PvPIcon = getSelfPvPIcon

--- Get self war icon.
-- Returns the war icon type of your character
-- @class Self
-- @return number war icon type of your character
Self.WarIcon = Self.PvPIcon

--- Get self max health.
-- Returns the max health of your character
-- @class Self
-- @return number max health of your character
Self.MaxHealth = getSelfMaxHealth

--- Get self health.
-- Returns the current health of your character
-- @class Self
-- @return number current health of your character
Self.Health = getSelfHealth

--- Get self max mana.
-- Returns the max mana of your character
-- @class Self
-- @return number max mana of your character
Self.MaxMana = getSelfMaxMana

--- Get self mana.
-- Returns the current mana of your character
-- @class Self
-- @return number current mana of your character
Self.Mana = getSelfMana

--- Get self experience.
-- Returns the current experience of your character
-- @class Self
-- @return number current experience of your character
Self.Experience = getSelfExperience

--- Get self level.
-- Returns the current level of your character
-- @class Self
-- @return number current level of your character
Self.Level = getSelfLevel

--- Get self cap.
-- Returns the current cap of your character
-- @class Self
-- @return number current cap of your character
Self.Cap = getSelfCap

--- Get self stamina.
-- Returns the current stamina of your character in minutes
-- @class Self
-- @return number current stamina of your character
Self.Stamina = getSelfStamina

--- Get self soul.
-- Returns the current soul of your character
-- @class Self
-- @return number current soul of your character
Self.Soul = getSelfSoul

--- Is self hasted.
-- Returns whether your character is hasted or not
-- @class Self
-- @return boolean true or false
Self.isHasted = function() return getSelfFlag("hasted") end

--- Is self mana shielded.
-- Returns whether your character is mana shielded or not
-- @class Self
-- @return boolean true or false
Self.isManaShielded = function() return getSelfFlag("mshielded") end

--- Is self paralyzed.
-- Returns whether your character is paralyzed or not
-- @class Self
-- @return boolean true or false
Self.isParalyzed = function() return getSelfFlag("paralyzed") end

--- Is self poisoned.
-- Returns whether your character is poisoned or not
-- @class Self
-- @return boolean true or false
Self.isPoisoned = function() return getSelfFlag("poisoned") end

--- Is self burning.
-- Returns whether your character is burning or not
-- @class Self
-- @return boolean true or false
Self.isBurning = function() return getSelfFlag("burning") end

--- Is self electrified.
-- Returns whether your character is electrified or not
-- @class Self
-- @return boolean true or false
Self.isElectrified = function() return getSelfFlag("electrified") end

--- Is self cursed.
-- Returns whether your character is cursed or not
-- @class Self
-- @return boolean true or false
Self.isCursed = function() return getSelfFlag("cursed") end

--- Is self freezing.
-- Returns whether your character is freezing or not
-- @class Self
-- @return boolean true or false
Self.isFreezing = function() return getSelfFlag("freezing") end

--- Is self drunk.
-- Returns whether your character is drunk or not
-- @class Self
-- @return boolean true or false
Self.isDrunk = function() return getSelfFlag("drunk") end

--- Is self drowning.
-- Returns whether your character is drowning or not
-- @class Self
-- @return boolean true or false
Self.isDrowning = function() return getSelfFlag("drowning") end

--- Is self dazzled.
-- Returns whether your character is dazzled or not
-- @class Self
-- @return boolean true or false
Self.isDazzled = function() return getSelfFlag("dazzled") end

--- Is self bleeding.
-- Returns whether your character is bleeding or not
-- @class Self
-- @return boolean true or false
Self.isBleeding = function() return getSelfFlag("bleeding") end

--- Is self in fight.
-- Returns whether your character is in fight or not
-- @class Self
-- @return boolean true or false
Self.isInFight = function() return getSelfFlag("inbattle") end

--- Is self protection zone locked.
-- Returns whether your character is protection zone locked or not
-- @class Self
-- @return boolean true or false
Self.isPzLocked = function() return getSelfFlag("ispzlocked") end

--- Is self in protection zone.
-- Returns whether your character is in protection zone or not
-- @class Self
-- @return boolean true or false
Self.isInPz = function() return getSelfFlag("inpz") end

--- Is self buffed.
-- Returns whether your character is buffed or not
-- @class Self
-- @return boolean true or false
Self.isBuffed = function() return getSelfFlag("strenghthened") end

--- Get spell cooldown.
-- Returns whether the spell type of the specific spell is on cooldown or not
-- @class Self
-- @param spell casting words of the spell
-- @return boolean true or false
Self.GetSpellCooldown = getSelfSpellCooldown

--- Does self meet spell requirements.
-- Returns whether you meet the specific spell's requirements or not
-- @class Self
-- @param spell casting words of the spell
-- @return boolean true or false
Self.MeetsSpellRequirements = getSelfSpellRequirementsMet

--- Can self cast spell.
-- Returns whether you can cast the specific spell at the moment or not.
-- @class Self
-- @param spell casting words of the spell
-- @return boolean true or false
function Self.CanCastSpell(spell)
	return (Self.GetSpellCooldown(spell) == 0 and Self.MeetsSpellRequirements(spell))
end

--- Self use item.
-- Uses a specific item
-- @class Self
-- @param id the item's id
-- @return boolean true or false
Self.UseItem = selfUseItem

--- Self use item from ground.
-- Uses a ground item from a specific position
-- @class Self
-- @param x coordinate in the map on the x-axis
-- @param y coordinate in the map on the y-axis
-- @param z coordinate in the map on the z-axis
-- @return boolean true or false
Self.UseItemFromGround = selfUseItemFromGround

--- Self browse field.
-- Opens the browse field window of a specific position on the ground
-- @class Self
-- @param x coordinate in the map on the x-axis
-- @param y coordinate in the map on the y-axis
-- @param z coordinate in the map on the z-axis
-- @return boolean true or false
Self.BrowseField = selfBrowseField

--- Self use item with ground.
-- Uses a specific item with a specific position on the ground
-- @class Self
-- @param id the item's id
-- @param x coordinate in the map on the x-axis
-- @param y coordinate in the map on the y-axis
-- @param z coordinate in the map on the z-axis
-- @return boolean true or false
Self.UseItemWithGround = selfUseItemWithGround

--- Self use item with creature.
-- Uses a specific item with a specific creature id
-- @class Self
-- @param id the item's id
-- @param cid the creature's id
-- @return boolean true or false
Self.UseItemWithCreature = selfUseItemWithCreature

--- Self use item from equipment.
-- Uses an item from a specific equipment slot
-- @class Self
-- @param slot the slot you want to use an item from
-- @return boolean true or false
function Self.UseItemFromEquipment(slot)
	local contains, index = table.contains(EQUIPMENT_SLOTS, slot)
	return contains and slotUseItem(index) or 0
end

--- Self use item from my position.
-- Uses a ground item from your position
-- @class Self
-- @return boolean true or false
function Self.UseItemFromMyPosition()
	return Self.UseItemFromGround(Self.Position().x, Self.Position().y, Self.Position().z)
end

--- Self use item with my position.
-- Uses a specific item with your position
-- @class Self
-- @param id the item's id or name
-- @return boolean true or false
function Self.UseItemWithMyPosition(id)
	id = Item.GetItemIDFromDualInput(id)
	return Self.UseItemWithGround(id, Self.Position().x, Self.Position().y, Self.Position().z)
end

--- Self use item with my me.
-- Uses a specific item with yourself
-- @class Self
-- @param id the item's id or name
-- @return boolean true or false
function Self.UseItemWithMe(id)
	id = Item.GetItemIDFromDualInput(id)
	return Self.UseItemWithCreature(id, Self.ID())
end

--- Self use item with target.
-- Uses a specific item with your target
-- @class Self
-- @param id the item's id or name
-- @return boolean true or false
function Self.UseItemWithTarget(id)
	id = Item.GetItemIDFromDualInput(id)
	return Self.UseItemWithCreature(id, Self.TargetID())
end

--- Self use item with follow.
-- Uses a specific item with the creature you are currently following
-- @class Self
-- @param id the item's id or name
-- @return boolean true or false
function Self.UseItemWithFollow(id)
	id = Item.GetItemIDFromDualInput(id)
	return Self.UseItemWithCreature(id, Self.FollowID())
end

--- Get self head.
-- Returns the data structure of the item in your head slot
-- @class Self
-- @return table head item's id, count
Self.Head = getHeadSlotData

--- Get self armor.
-- Returns the data structure of the item in your armor slot
-- @class Self
-- @return table armor item's id, count
Self.Armor = getArmorSlotData

--- Get self legs.
-- Returns the data structure of the item in your legs slot
-- @class Self
-- @return table legs item's id, count
Self.Legs = getLegsSlotData

--- Get self feet.
-- Returns the data structure of the item in your feet slot
-- @class Self
-- @return table feet item's id, count
Self.Feet = getFeetSlotData

--- Get self amulet.
-- Returns the data structure of the item in your amulet slot
-- @class Self
-- @return table amulet item's id, count
Self.Amulet = getAmuletSlotData

--- Get self weapon.
-- Returns the data structure of the item in your weapon slot
-- @class Self
-- @return table weapon item's id, count
Self.Weapon = getWeaponSlotData

--- Get self ring.
-- Returns the data structure of the item in your ring slot
-- @class Self
-- @return table ring item's id, count
Self.Ring = getRingSlotData

--- Get self backpack.
-- Returns the data structure of the item in your backpack slot
-- @class Self
-- @return table backpack item's id, count
Self.Backpack = getBackpackSlotData

--- Get self shield.
-- Returns the data structure of the item in your shield slot
-- @class Self
-- @return table shield item's id, count
Self.Shield = getShieldSlotData

--- Get self ammo.
-- Returns the data structure of the item in your ammo slot
-- @class Self
-- @return table ammo item's id, count
Self.Ammo = getAmmoSlotData

--- Get self creature kills.
-- Returns the amount of all killed creatures/specific creature within the current session
-- @class Self
-- @param creature optional; the name of the creature to check
-- @return number creatures killed
Self.GetCreatureKills = getSelfCreatureKillCount

--- Self reset creature kills.
-- Resets the amount of all killed creatures/specific creature to 0
-- @class Self
-- @param creature optional; the name of the creature to reset
-- @return void returns nothing
Self.ResetCreatureKills = resetSelfCreatureKillCount

--- Get self ping.
-- Returns your current ping
-- @class Self
-- @return number current ping
Self.Ping = getSelfPing

--- Logout of the client
-- Returns nothing important
-- @class Self
-- @return nothing important
Self.Logout = doSelfLogout

--- Self use bed.
-- Uses a bed at specific coordinates and chooses a specific offline training mode
-- @class Self
-- @param x coordinate in the map on the x-axis
-- @param y coordinate in the map on the y-axis
-- @param z coordinate in the map on the z-axis
-- @param mode the training mode to select
-- @return boolean true or false
function Self.UseBed(x, y, z, mode)
	while (Self.UseItemFromGround(x, y, z) == 0) do
		wait(100)
	end

	if (doSelfSelectTrainingMode(mode) == 1) then
		return true
	end
	return false
end

--- Self stop attack.
-- Stops attacking the current target
-- @class Self
-- @return boolean true or false
function Self.StopAttack()
	return attackCreature(0)
end

--- Self stop follow.
-- Stops following the creature you are currently following
-- @class Self
-- @return boolean true or false
function Self.StopFollow()
	return followCreature(0)
end

--- Self turn.
-- Turns your character to a specific direction
-- @class Self
-- @param direction the direction to turn to
-- @return boolean true or false
function Self.Turn(direction)
	if (type(direction) == "string") then
		local index = table.find(DIRECTIONS, direction:lower(), false)
		return index and doSelfTurn(index - 1) or 0
	else
		return doSelfTurn(direction)
	end
end

--- Self step.
-- Does a step in a specific direction
-- @class Self
-- @param direction the direction to turn to
-- @return boolean true or false
function Self.Step(direction)
	if (type(direction) == "string") then
		local index = table.find(DIRECTIONS, direction:lower(), false)
		return index and doSelfStep(index - 1) or 0
	else
		return doSelfStep(direction)
	end
end

--- Self shop sell all items.
-- Sells the possible amount of a specific item
-- @class Self
-- @param item the item's name or id
-- @return number, number success/failure, amount left to sell
function Self.ShopSellAllItems(item)
	while Self.ShopGetItemSaleCount(item) > 0 do
		Self.ShopSellItem(item, Self.ShopGetItemSaleCount(item))
	end
	return 1, 0
end

--- Self shop sell item.
-- Sells a specific amount of a specific item
-- @class Self
-- @param item the item's name or id
-- @param count the amount to sell
-- @return number, number success/failure, amount left to sell
function Self.ShopSellItem(item, count)
	local func = (type(item) == "string") and shopSellItemByName or shopSellItemByID
	count = tonumber(count) or 1
	repeat
		local amnt = math.min(count, 100)
		if (func(item, amnt) == 0) then
			return 0, amnt
		end
		wait(300, 600)
		count = (count - amnt)
	until
		count <= 0
	return 1, 0
end

--- Self shop sell items down to.
-- Sells a specific item down to a specific amount
-- @class Self
-- @param item the item's name or id
-- @param count the amount to keep
-- @return number, number success/failure, amount left to sell
function Self.ShopSellItemsDownTo(item, count)
	return Self.ShopSellItem(item, math.abs(count - Self.ShopGetItemSaleCount(item)))
end

--- Self shop sell flasks.
-- Sells all empty flasks you are carrying
-- @class Self
-- @return void returns nothing
function Self.ShopSellFlasks()
	for id = 283, 285 do
		Self.ShopSellAllItems(id)
	end
end

--- Self shop buy items.
-- Buys a specific amount of a specific item
-- @class Self
-- @param item the item's name or id
-- @param count the amount to buy
-- @return number, number success/failure, amount left to buy
function Self.ShopBuyItem(item, count)
	local func = (type(item) == "string") and shopBuyItemByName or shopBuyItemByID
	count = tonumber(count) or 1
	repeat
		local amnt = math.min(count, 100)
		if (func(item, amnt) == 0) then
			return 0, amnt
		end
		wait(300, 600)
		count = (count - amnt)
	until
		count <= 0
	return 1, 0
end

--- Self shop buy items up to.
-- Buys a specific item until a specific amount is reached
-- @class Self
-- @param item the item's name or id
-- @param c the amount to reach
-- @return number, number success/failure, amount left to buy
function Self.ShopBuyItemsUpTo(item, c)
	local count = c - Self.ItemCount(item)
	if (count > 0) then
		return Self.ShopBuyItem(item, count)
	end
	return 0, 0
end

--- Self shop buy items up to cap.
-- Buys a specific item until a specific cap is reached
-- @class Self
-- @param item the item's name or id
-- @param capacity the cap to reach
-- @return void returns nothing
function Self.ShopBuyItemsUpToCap(item, capacity)
	local count = math.floor((Self.Cap() - capacity) / Item.GetWeight(item))
	while (count > 0) do
		Self.ShopBuyItem(item, count)
		count = math.floor((Self.Cap() - capacity) / Item.GetWeight(item))
	end
end

--- Get shop item purchase price.
-- Returns the purchase price of a specific item
-- @class Self
-- @param item the item's name or id
-- @return number purchase price
function Self.ShopGetItemPurchasePrice(item)
	local func = (type(item) == "string") and shopGetItemBuyPriceByName or shopGetItemBuyPriceByID
	return func(item)
end

--- Get shop item sale count.
-- Returns the sale count of a specific item
-- @class Self
-- @param item the item's name or id
-- @return number sale count
function Self.ShopGetItemSaleCount(item)
	local func = (type(item) == "string") and shopGetItemSaleCountByName or shopGetItemSaleCountByID
	return func(item)
end

--- Get self money.
-- Returns the amount of money in open containers
-- @class Self
-- @return number amount of money
function Self.Money()
	return Self.ItemCount(3031) + (Self.ItemCount(3035) * 100) + (Self.ItemCount(3043) * 10000)
end

--- Self deposit money.
-- Deposits all/a specific amount of money
-- @class Self
-- @param amount optional; the amount to deposit
-- @return void returns nothing
function Self.DepositMoney(amount)
	delayWalker(3000)
	if (type(amount) == 'number') then
		Self.SayToNpc({'hi', 'deposit ' .. math.max(amount, 1), 'yes'}, 70, 5)
	else
		Self.SayToNpc({'hi', 'deposit all', 'yes'}, 70, 5)
	end
end

--- Self withdraw money.
-- Withdraws a specific amount of money
-- @class Self
-- @param amount the amount to withdraw
-- @return void returns nothing
function Self.WithdrawMoney(amount)
	delayWalker(3000)
	Self.SayToNpc({'hi', 'withdraw ' .. amount, 'yes'}, 70, 5)
end

--- Get self flasks.
-- Returns the amount of empty flasks in open containers
-- @class Self
-- @return number amount of empty flasks
function Self.Flasks()
	return Self.ItemCount(283) + Self.ItemCount(284) + Self.ItemCount(285)
end

--- Self open main backpack.
-- Opens your main backpack and optionally minimizes it
-- @class Self
-- @param minimize optional; whether to minimize or not
-- @return void returns nothing
function Self.OpenMainBackpack(minimize)
	repeat
		wait(200)
	until
		(Self.UseItemFromEquipment("backpack") > 0)
	wait(1200)
	
	local ret = Container.GetFirst()
	if (minimize == true) then
		ret:Minimize()
		wait(100)
	end
	return ret
end

--- Get self item count.
-- Returns the amount of a specific item in open container/s
-- @class Self
-- @param itemid the item's id or name
-- @param container optional; the index of a specific container
-- @param countEquipment optional; whether to count items at equipment or not
-- @return number amount of items
function Self.ItemCount(itemid, container, countEquipment)
	if (countEquipment == nil) then
		countEquipment = true
	end 
	itemid = Item.GetItemIDFromDualInput(itemid)
	if (container) then -- count specific container
		return Container.New(container):CountItemsOfID(itemid) or 0
	end
	veryUnsafeFunctionEnterCriticalMode()
	local value = 0
	if (countEquipment) then
		local slots = {Self.Head, Self.Armor, Self.Legs, Self.Feet, Self.Amulet, Self.Weapon, Self.Ring, Self.Shield, Self.Ammo}
		for i = 1, #slots do -- count slots
			local slot = slots[i]()
			if (slot.id == itemid) then
				value = value + math.max(slot.count, 1)
			end
		end
	end
	if (container == nil) then -- count everything
		local cont = Container.GetFirst()
		while (cont:isOpen()) do
			value = value + cont:CountItemsOfID(itemid)
			cont = cont:GetNext()
		end
	end
	veryUnsafeFunctionExitCriticalMode()
	return value
end

--- Self food count
-- Returns the amount of food found in open containers
-- @class Self
-- @return number amount of food
function Self.FoodCount()
	local count = 0
	for index = 0, 15 do
		local container = Container.New(index)
		if (container:isOpen()) then
			for spot = 0, container:ItemCount()-1 do
				if (Item.isFood(container:GetItemData(spot).id)) then
					count = count + container:GetItemData(spot).count
				end
			end
		end
	end
	return count
end

--- Self cast.
-- Casts a specific spell
-- @class Self
-- @param words the spell's casting words
-- @param mana optional; the mana needed to cast the spell
-- @return boolean true or false
function Self.Cast(words, mana)
	if (not mana or Self.Mana() >= mana) then
		return Self.CanCastSpell(words) and Self.Say(words) and wait(300) or 0
	end
end

--- Self levitate
-- Levitates either up or down
-- @class Self
-- @param dir the direction to levitate to
-- @param level the level to levitate to
-- @param tries optional; how often levitating should be tried before aborting
-- @param move optional; whether to try to step first or not
-- @return boolean true or false
function Self.Levitate(dir, level, tries, move)
	local dirs = {
		[1] = {"n", "north"},
		[2] = {"e", "east"},
		[3] = {"s", "south"},
		[4] = {"w", "west"}
	}
	for i = 1, 4 do
		if (table.contains(dirs[i], dir:lower())) then
			turndir = dirs[i][2]
			lookdir = i-1
			break
		end
	end
	if (type(lookdir) ~= "number") then
		return false
	end
	tries = tries or math.random(3, 5)
	move = move or false
	if (not level or (level ~= "up" and level ~= "down")) then
		return false
	end
	local pos, triesDone = Self.Position(), 0
	while (getDistanceBetween(Self.Position(), pos) == 0 and triesDone < tries) do
		if (move) then
			Self.Step(turndir)
			wait(1000, 1500)
		end
		if (Self.Position().z == pos.z) then
			while (Self.LookDirection() ~= lookdir) do Self.Turn(turndir) end
			if (Self.CanCastSpell("exani hur")) then
				Self.Say("exani hur " .. level)
				wait(800, 1000)
				triesDone = triesDone+1
			end
		end
	end
	if (Self.Position().z ~= pos.z) then
		return true
	end
	return false
end

--- Get self distance from position.
-- Returns your distance from a specific position
-- @class Self
-- @param x coordinate in the map on the x-axis
-- @param y coordinate in the map on the y-axis
-- @param z coordinate in the map on the z-axis
-- @return number sqms from position
function Self.DistanceFromPosition(x, y, z)
	return getDistanceBetween(Self.Position(), {x = x, y = y, z = z})
end

--- Self use lever.
-- Uses a lever on a specific position
-- @class Self
-- @param x coordinate in the map on the x-axis
-- @param y coordinate in the map on the y-axis
-- @param z coordinate in the map on the z-axis
-- @param itemid optional; the itemid (the state) the lever should not have
-- @return boolean true or false
function Self.UseLever(x, y, z, itemid) 
	if (itemid == 0 or itemid == nil) then
		repeat
			wait(1000, 1500)
		until
			(Self.UseItemFromGround(x, y, z) ~= 0 or Self.Position().z ~= z)
		return (Self.Position().z == z)
	elseif (itemid > 99) then
		local mapitem = Map.GetTopUseItem(x, y, z)
		while (mapitem.id == itemid and Self.Position().z == z) do
			Self.UseItemFromGround(x, y, z)
			wait(1000, 1500)
			mapitem = Map.GetTopUseItem(x, y, z)
		end
		return (Self.Position().z == z)
	end
	return false
end

--- Self use sewer gate.
-- Uses a sewer gate on a specific position
-- @class Self
-- @param x coordinate in the map on the x-axis
-- @param y coordinate in the map on the y-axis
-- @param z coordinate in the map on the z-axis
-- @return boolean true or false
function Self.UseSewerGate(x, y, z)
	while (Map.GetTopUseItem(x, y, z).id == 435 and Self.Position().z == z) do
		Self.UseItemFromGround(x, y, z)
		wait(1000, 1500)
	end
	if (Self.Position().z ~= z) then
		return true
	end
	return false
end

--- Self use door.
-- Uses a door on a specific position
-- @class Self
-- @param x coordinate in the map on the x-axis
-- @param y coordinate in the map on the y-axis
-- @param z coordinate in the map on the z-axis
-- @param close optional; whether to close the door or not
-- @return boolean true or false
function Self.UseDoor(x, y, z, close)
	close = close or false
	if (not Map.IsTileWalkable(x, y, z) or close) then
		local used = Self.UseItemFromGround(x, y, z)
		wait(1000, 1500)
		return Map.IsTileWalkable(x, y, z) ~= close
	end
end

--- Self cut plant.
-- Cuts a plant on a specific position
-- @class Self
-- @param x coordinate in the map on the x-axis
-- @param y coordinate in the map on the y-axis
-- @param z coordinate in the map on the z-axis
-- @return boolean true or false
function Self.CutPlant(x, y, z)
	if (Map.GetTopUseItem(x, y, z).id == 5463) then
		return true
	end
	local plantids = {
		jungle = {3696, 3702},
		venore = {17153},
		wheat = {3653},
		sugar = {5465},
	}
	local useitemids
	if (table.contains(plantids.jungle, Map.GetTopUseItem(x, y, z).id)) then
		useitemids = {3308, 3330, 9594, 9596, 9598}
	elseif (table.contains(plantids.venore, Map.GetTopUseItem(x, y, z).id)) then
		useitemids = {3308, 3330, 3453, 9594, 9596, 9598}
	elseif (table.contains(plantids.wheat, Map.GetTopUseItem(x, y, z).id)) then
		useitemids = {3453, 9596}
	elseif (table.contains(plantids.sugar, Map.GetTopUseItem(x, y, z).id)) then
		useitemids = {5467}
	else
		useitemids = {}
	end
	local itemid = false
	for _, id in ipairs(useitemids) do
		if (Self.ItemCount(id) > 0) then
			itemid = id
			break
		end
	end
	if (itemid) then
		if (table.contains(plantids.sugar, Map.GetTopUseItem(x, y, z).id)) then
			while (Self.ItemCount(itemid) > 0 and table.contains(plantids.sugar, Map.GetTopUseItem(x, y, z).id)) do
				Self.UseItemWithGround(itemid, x, y, z)
				wait(1000, 1500)
			end
			if (Map.GetTopUseItem(x, y, z).id == 5464) then
				wait(21000, 22000)
			end
			return Map.IsTileWalkable(x, y, z)
		else
			while (Self.ItemCount(itemid) > 0 and (table.contains(plantids.jungle, Map.GetTopUseItem(x, y, z).id) or table.contains(plantids.venore, Map.GetTopUseItem(x, y, z).id) or table.contains(plantids.wheat, Map.GetTopUseItem(x, y, z).id))) do
				Self.UseItemWithGround(itemid, x, y, z)
				wait(1000, 1500)
			end
			return Map.IsTileWalkable(x, y, z)
		end
	end
	return false
end

--- Self break wall
-- Breaks a wall at a specific position
-- @class Self
-- @param x coordinate in the map on the x-axis
-- @param y coordinate in the map on the y-axis
-- @param z coordinate in the map on the z-axis
-- @return boolean true or false
function Self.BreakWall(x, y, z)
	local brokenwallids = {
		dworc = {3145, 3146},
		silk = {188, 189},
	}
	local wallids = {
		dworc = {2295, 2296},
		silk = {182, 183},
	}   
	if (Self.ItemCount(5467) > 0 and table.contains(wallids.silk, Map.GetTopUseItem(x, y, z).id)) then
		itemid = 5467
		while (Self.ItemCount(5467) > 0 and table.contains(wallids.silk, Map.GetTopUseItem(x, y, z).id)) do
			Self.UseItemWithGround(itemid, x, y, z)
			wait(1000, 1500)
		end
		return Map.IsTileWalkable(x, y, z)
	else
		local itemid = false
		for _, id in ipairs(WEAPON_IDS) do
			if (Self.ItemCount(id) > 0) then
				itemid = id
				break
			end
		end
		if (itemid) then
			while (Self.ItemCount(itemid) > 0 and (table.contains(wallids.dworc, Map.GetTopUseItem(x, y, z).id) or table.contains(wallids.silk, Map.GetTopUseItem(x, y, z).id))) do
				Self.UseItemWithGround(itemid, x, y, z)
				wait(1000, 1500)
			end
			return Map.IsTileWalkable(x, y, z)
		end
	end
	return false
end

--- Self use pick.
-- Pick on a specific position and optionally open a hole
-- @class Self
-- @param x coordinate in the map on the x-axis
-- @param y coordinate in the map on the y-axis
-- @param z coordinate in the map on the z-axis
-- @param openhole optional; whether to open a hole or not
-- @return boolean true or false
function Self.UsePick(x, y, z, openhole)
	openhole = openhole or false
	local openholeids = {394}
	local closedholeids = {351, 352, 353, 354, 355, 372}
	local itemid = false
	for _, id in ipairs({3456, 9594, 9596, 9598}) do
		if (Self.ItemCount(id) > 0) then
			itemid = id
			break
		end
	end
	if (itemid) then
		if (openhole) then
			while (Self.ItemCount(itemid) > 0 and not table.contains(openholeids, Map.GetTopUseItem(x, y, z).id) and table.contains(closedholeids, Map.GetTopUseItem(x, y, z).id)) do
				Self.UseItemWithGround(itemid, x, y, z)
				wait(1000, 1500)
			end
			if (table.contains(openholeids, Map.GetTopUseItem(x, y, z).id)) then
				return true
			end
		else
			Self.UseItemWithGround(itemid, x, y, z)
			wait(1000, 1500)
			return true
		end
	end
	return false
end

--- Self dig.
-- Dig on a specific position and optionally open a hole
-- @class Self
-- @param x coordinate in the map on the x-axis
-- @param y coordinate in the map on the y-axis
-- @param z coordinate in the map on the z-axis
-- @param openhole optional; whether to open a hole or not
-- @return boolean true or false
function Self.Dig(x, y, z, openhole)
	openhole = openhole or false
	local openholeids = {594, 607, 609, 615, 868}
	local closedholeids = {231, 593, 606, 608, 614, 867}
	local itemid = false
	for _, id in ipairs({3457, 5710, 9594, 9596, 9598}) do
		if (Self.ItemCount(id) > 0) then
			itemid = id
			break
		end
	end
	if (itemid) then
		if (openhole) then
			while (Self.ItemCount(itemid) > 0 and not table.contains(openholeids, Map.GetTopUseItem(x, y, z).id) and table.contains(closedholeids, Map.GetTopUseItem(x, y, z).id)) do
				Self.UseItemWithGround(itemid, x, y, z)
				wait(1000, 1500)
			end
			if (table.contains(openholeids, Map.GetTopUseItem(x, y, z).id)) then
				return true
			end
		else
			Self.UseItemWithGround(itemid, x, y, z)
			wait(1000, 1500)
			return true
		end
	end
	return false
end

--- Self drop item.
-- Drops a specific amount of a specific item on a specific position
-- @class Self
-- @param x coordinate in the map on the x-axis
-- @param y coordinate in the map on the y-axis
-- @param z coordinate in the map on the z-axis
-- @param itemid the item's id or name
-- @param count optional; the amount to drop
-- @return boolean true or false
function Self.DropItem(x, y, z, itemid, count)
	itemid = Item.GetItemIDFromDualInput(itemid)
	local cont = Container.GetFirst()
	count = count or -1 -- either all or some
	while (cont:isOpen() and (count > 0 or count == -1)) do
		local offset = 0
		for spot = 0, cont:ItemCount() do
			local item = cont:GetItemData(spot - offset)
			if (item.id == itemid) then
				local compareCount = cont:CountItemsOfID(itemid) -- save the current count of this itemid to compare later
				local toMove = math.min((count ~= -1) and count or 100, item.count) -- move either the count or the itemcount whichever is lower (if count is -1 then try 100)
				cont:MoveItemToGround(spot - offset, x, y, z, toMove)
				wait(600, 1000)
				if (compareCount > cont:CountItemsOfID(itemid)) then -- previous count was higher, that means we were successful
					if(toMove == item.count)then -- if the full stack was moved, offset
						offset = offset + 1
					else
						return true -- only part of the stack was needed, we're done.
					end
					if (count ~= -1) then -- if there was a specified limit, we need to honor it.
						count = (count - toMove)
					end
				end
			end
		end
		cont = cont:GetNext()
	end
end

--- Self drop items.
-- Drops all items from a specific list on a specific position
-- @class Self
-- @param x coordinate in the map on the x-axis
-- @param y coordinate in the map on the y-axis
-- @param z coordinate in the map on the z-axis
-- @param ... a table of items to be dropped (either name or id)
-- @return void returns nothing
function Self.DropItems(x, y, z, ...)
	local items = Item.MakeDualInputTableIntoIDTable({...})
	local cont = Container.GetFirst()
	while (cont:isOpen()) do
		local offset = 0
		for spot = 0, cont:ItemCount() do
			local item = cont:GetItemData(spot - offset)
			if (table.contains(items, item.id)) then
				local compareCount = cont:ItemCount() -- save this to compare the bp count to see if anything moved
				cont:MoveItemToGround(spot - offset, x, y, z)
				wait(500, 1000)
				if (compareCount > cont:ItemCount()) then -- previous count is higher, that means item was moved successfully
					offset = offset + 1 -- moved item out, we need to recurse
				end
			end
		end
		cont = cont:GetNext()
	end
end

--- Self move items up to.
-- Moves a specific item from a specific container #1 to a specific container #2 until a specific amount in container #2 is reached
-- @class Self
-- @param item the item's name or id
-- @param count the amount to be reached in container to
-- @param to the container to move to
-- @param from the container to take from
-- @return boolean true or false
function Self.MoveItemsUpTo(item, count, to, from)
	item = Item.GetItemIDFromDualInput(item)
	if (type(to) == "string" or type(to) == "number") then
		to = Container.New(to)
	end
	if (type(from) == "string" or type(from) == "number") then
		from = Container.New(from)
	end
	while (Self.ItemCount(item, to:Index()) < count and Self.ItemCount(item, from:Index()) > 0) do
		for spotfrom = 0, from:ItemCount() - 1 do
			if (from:GetItemData(spotfrom).id == item) then
				for spotto = 0, to:ItemCapacity() - 1 do
					if (not Item.isContainer(to:GetItemData(spotto).id)) then
						from:MoveItemToContainer(spotFrom, to:Index(), spotto, count-Self.ItemCount(item, to:Index()))
						wait(600, 1000)
						break
					end
				end
				break
			end
		end
	end
	if (Self.ItemCount(item, to:Index()) >= count) then
		return true
	end
	return false
end

--- Self move items down to.
-- Moves a specific item from a specific container #1 to a specific container #2 until a specific amount in container #1 is reached
-- @class Self
-- @param item the item's name or id
-- @param count the amount to be reached in container from
-- @param to the container to move to
-- @param from the container to take from
-- @return boolean true or false
function Self.MoveItemsDownTo(item, count, from, to)
	item = Item.GetItemIDFromDualInput(item)
	if (type(from) == "string" or type(from) == "number") then
		from = Container.New(from)
	end
	if ((type(to) == "string" and to:lower() ~= "ground") or type(to) == "number") then
		to = Container.New(to)
	end
	while (Self.ItemCount(item, from:Index()) > count) do
		for spotfrom = 0, from:ItemCount() - 1 do
			if (from:GetItemData(spotfrom).id == item) then
				if (type(to) == "string" and to:lower() == "ground") then
					from:MoveItemToGround(spotfrom, Self.Position().x, Self.Position().y, Self.Position().z, math.abs(count-Self.ItemCount(item, from:Index())))
					wait(600, 1000)
					break
				else
					for spotto = 0, to:ItemCapacity() - 1 do
						if (not Item.isContainer(to:GetItemData(spotto).id)) then
							from:MoveItemToContainer(spotFrom, to:Index(), spotto, math.abs(count-Self.ItemCount(item, from:Index())))
							wait(600, 1000)
							break
						end
					end
				end
				break
			end
		end
	end
end

--- Self drop flasks.
-- Drops all empty flasks on a specific position
-- @class Self
-- @param x coordinate in the map on the x-axis
-- @param y coordinate in the map on the y-axis
-- @param z coordinate in the map on the z-axis
-- @return void returns nothing
function Self.DropFlasks(x, y, z)
	Self.DropItems(x, y, z, 283, 284, 285)
end

--- Self equip.
-- Moves a specific amount of a specific item to a specific equipment slot
-- @class Self
-- @param itemid the item's name or id
-- @param slot the equipment slot to move to
-- @param count optional; the amount to move
-- @return boolean true or false
function Self.Equip(itemid, slot, count)
	itemid = Item.GetItemIDFromDualInput(itemid)
	if (not table.contains(EQUIPMENT_SLOTS, slot)) then
		print("XenoBot: '" .. slot .. "' is not a valid slot.")
		return false
	end
	count = count or 1
	local moveCount = 0
	local cont = Container.GetFirst()
	while (cont:isOpen()) do
		local offset = 0
		for spot = 0, cont:ItemCount() - 1 do
			local item = cont:GetItemData(spot - offset)
			if (itemid == item.id) then
				local toMove = math.min(count-moveCount, item.count)
				if (toMove + moveCount > count) then -- we will be going over the limit (just a failsafe)
					return true
				end
				local compareCount = cont:CountItemsOfID(item.id) -- save this to compare the bp count to see if anything moved
				cont:MoveItemToEquipment(spot - offset, slot, toMove)
				wait(500, 1000)
				if (compareCount > cont:CountItemsOfID(item.id) and toMove == item.count) then -- previous count is higher, that means we have to offset back one or we will skip items
					if (toMove == item.count) then -- if the full stack was moved, offset
						offset = offset + 1
					else
						return true -- only part of the stack was needed, we're done.
					end
				end
				moveCount = moveCount + math.max(1, toMove) -- add up how many we've moved
				if (moveCount >= count) then return true end
			end
		end
		cont = cont:GetNext()
	end
	return false
end

--- Self dequip.
-- Moves an item from a specific equipment slot to a specific container
-- @class Self
-- @param slot the equipment slot to move from
-- @param container the container to move to
-- @return boolean true or false
function Self.Dequip(slot, container)
	if (not table.contains(EQUIPMENT_SLOTS, slot)) then
		print("XenoBot: '" .. slot .. "' is not a valid slot.")
		return false
	end
	container = container or Container.GetFirst()
	if (type(container) == 'number' or type(container) == 'string') then
		container = Container.New(container)
	end
	if (container:isOpen()) then
		if (container:ItemCount() == container:ItemCapacity()) then
			return false
		end
		slotMoveItemToContainer(slot, container._index, container:ItemCapacity() - 1)
	else
		return false
	end
end

--- Self open locker.
-- Opens the locker your character is standing at
-- @class Self
-- @return void returns nothing
function Self.OpenLocker()
	-- Depot position (defaults to look pos)
	local depotPos = Self.LookPosition(1)
	-- Detect entry
	local pos = Self.Position()
	local adjacentWalkableTiles = Map.GetWalkableTiles(pos, 1)
	if adjacentWalkableTiles and adjacentWalkableTiles[1] then
		local entryPos = adjacentWalkableTiles[1]
		depotPos = getPositionFromDirection(pos, Map.GetDirectionTo(entryPos, pos), 1)
	end
	wait(500, 1000)
	local field = Container.New("Browse Field")
	while (not field:isOpen()) do -- locker isn't open
		Self.BrowseField(depotPos.x, depotPos.y, depotPos.z)
		wait(800, 1000)
		field = Container.New("Browse Field")
	end
	while (field:UseItem(0, true) ~= 1) do
		wait(100)
	end
end

--- Self open depot.
-- Opens the depot your character is standing at
-- @class Self
-- @return object/boolean container object/false
function Self.OpenDepot()
	delayWalker(5000)
	local locker, depot = Container.New("Locker"), Container.New("Depot Chest")
	if (depot:isOpen()) then -- depot is already open
		return depot
	end
	if (not locker:isOpen()) then -- locker isn't open
		Self.OpenLocker()
		wait(800, 1000)
		locker = Container.New("Locker")
	end
	if (locker:isOpen()) then  -- if the locker opened successfully
		while (locker:UseItem(0, true) ~= 1) do
			wait(100)
		end
		wait(1000, 1400)
		depot = Container.New("Depot Chest")
		if (depot:isOpen()) then  -- if the depot opened successfully
			return depot
		end
	end
	return false
end

--- Self deposit items
-- Deposits a specific item in a specific container on a specific slot in the depot
-- @class Self
-- @param ... item's name or id, container's slot
-- @return boolean true or false
function Self.DepositItems(...)
	if (#arg > 0) then setBotEnabled(false) end
	local depositInfo = {}

	function makeDepositInfo(input)
		local ret = {}
		for i = 1, #input do
			local data = input[i]
			local spot = 0
			local id = 0
			if (type(data) == 'table') then
				spot = data[2]
				id = Item.GetItemIDFromDualInput(data[1])
			else
				spot = 0
				id = Item.GetItemIDFromDualInput(data)
			end

			if (not ret[spot]) then
				ret[spot] = {}
				ret[spot].realIndex = -1
				ret[spot].items = {}
			end
			table.insert(ret[spot].items, id)
		end
		return ret
	end

	if (#arg > 0) then
		depositInfo = makeDepositInfo(arg)
	else
		local _input = getDepositorList()
		local _realInput = {}
		for i = 1, #_input, 2 do
			local tempInput = {}
			tempInput[1] = _input[i]
			tempInput[2] = _input[i+1]
			table.insert(_realInput, tempInput)
		end
		depositInfo = makeDepositInfo(_realInput)
	end


	local indexes = Container.GetAll() -- list of containers open before we start depositing
	local depot = Self.OpenDepot()
	local badIndexes = #indexes == 0
	if (badIndexes or not depot) then
		if (badIndexes) then
			print("XenoBot: Unable to find open backpacks to deposit from.")
		else
			print("XenoBot: Depositor failed to open depot.")
		end
		if (#arg > 0) then setBotEnabled(true) end
		return false
	end
	depot:Minimize()
	for spot, data in pairs(depositInfo) do -- loop to open all the needed backpacks
		local currentSpot = 0
		for i = 0, depot:ItemCount() - 1 do -- search all items in the depot
			if (Item.isContainer(depot:GetItemData(i).id)) then -- only consider containers
				if (currentSpot == spot) then -- should we open this?
					data.realIndex = Container.GetFreeSlot()
					while (depot:UseItem(spot) ~= 1) do
						wait(100)
					end
					wait(Self.Ping() + 300)
					Container.Minimize(data.realIndex)
				end
				currentSpot = currentSpot + 1 -- increment
			end
		end
	end
	local tempDepositInfo = {} -- warn about and get rid of all depot backpacks which cant be opened
	for spot, data in pairs(depositInfo) do
		if (data.realIndex ~= -1) then
			tempDepositInfo[spot] = data
		else
			print("XenoBot: Depositor is missing a container in depot slot #" .. spot .. ". Please place cascading containers at the required slot in your depot.")
		end
	end
	depositInfo = tempDepositInfo
	function depositItem(depositInfo, contFrom, spot) --when this returns true, we skip the item because we cant deposit it
		local currentItem = contFrom:GetItemData(spot)
		for _, data in pairs(depositInfo) do -- loop through all of our deposit items
			if (table.contains(data.items, currentItem.id)) then -- should we deposit this specific one? try
				local depositBp = Container.New(data.realIndex)
				if (not depositBp:isOpen()) then -- dest container not open, skip this item
					return true
				end
				if (depositBp:ItemCount() < depositBp:ItemCapacity()) then -- if the backpack isn't full, let's use the final slot
					contFrom:MoveItemToContainer(spot, data.realIndex, depositBp:ItemCapacity() - 1)
					return false
				elseif (depositBp:ID() >= 22797 and depositBp:ID() <= 22813) then
					contFrom:MoveItemToContainer(spot, data.realIndex, math.random(0, 3))
					return false
				else -- its full, lets either open the next one or find a good spot
					local toSpot = -1 -- fine the best place to put it if we can still fit it
					for sp = 0, depositBp:ItemCount() - 1 do
						local spData = depositBp:GetItemData(sp)
						if (spData.id == currentItem.id and spData.count ~= 100) then
							toSpot = sp
						end
					end
					if (not Item.isStackable(currentItem.id) or toSpot == -1) then -- no room for this, open a new container
						if (not Item.isContainer(depositBp:GetItemData(depositBp:ItemCapacity() - 1).id)) then -- cant open this container, continue to the next item
							if (not data.warned) then
								data.warned = true
								print("XenoBot: Depositor is unable to find room in deposit container #" .. data.realIndex .. ".")
							end
							return true
						end
						depositBp:UseItem(depositBp:ItemCapacity() - 1, true)
						return false
					else -- there's at least some room, lets fill it up
						contFrom:MoveItemToContainer(spot, data.realIndex, toSpot)
						return false
					end
				end
			end
		end
		return true
	end
	function depositItems(depositInfo, indexes)
		local containers = {}
		for _, index in ipairs(indexes) do -- actually deposit now
			local container = Container.New(index)
			if (container:isOpen()) then
				local checkSpot = 0
				while (checkSpot < container:ItemCount()) do -- loop until no more items to deposit
					if (depositItem(depositInfo, container, checkSpot)) then
						checkSpot = checkSpot + 1 -- if we cant deposit this, skip it
					else
						if (containers[index] == nil) then containers[index] = 0 end
						containers[index] = containers[index] + 1
						wait(300, 700)
					end
				end
			end
		end
		return containers
	end
	-- deposit items, cascading into new backpacks
	local cascadedBps = {}
	while (true) do
		local cascades = depositItems(depositInfo, indexes)
		wait(Self.Ping() + 200)

		local opened = false
		for index, count in pairs(cascades) do
			if (count > 0) then
				local cont = Container.New(index)
				local lastItem = cont:GetItemData(cont:ItemCount() - 1)
				if (Item.isContainer(lastItem.id)) then
					if (cascadedBps[index] == nil) then cascadedBps[index] = 0 end
					repeat
						wait(Self.Ping() + 700)
					until (cont:UseItem(cont:ItemCount() - 1, true) ~= 0)
					wait(Self.Ping() + 700)
					cascadedBps[index] = cascadedBps[index] + 1
					opened = true
				end
			end
		end

		if (opened == false) then break end
	end
	-- go back to parent backpacks
	for index, times in pairs(cascadedBps) do
		for i = 1, times do
			Container.GoBack(index)
			wait(300, 700)
		end
	end
	wait(800, 1300)
	-- close everything
	depot:Close()
	wait(300, 600)
	for spot, data in pairs(depositInfo) do
		Container.New(data.realIndex):Close()
		wait(200, 400)
	end
	wait(1500)
	delayWalker(2500)
	if (#arg > 0) then setBotEnabled(true) end
	return true
end

--- Self withdraw items
-- Withdraws a specific amount of a specific item from a specific slot to a specific container
-- @class Self
-- @param slot the depot container's slot
-- @param ... item's name or id, toContainer, amount
-- @return boolean true or false
function Self.WithdrawItems(slot, ...)
	local items = {}
	local indexes = Container.GetAll()
	for i = 1, #arg do
		local data = arg[i]
		items[i] = {Item.GetItemIDFromDualInput(data[1]), data[2], data[3]}
	end
	local badIndex = -1
	for i = 1, #items do
		if (not Container.New(items[i][2]):isOpen()) then
			badIndex = items[i][2]
			break
		end
	end
	local depot = Self.OpenDepot()
	if (badIndex >= 0 or not depot) then
		if (badIndex >= 0) then
			print("XenoBot: Unable to find open container #" .. badIndex .. ".")
		else
			print("XenoBot: Failed to open depot.")
		end
		return false
	end
	depot:Minimize()    
	local fromIndex = Container.GetFreeSlot()
	if (Item.isContainer(depot:GetItemData(slot).id)) then
		while (depot:UseItem(slot) ~= 1) do
			wait(100)
		end
		wait(Self.Ping() + 300)
		Container.Minimize(fromIndex)
	else
		print("XenoBot: Missing a container in depot slot #" .. slot .. ". Please place at least one container at the required slot in your depot.")
		return false
	end 
	local fromContainer = Container.New(fromIndex)
	if (fromContainer:isOpen()) then
		while (#items > 0) do
			local containsItem = false
			for i = 1, #items do
				if (fromContainer:CountItemsOfID(items[i][1]) > 0 and items[i][3] > 0) then
					containsItem = true
					break
				end
			end
			if (not containsItem) then
				if (Item.isContainer(fromContainer:GetItemData(fromContainer:ItemCount()-1).id)) then
					while (fromContainer:UseItem(fromContainer:ItemCount()-1, true) ~= 1) do
						wait(100)
					end
					wait(Self.Ping() + 500)
				else
					print("XenoBot: The container on the specified slot does not contain any items to withdraw or the next container is not located at the last slot.")
					for i = 1, #items do
						if (items[i][3] > 0) then
							print("XenoBot: Unable to withdraw '" .. items[i][3] .. "' of item '" .. items[i][1] .. "'.")
						end
					end
					return false
				end
			else
				local nextContainer = false
				for i = 1, #items do
					local tempSkipItem = false
					while (fromContainer:CountItemsOfID(items[i][1]) > 0 and items[i][3] > 0) do
						local toContainer = Container.New(items[i][2])
						local compareToCount = toContainer:CountItemsOfID(items[i][1])
						for fromSpot = 0, fromContainer:ItemCount()-1 do
							if (fromContainer:GetItemData(fromSpot).id == items[i][1]) then
								if (toContainer:EmptySlots() > 0) then
									fromContainer:MoveItemToContainer(fromSpot, toContainer:Index(), toContainer:ItemCapacity()-1, items[i][3])
									wait(800, 1200)
								else
									if (Item.isStackable(items[i][1]) and toContainer:CountStackableSlotsOfID(items[i][1]) > 0) then
										for toSpot = 0, toContainer:ItemCount()-1 do
											if (toContainer:GetItemData(toSpot).id == items[i][1] and toContainer:GetItemData(toSpot).count < 100) then
												fromContainer:MoveItemToContainer(fromSpot, toContainer:Index(), toSpot, items[i][3])
												wait(800, 1200)
												break
											end
										end
									else
										nextContainer = true
										if (not nextContainerIndexes) then
											nextContainerIndexes = {}
										end
										if (not table.contains(nextContainerIndexes, items[i][2])) then
											nextContainerIndexes[#nextContainerIndexes+1] = items[i][2]
										end
										tempSkipItem = true
									end
								end
								break
							end
						end
						if (toContainer:CountItemsOfID(items[i][1]) > compareToCount) then
							items[i] = {items[i][1], items[i][2], items[i][3] - (toContainer:CountItemsOfID(items[i][1]) - compareToCount)}
						end
						if (tempSkipItem) then
							break
						end
					end
					if (items[i][3] == 0) then
						table.remove(items, i)
						break
					end
				end
				if (nextContainer) then
					for _, nextContainerIndex in ipairs(nextContainerIndexes) do
						local nextCont = Container.New(nextContainerIndex)
						if (Item.isContainer(nextCont:GetItemData(nextCont:ItemCount()-1).id)) then
							while (nextCont:UseItem(nextCont:ItemCount()-1, true) ~= 1) do
								wait(100)
							end
							wait(Self.Ping() + 500)
						else
							print("XenoBot: Unable to find enough room in withdraw container #" .. nextContainerIndex .. ".")
							for i = 1, #items do
								if (items[i][2] == nextContainerIndex and items[i][3] > 0) then
									print("XenoBot: Unable to withdraw '" .. items[i][3] .. "' of item '" .. items[i][1] .. "'.")
									items[i] = {items[i][1], items[i][2], 0}
								end
							end
						end
					end
					nextContainerIndex = {}
				end
			end
		end
		for i = 0, 15 do
			if (not table.contains(indexes, i)) then
				closeContainer(i)
				wait(100)
			end
		end
		return true
	else
		print("XenoBot: Failed to open withdraw container.")
		return false
	end
	return false
end

--- Self close containers
-- Closes all open containers
-- @class Self
-- @return void returns nothing
function Self.CloseContainers()
	for i = 0, 15 do
		closeContainer(i)
		wait(100)
	end
end

--- Self get spectators
-- Returns a table with creature objects of all spectators
-- @class Self
-- @param multiFloor optional; whether to check all floors or not
-- @return table creature objects of all spectators
function Self.GetSpectators(multiFloor)
	local tbl = {}
	local spec = {getCreatureSpectators(multiFloor and 1 or 0)}
	for _, cIndex in ipairs(spec) do
		if (cIndex >= 0) then
			table.insert(tbl, Creature.New(cIndex))
		end
	end
	return tbl
end

--- Self get targets
-- Returns a table with creature objects of all available targets
-- @class Self
-- @param distance the distance from your position to consider
-- @return table creature objects of all available targets
function Self.GetTargets(distance)
	local tbl = {}
	local spectators = Self.GetSpectators()
	for _, cid in ipairs(spectators) do
		if (cid:DistanceFromSelf() <= distance and cid:isMonster()) then
			table.insert(tbl, cid)
		end
	end
	return tbl
end

--- Self is area pvp safe
-- Returns whether there are players that can be hit in a specific radius around your position or not
-- @class Self
-- @param radius the radius to consider
-- @param multiFloor optional; whether to consider all floors or not
-- @param ignoreParty optional; whether to ignore partied players or not
-- @param ... a list of player names to ignore
-- @return boolean true or false
function Self.isAreaPvPSafe(radius, multiFloor, ignoreParty, ...)
	local spectators = Self.GetSpectators(multiFloor)
	for _, cid in ipairs(spectators) do
		if (cid:DistanceFromSelf() <= radius and cid:isPlayer()) then
			if (not cid:isPartyMember() or not ignoreParty) then
				if (not table.find({...}, cid:Name(), false)) then
					return false
				end
			end
		end
	end
	return true
end

--- Self walk to
-- Walks to a location specified by the paramaters. Will fight with walker/targeter/looter, use wisely.
-- @param x the x part of the location
-- @param y the y part of the location
-- @param z the z part of the location
-- @return boolean true when location reached, or false if on different floor, out of range, or failed to reach after 2 seconds of retries
Self.WalkTo = doSelfWalkTo

--
--      888       888          888 888                            .d8888b.  888                            
--      888   o   888          888 888                           d88P  Y88b 888                            
--      888  d8b  888          888 888                           888    888 888                            
--      888 d888b 888  8888b.  888 888  888  .d88b.  888d888     888        888  8888b.  .d8888b  .d8888b  
--      888d88888b888     "88b 888 888 .88P d8P  Y8b 888P"       888        888     "88b 88K      88K      
--      88888P Y88888 .d888888 888 888888K  88888888 888         888    888 888 .d888888 "Y8888b. "Y8888b. 
--      8888P   Y8888 888  888 888 888 "88b Y8b.     888         Y88b  d88P 888 888  888      X88      X88 
--      888P     Y888 "Y888888 888 888  888  "Y8888  888          "Y8888P"  888 "Y888888  88888P'  88888P'
--

Walker = {}

--- Stop the walker.
-- Stops the walker
-- @class Walker
-- @return void returns nothing
function Walker.Stop()
	setWalkerEnabled(false)
end

--- Start the walker.
-- Starts the walker
-- @class Walker
-- @return void returns nothing
function Walker.Start()
	setWalkerEnabled(true)
end

--- Delay the walker.
-- Delays the walker for specific time
-- @class Walker
-- @param time the time in ms to delay for
-- @return void returns nothing
function Walker.Delay(time)
	delayWalker(time)
end

--- Go to label.
-- Goes to a specific label
-- @class Walker
-- @param label the name of the label to go to
-- @return void returns nothing
function Walker.Goto(label, relative)
	relative = relative and 1 or 0
	gotoLabel(label, relative)
end

--- Conditional go to label.
-- Goes to a specific label depending on a specific condition
-- @class Walker
-- @param cond the condition to check
-- @param truelabel the name of the label to go to if the condition returns true
-- @param falselabel the name of the label to go to if the condition returns false
-- @return void returns nothing
function Walker.ConditionalGoto(cond, truelabel, falselabel, relative)
	if (cond) then
		Walker.Goto(truelabel, relative)
	elseif (falselabel ~= nil) then
		Walker.Goto(falselabel, relative)
	end
end

--- Start the walker luring.
-- Starts the walker luring
-- @class Walker
-- @return void returns nothing
function Walker.StartLuring()
	setWalkerLureEnabled(true)
end

--- Stop the walker luring.
-- Stops the walker luring
-- @class Walker
-- @return void returns nothing
function Walker.StopLuring()
	setWalkerLureEnabled(false)
end

--- Is walker stuck.
-- Returns whether the walker is stuck or not
-- @class Walker
-- @return boolean true or false
Walker.IsStuck = getWalkerStuck

--- Is walker luring.
-- Returns whether the walker is luring or not
-- @class Walker
-- @return boolean true or false
Walker.IsLuring = getWalkerLuring


--- Is walker enabled.
-- Returns whether the walker is enabled or not
-- @class Walker
-- @return boolean true or false
function Walker.IsEnabled()
	return (getXenoBotStatus()["walker"] == 1)
end


--
--      888                        888                          .d8888b.  888                            
--      888                        888                         d88P  Y88b 888                            
--      888                        888                         888    888 888                            
--      888       .d88b.   .d88b.  888888  .d88b.  888d888     888        888  8888b.  .d8888b  .d8888b  
--      888      d88""88b d88""88b 888    d8P  Y8b 888P"       888        888     "88b 88K      88K      
--      888      888  888 888  888 888    88888888 888         888    888 888 .d888888 "Y8888b. "Y8888b. 
--      888      Y88..88P Y88..88P Y88b.  Y8b.     888         Y88b  d88P 888 888  888      X88      X88 
--      88888888  "Y88P"   "Y88P"   "Y888  "Y8888  888          "Y8888P"  888 "Y888888  88888P'  88888P'
--

Looter = {}

--- Stop the looter.
-- Stops the looter
-- @class Looter
-- @return void returns nothing
function Looter.Stop()
	setLooterEnabled(false)
end

--- Start the looter.
-- Starts the looter
-- @class Looter
-- @return void returns nothing
function Looter.Start()
	setLooterEnabled(true)
end

--- Is looter enabled.
-- Returns whether the looter is enabled or not
-- @class Looter
-- @return boolean true or false
function Looter.IsEnabled()
	return (getXenoBotStatus()["looter"] == 1)
end

--
--      88888888888                                 888    d8b                        .d8888b.  888                            
--          888                                     888    Y8P                       d88P  Y88b 888                            
--          888                                     888                              888    888 888                            
--          888   8888b.  888d888  .d88b.   .d88b.  888888 888 88888b.   .d88b.      888        888  8888b.  .d8888b  .d8888b  
--          888      "88b 888P"   d88P"88b d8P  Y8b 888    888 888 "88b d88P"88b     888        888     "88b 88K      88K      
--          888  .d888888 888     888  888 88888888 888    888 888  888 888  888     888    888 888 .d888888 "Y8888b. "Y8888b. 
--          888  888  888 888     Y88b 888 Y8b.     Y88b.  888 888  888 Y88b 888     Y88b  d88P 888 888  888      X88      X88 
--          888  "Y888888 888      "Y88888  "Y8888   "Y888 888 888  888  "Y88888      "Y8888P"  888 "Y888888  88888P'  88888P' 
--                                     888                                   888                                               
--                                Y8b d88P                              Y8b d88P                                               
--                                 "Y88P"                                "Y88P"
--

Targeting = {}

--- Stop the targeting.
-- Stops the targeting
-- @class Targeting
-- @return void returns nothing
function Targeting.Stop()
	setTargetingEnabled(false)
end

--- Start the targeting.
-- Starts the targeting
-- @class Targeting
-- @return void returns nothing
function Targeting.Start()
	setTargetingEnabled(true)
end

--- Start the targeting ignoring.
-- Starts the targeting ignoring
-- @class Targeting
-- @return void returns nothing
function Targeting.StartIgnoring()
	setTargetingIgnoreEnabled(true)
end

--- Stop the targeting ignoring.
-- Stops the targeting ignoring
-- @class Targeting
-- @return void returns nothing
function Targeting.StopIgnoring()
	setTargetingIgnoreEnabled(false)
end

--- Is targeting ignoring
-- Returns whether the targeting is ignoring or not
-- @class Targeting
-- @return boolean true or false
Targeting.IsIgnoring = getTargetingIgnoring


--- Is targeting enabled.
-- Returns whether the targeting is enabled or not
-- @class Targeting
-- @return boolean true or false
function Targeting.IsEnabled()
	return (getXenoBotStatus()["targeting"] == 1)
end


--
--       .d8888b.                             888               888         .d8888b.  888                            
--      d88P  Y88b                            888               888        d88P  Y88b 888                            
--      888    888                            888               888        888    888 888                            
--      888         8888b.  888  888  .d88b.  88888b.   .d88b.  888888     888        888  8888b.  .d8888b  .d8888b  
--      888            "88b 888  888 d8P  Y8b 888 "88b d88""88b 888        888        888     "88b 88K      88K      
--      888    888 .d888888 Y88  88P 88888888 888  888 888  888 888        888    888 888 .d888888 "Y8888b. "Y8888b. 
--      Y88b  d88P 888  888  Y8bd8P  Y8b.     888 d88P Y88..88P Y88b.      Y88b  d88P 888 888  888      X88      X88 
--       "Y8888P"  "Y888888   Y88P    "Y8888  88888P"   "Y88P"   "Y888      "Y8888P"  888 "Y888888  88888P'  88888P'
--

Cavebot = {}

--- Stop the cavebot.
-- Stops the cavebot
-- @class Cavebot
-- @return void returns nothing
function Cavebot.Stop()
	Walker.Stop()
	Looter.Stop()
	Targeting.Stop()
end

--- Start the cavebot.
-- Starts the cavebot
-- @class Cavebot
-- @return void returns nothing
function Cavebot.Start()
	Walker.Start()
	Looter.Start()
	Targeting.Start()
end


--
--      Y88b   d88P                            888888b.            888          .d8888b.  888                            
--       Y88b d88P                             888  "88b           888         d88P  Y88b 888                            
--        Y88o88P                              888  .88P           888         888    888 888                            
--         Y888P     .d88b.  88888b.   .d88b.  8888888K.   .d88b.  888888      888        888  8888b.  .d8888b  .d8888b  
--         d888b    d8P  Y8b 888 "88b d88""88b 888  "Y88b d88""88b 888         888        888     "88b 88K      88K      
--        d88888b   88888888 888  888 888  888 888    888 888  888 888         888    888 888 .d888888 "Y8888b. "Y8888b. 
--       d88P Y88b  Y8b.     888  888 Y88..88P 888   d88P Y88..88P Y88b.       Y88b  d88P 888 888  888      X88      X88 
--      d88P   Y88b  "Y8888  888  888  "Y88P"  8888888P"   "Y88P"   "Y888       "Y8888P"  888 "Y888888  88888P'  88888P' 
--


XenoBot = {}
--- Is xenobot paused.
-- Returns whether the xenobot is paused or not
-- @class XenoBot
-- @return boolean true or false
function XenoBot.IsPaused()
	return (getXenoBotStatus()["paused"] == 1)
end

--- Get status of XenoBot components.
-- Returns a table of information
-- @class XenoBot
-- @return table
function XenoBot.GetStatus()
	return getXenoBotStatus()
end

--- Get current XenoBot username.
-- Returns a username string
-- @class XenoBot
-- @return string
function XenoBot.GetUsername()
	return getUserName()
end

--- Is real tibia or not.
-- Returns true if real Tibia, false if open Tibia
-- @class XenoBot
-- @return boolean
function XenoBot.IsInRealTibia()
	return isRealTibia() == 1
end


--- Shows diagnostic information
-- Returns nil
-- @class XenoBot
-- @return nil
function XenoBot.ShowDiagnostics()
	return setDiagnosticsEnabled(1)
end


--- Hides diagnostic information
-- Returns nil
-- @class XenoBot
-- @return nil
function XenoBot.HideDiagnostics()
	return setDiagnosticsEnabled(0)
end


--- Gets XenoBot version information
-- Returns string
-- @class XenoBot
-- @return string representing xenobot version number
function XenoBot.GetVersionInformation()
	return getVersionNumber()
end

--- Opens the specified file in notepad
-- Returns bool
-- @class XenoBot
-- @param vthe name of the file, not including the path .ini extension
-- @return string true if the config exists, false if otherwise
function XenoBot.ShowConfigEditor(configName)
	return showConfigEditor(configName) == 1 
end


--- Shows a dialog to the user with a list of options they can select from
-- Returns nil if no option selected or (optionId, optionText) if an option is selected
-- @param title the title of the dialog
-- @param text the question to be shown above the buttons
-- @param options table of format {{optionText_1, optionId_1}, .. , {optionText_N, option1d_N}}
-- @class XenoBot
-- @return nil if no option selected or (optionId, optionText) if an option is selected
function XenoBot.ShowDialog(title, text, options)
	if (#options <= DIALOG_MAX_ITEMS) then
		return XenoBot.__showSimpleDialog(title, text, options)
	else
		return XenoBot.__showPagedDialog(title, text, options)
	end
end


function XenoBot.__showSimpleDialog(title, text, options)
	local flatOptions = {}
	local optionMap = {}
	for _, opt in pairs(options) do
		local _text = tostring(opt[1])
		local _value = tonumber(opt[2])
		flatOptions[#flatOptions + 1] = _text
		flatOptions[#flatOptions + 1] = _value
		optionMap[_value] = _text
	end

	local ret = showOptionsDialog(title, text, unpack(flatOptions))
	if (ret == -1) then
		return nil
	else
		return ret, optionMap[ret]
	end
end

function XenoBot.__showPagedDialog(title, text, options)
	local pageCount = math.ceil(#options / DIALOG_ITEMS_PER_PAGE)
	local pages = {}

	for _page = 1, pageCount do
		pages[_page] = {}
		pages[_page]["flatOptions"] = {}
		pages[_page]["optionMap"] = {}
		for option = (_page - 1) * DIALOG_ITEMS_PER_PAGE + 1, (_page) * DIALOG_ITEMS_PER_PAGE do
			if options[option] then
				local _text = tostring(options[option][1])
				local _value = tonumber(options[option][2])
				table.insert(pages[_page]["flatOptions"], _text)
				table.insert(pages[_page]["flatOptions"], _value)
				pages[_page]["optionMap"][_value] = _text
			else
				table.insert(pages[_page]["flatOptions"], "")
				table.insert(pages[_page]["flatOptions"], 0)
			end
		end

		local blankPages = 2
		if (_page > 1) then
			table.insert(pages[_page]["flatOptions"], string.char(171) .. " Previous Page")
			table.insert(pages[_page]["flatOptions"], DIALOG_PREVIOUS_PAGE_BUTTON)
		else
			blankPages = blankPages + 1
		end

		for p = 1, blankPages do
			table.insert(pages[_page]["flatOptions"], "")
			table.insert(pages[_page]["flatOptions"], 0)
		end

		if (_page < pageCount) then
			table.insert(pages[_page]["flatOptions"], "Next Page " .. string.char(187))
			table.insert(pages[_page]["flatOptions"], DIALOG_NEXT_PAGE_BUTTON)
		else
			blankPages = blankPages + 1
		end
	end

	local currentPage = 1
	while (true) do
		local ret = showOptionsDialog(title, text, unpack(pages[currentPage]["flatOptions"]))
		if (ret == DIALOG_PREVIOUS_PAGE_BUTTON) then
			currentPage = currentPage - 1
		elseif (ret == DIALOG_NEXT_PAGE_BUTTON) then
			currentPage = currentPage + 1
		elseif (ret == -1) then
			return nil
		else
			return ret, pages[currentPage]["optionMap"][ret]
		end
	end

end



--
--       .d8888b.  d8b                            888      .d8888b.  888                            
--      d88P  Y88b Y8P                            888     d88P  Y88b 888                            
--      Y88b.                                     888     888    888 888                            
--       "Y888b.   888  .d88b.  88888b.   8888b.  888     888        888  8888b.  .d8888b  .d8888b  
--          "Y88b. 888 d88P"88b 888 "88b     "88b 888     888        888     "88b 88K      88K      
--            "888 888 888  888 888  888 .d888888 888     888    888 888 .d888888 "Y8888b. "Y8888b. 
--      Y88b  d88P 888 Y88b 888 888  888 888  888 888     Y88b  d88P 888 888  888      X88      X88 
--       "Y8888P"  888  "Y88888 888  888 "Y888888 888      "Y8888P"  888 "Y888888  88888P'  88888P' 
--                          888                                                                     
--                     Y8b d88P                                                                     
--                      "Y88P"
--

Signal = {}
libSignals = {}
Signal.__index = Signal
signalsRegistered = false

--- This function should not be used by the regular user and is therefore not explained
function libOnReceive(key, value)
	local signal = libSignals[key]
	if (signal and signal._function) then
		-- Cast types to original value
		local originType = value:sub(1,5)
		local originVal = value:sub(6)
		if (originType == 'int::') then
			value = tonumber(originVal)
		elseif (originType == 'tbl::') then
			value = table.unserialize(originVal)
		elseif (originType == 'bol::') then
			value = originVal == 'true' and true or false
		end
		signal:Execute(value)
	end
end

--- This function should not be used by the regular user and is therefore not explained
function libDestroySignal(key)
	local signal = libSignals[key]
	if (signal) then
		libSignals[key] = nil
	end
end

--- Creates a new signal.
-- Registers the specified function to loop as a signal
-- @class Signal
-- @param key the key to identify the signal as
function Signal.New(key)
	if (libSignals[key]) then
		return libSignals[key]
	end
	local s = {}
	if (not signalsRegistered) then
		registerNativeEventListener(SIGNAL_RECEIVE, 'libOnReceive')
		signalsRegistered = true
	end
	setmetatable(s, Signal)
	s._key = key
	libSignals[key] = s
	return s
end

setmetatable(Signal, {__call = function(_, ...) return Signal.New(...) end})

--- Creates a new signal callback.
-- Registers the specified function to loop as a signal
-- @class Signal
-- @param callback the function to be executed on response
function Signal:OnReceive(callback)
	self = type(self) == 'table' and self or Signal.New(self)
	self._function = callback
end

--- Executes a specific module.
-- Manually triggers the module function
-- @class Signal
-- @param value the data to send through the signal
-- @return void returns nothing
function Signal:Send(value)
	self = type(self) == 'table' and self or Signal.New(self)
	if (self._key and value ~= nil) then
		-- type checking
		local prefix = ''
		local valType = type(value)
		if (valType == 'number') then
			prefix = 'int::'
		elseif (valType == 'table') then
			prefix = 'tbl::'
			value = table.serialize(value)
		elseif (valType == 'boolean') then
			prefix = 'bol::'
			value = tostring(value)
		end
		sendScriptSignal(self._key, prefix..value)
	end
end

--- Executes a specific signal response.
-- Manually triggers the signal
-- @class Signal
-- @return ambiguous anything the function being called might return
function Signal:Execute(value)
	self = type(self) == 'table' and self or Signal.New(self)
	if (type(self._function) == 'string') then
		self._function = _G[self._function]
	end
	return self:_function(value)
end

--- Returns the signal key.
-- Returns the key that the signal was registered under
-- @class Signal
-- @return string the signal key
function Signal:Key()
	return self._key
end

--- Stops the signal event.
-- Stops the signal permanently
-- @class Signal
-- @return void returns nothing
function Signal:Close()
	self = type(self) == 'table' and self or Signal.New(self)
	libDestroySignal(self._key)
end

--
--      888                                 888  .d8888b.                                      888      8888888b.                                          .d8888b.  888                            
--      888                                 888 d88P  Y88b                                     888      888   Y88b                                        d88P  Y88b 888                            
--      888                                 888 Y88b.                                          888      888    888                                        888    888 888                            
--      888       .d88b.   .d8888b  8888b.  888  "Y888b.   88888b.   .d88b.   .d88b.   .d8888b 88888b.  888   d88P 888d888  .d88b.  888  888 888  888     888        888  8888b.  .d8888b  .d8888b  
--      888      d88""88b d88P"        "88b 888     "Y88b. 888 "88b d8P  Y8b d8P  Y8b d88P"    888 "88b 8888888P"  888P"   d88""88b `Y8bd8P' 888  888     888        888     "88b 88K      88K      
--      888      888  888 888      .d888888 888       "888 888  888 88888888 88888888 888      888  888 888        888     888  888   X88K   888  888     888    888 888 .d888888 "Y8888b. "Y8888b. 
--      888      Y88..88P Y88b.    888  888 888 Y88b  d88P 888 d88P Y8b.     Y8b.     Y88b.    888  888 888        888     Y88..88P .d8""8b. Y88b 888     Y88b  d88P 888 888  888      X88      X88 
--      88888888  "Y88P"   "Y8888P "Y888888 888  "Y8888P"  88888P"   "Y8888   "Y8888   "Y8888P 888  888 888        888      "Y88P"  888  888  "Y88888      "Y8888P"  888 "Y888888  88888P'  88888P' 
--                                                         888                                                                                    888                                               
--                                                         888                                                                               Y8b d88P                                               
--                                                         888                                                                                "Y88P"
--

LocalSpeechTypes =
{
	[SPEECH_SAY] = "say",
	[SPEECH_WHISPER] = "whisper",
	[SPEECH_YELL] = "yell",
	[SPEECH_SAY_SPELL] = "cast"
}

LocalSpeechProxy = {}
libLocalSpeechProxies = {}
LocalSpeechProxy.__index = LocalSpeechProxy
localSpeechProxiesRegistered = false

--- This function should not be used by the regular user and is therefore not explained
function libOnLocalSpeech(...)
	local params = {...}
	for begin = 1, #params, 4 do
		local mtype = LocalSpeechTypes[tonumber(params[begin])]
		local speaker = params[begin + 1]
		local level = tonumber(params[begin + 2])
		local text = params[begin + 3]      
		for key, proxy in pairs(libLocalSpeechProxies) do
			proxy:Execute(mtype, speaker, level, text)
		end
	end
end

--- This function should not be used by the regular user and is therefore not explained
function libDestroyLocalSpeechProxy(key)
	local signal = libLocalSpeechProxies[key]
	if (signal) then
		libLocalSpeechProxies[key] = nil
	end
end

--- Creates a new local speech proxy.
-- Registers the local speech proxy callback
-- @class LocalSpeechProxy
-- @param key the key to identify the proxy as
function LocalSpeechProxy.New(key)
	if (libLocalSpeechProxies[key]) then
		return libLocalSpeechProxies[key]
	end
	local s = {}
	if (not localSpeechProxiesRegistered) then
		registerNativeEventListener(LOCAL_SPEECH, 'libOnLocalSpeech')
		localSpeechProxiesRegistered = true
	end
	setmetatable(s, LocalSpeechProxy)
	s._key = key
	libLocalSpeechProxies[key] = s
	return s
end

setmetatable(LocalSpeechProxy, {__call = function(_, ...) return LocalSpeechProxy.New(...) end})

--- Creates a new local speech proxy callback.
-- Registers the specified function1
-- @class LocalSpeechProxy
-- @param callback the function to be executed on response
function LocalSpeechProxy:OnReceive(callback)
	self = type(self) == 'table' and self or LocalSpeechProxy.New(self)
	self._function = callback
end

--- Executes a specific local speech proxy response.
-- Manually triggers the local speech proxy
-- @class LocalSpeechProxy
-- @return ambiguous anything the function being called might return
function LocalSpeechProxy:Execute(mtype, speaker, level, text)
	self = type(self) == 'table' and self or LocalSpeechProxy.New(self)
	if (type(self._function) == 'string') then
		self._function = _G[self._function]
	end
	return self:_function(mtype, speaker, level, text)
end

--- Returns the local speech proxy key.
-- Returns the key that the local speech proxy was registered under
-- @class LocalSpeechProxy
-- @return string the local speech proxy key
function LocalSpeechProxy:Key()
	return self._key
end

--- Stops the local speech proxy event.
-- Stops the local speech proxy permanently
-- @class LocalSpeechProxy
-- @return void returns nothing
function LocalSpeechProxy:Close()
	self = type(self) == 'table' and self or LocalSpeechProxy.New(self)
	libDestroyLocalSpeechProxy(self._key)
end

--
--      8888888b.          d8b                   888             888b     d888                                                       8888888b.                                          .d8888b.  888                            
--      888   Y88b         Y8P                   888             8888b   d8888                                                       888   Y88b                                        d88P  Y88b 888                            
--      888    888                               888             88888b.d88888                                                       888    888                                        888    888 888                            
--      888   d88P 888d888 888 888  888  8888b.  888888  .d88b.  888Y88888P888  .d88b.  .d8888b  .d8888b   8888b.   .d88b.   .d88b.  888   d88P 888d888  .d88b.  888  888 888  888     888        888  8888b.  .d8888b  .d8888b  
--      8888888P"  888P"   888 888  888     "88b 888    d8P  Y8b 888 Y888P 888 d8P  Y8b 88K      88K          "88b d88P"88b d8P  Y8b 8888888P"  888P"   d88""88b `Y8bd8P' 888  888     888        888     "88b 88K      88K      
--      888        888     888 Y88  88P .d888888 888    88888888 888  Y8P  888 88888888 "Y8888b. "Y8888b. .d888888 888  888 88888888 888        888     888  888   X88K   888  888     888    888 888 .d888888 "Y8888b. "Y8888b. 
--      888        888     888  Y8bd8P  888  888 Y88b.  Y8b.     888   "   888 Y8b.          X88      X88 888  888 Y88b 888 Y8b.     888        888     Y88..88P .d8""8b. Y88b 888     Y88b  d88P 888 888  888      X88      X88 
--      888        888     888   Y88P   "Y888888  "Y888  "Y8888  888       888  "Y8888   88888P'  88888P' "Y888888  "Y88888  "Y8888  888        888      "Y88P"  888  888  "Y88888      "Y8888P"  888 "Y888888  88888P'  88888P' 
--                                                                                                                      888                                                    888                                               
--                                                                                                                 Y8b d88P                                               Y8b d88P                                               
--                                                                                                                  "Y88P"                                                 "Y88P"
--

PrivateMessageProxy = {}
libPrivateMessageProxies = {}
PrivateMessageProxy.__index = PrivateMessageProxy
privateMessageProxiesRegistered = false

--- This function should not be used by the regular user and is therefore not explained
function libOnPrivateMessage(...)
	local params = {...}
	for begin = 1, #params, 4 do
		local speaker = params[begin]
		local level = tonumber(params[begin + 1])
		local text = params[begin + 2]      
		for key, proxy in pairs(libPrivateMessageProxies) do
			proxy:Execute(speaker, level, text)
		end
	end
end

--- This function should not be used by the regular user and is therefore not explained
function libDestroyPrivateMessageProxy(key)
	local signal = libPrivateMessageProxies[key]
	if (signal) then
		libPrivateMessageProxies[key] = nil
	end
end

--- Creates a new private message proxy.
-- Registers the private message proxy callback
-- @class PrivateMessageProxy
-- @param key the key to identify the proxy as
function PrivateMessageProxy.New(key)
	if (libPrivateMessageProxies[key]) then
		return libPrivateMessageProxies[key]
	end
	local s = {}
	if (not privateMessageProxiesRegistered) then
		registerNativeEventListener(PRIVATE_MESSAGE, 'libOnPrivateMessage')
		privateMessageProxiesRegistered = true
	end
	setmetatable(s, PrivateMessageProxy)
	s._key = key
	libPrivateMessageProxies[key] = s
	return s
end

setmetatable(PrivateMessageProxy, {__call = function(_, ...) return PrivateMessageProxy.New(...) end})

--- Creates a new private message proxy callback.
-- Registers the specified function1
-- @class PrivateMessageProxy
-- @param callback the function to be executed on response
function PrivateMessageProxy:OnReceive(callback)
	self = type(self) == 'table' and self or PrivateMessageProxy.New(self)
	self._function = callback
end

--- Executes a specific private message proxy response.
-- Manually triggers the private message proxy
-- @class PrivateMessageProxy
-- @return ambiguous anything the function being called might return
function PrivateMessageProxy:Execute(speaker, level, text)
	self = type(self) == 'table' and self or PrivateMessageProxy.New(self)
	if (type(self._function) == 'string') then
		self._function = _G[self._function]
	end
	return self:_function(speaker, level, text)
end

--- Returns the private message proxy key.
-- Returns the key that the private message proxy was registered under
-- @class PrivateMessageProxy
-- @return string the private message proxy key
function PrivateMessageProxy:Key()
	return self._key
end

--- Stops the private message proxy event.
-- Stops the private message proxy permanently
-- @class PrivateMessageProxy
-- @return void returns nothing
function PrivateMessageProxy:Close()
	self = type(self) == 'table' and self or PrivateMessageProxy.New(self)
	libDestroyPrivateMessageProxy(self._key)
end

--
--      8888888888                                  888b     d888                                                       8888888b.                                          .d8888b.  888                            
--      888                                         8888b   d8888                                                       888   Y88b                                        d88P  Y88b 888                            
--      888                                         88888b.d88888                                                       888    888                                        888    888 888                            
--      8888888    888d888 888d888  .d88b.  888d888 888Y88888P888  .d88b.  .d8888b  .d8888b   8888b.   .d88b.   .d88b.  888   d88P 888d888  .d88b.  888  888 888  888     888        888  8888b.  .d8888b  .d8888b  
--      888        888P"   888P"   d88""88b 888P"   888 Y888P 888 d8P  Y8b 88K      88K          "88b d88P"88b d8P  Y8b 8888888P"  888P"   d88""88b `Y8bd8P' 888  888     888        888     "88b 88K      88K      
--      888        888     888     888  888 888     888  Y8P  888 88888888 "Y8888b. "Y8888b. .d888888 888  888 88888888 888        888     888  888   X88K   888  888     888    888 888 .d888888 "Y8888b. "Y8888b. 
--      888        888     888     Y88..88P 888     888   "   888 Y8b.          X88      X88 888  888 Y88b 888 Y8b.     888        888     Y88..88P .d8""8b. Y88b 888     Y88b  d88P 888 888  888      X88      X88 
--      8888888888 888     888      "Y88P"  888     888       888  "Y8888   88888P'  88888P' "Y888888  "Y88888  "Y8888  888        888      "Y88P"  888  888  "Y88888      "Y8888P"  888 "Y888888  88888P'  88888P' 
--                                                                                                         888                                                    888                                               
--                                                                                                    Y8b d88P                                               Y8b d88P                                               
--                                                                                                     "Y88P"                                                 "Y88P"
--

ErrorMessageProxy = {}
libErrorMessageProxies = {}
ErrorMessageProxy.__index = ErrorMessageProxy
errorMessageProxiesRegistered = false

--- This function should not be used by the regular user and is therefore not explained
function libOnErrorMessage(...)
	local params = {...}
	for _, message in ipairs(params) do
		for key, proxy in pairs(libErrorMessageProxies) do
			proxy:Execute(message)
		end
	end
end
--- This function should not be used by the regular user and is therefore not explained
function libDestroyErrorMessageProxy(key)
	local signal = libErrorMessageProxies[key]
	if (signal) then
		libErrorMessageProxies[key] = nil
	end
end

--- Creates a new error message proxy.
-- Registers the error message proxy callback
-- @class ErrorMessageProxy
-- @param key the key to identify the proxy as
function ErrorMessageProxy.New(key)
	if (libErrorMessageProxies[key]) then
		return libErrorMessageProxies[key]
	end
	local s = {}
	if (not errorMessageProxiesRegistered) then
		registerNativeEventListener(ERROR_MESSAGE, 'libOnErrorMessage')
		errorMessageProxiesRegistered = true
	end
	setmetatable(s, ErrorMessageProxy)
	s._key = key
	libErrorMessageProxies[key] = s
	return s
end

setmetatable(ErrorMessageProxy, {__call = function(_, ...) return ErrorMessageProxy.New(...) end})

--- Creates a new error message proxy callback.
-- Registers the specified function1
-- @class ErrorMessageProxy
-- @param callback the function to be executed on response
function ErrorMessageProxy:OnReceive(callback)
	self = type(self) == 'table' and self or ErrorMessageProxy.New(self)
	self._function = callback
end

--- Executes a specific error message proxy response.
-- Manually triggers the error message proxy
-- @class ErrorMessageProxy
-- @return ambiguous anything the function being called might return
function ErrorMessageProxy:Execute(message)
	self = type(self) == 'table' and self or ErrorMessageProxy.New(self)
	if (type(self._function) == 'string') then
		self._function = _G[self._function]
	end
	return self:_function(message)
end

--- Returns the error message proxy key.
-- Returns the key that the error message proxy was registered under
-- @class ErrorMessageProxy
-- @return string the error message proxy key
function ErrorMessageProxy:Key()
	return self._key
end

--- Stops the error message proxy event.
-- Stops the error message proxy permanently
-- @class ErrorMessageProxy
-- @return void returns nothing
function ErrorMessageProxy:Close()
	self = type(self) == 'table' and self or ErrorMessageProxy.New(self)
	libDestroyErrorMessageProxy(self._key)
end

--
--      888                        888    888b     d888                                                       8888888b.                                          .d8888b.  888                            
--      888                        888    8888b   d8888                                                       888   Y88b                                        d88P  Y88b 888                            
--      888                        888    88888b.d88888                                                       888    888                                        888    888 888                            
--      888       .d88b.   .d88b.  888888 888Y88888P888  .d88b.  .d8888b  .d8888b   8888b.   .d88b.   .d88b.  888   d88P 888d888  .d88b.  888  888 888  888     888        888  8888b.  .d8888b  .d8888b  
--      888      d88""88b d88""88b 888    888 Y888P 888 d8P  Y8b 88K      88K          "88b d88P"88b d8P  Y8b 8888888P"  888P"   d88""88b `Y8bd8P' 888  888     888        888     "88b 88K      88K      
--      888      888  888 888  888 888    888  Y8P  888 88888888 "Y8888b. "Y8888b. .d888888 888  888 88888888 888        888     888  888   X88K   888  888     888    888 888 .d888888 "Y8888b. "Y8888b. 
--      888      Y88..88P Y88..88P Y88b.  888   "   888 Y8b.          X88      X88 888  888 Y88b 888 Y8b.     888        888     Y88..88P .d8""8b. Y88b 888     Y88b  d88P 888 888  888      X88      X88 
--      88888888  "Y88P"   "Y88P"   "Y888 888       888  "Y8888   88888P'  88888P' "Y888888  "Y88888  "Y8888  888        888      "Y88P"  888  888  "Y88888      "Y8888P"  888 "Y888888  88888P'  88888P' 
--                                                                                               888                                                    888                                               
--                                                                                          Y8b d88P                                               Y8b d88P                                               
--                                                                                           "Y88P"                                                 "Y88P"
--

LootMessageProxy = {}
libLootMessageProxies = {}
LootMessageProxy.__index = LootMessageProxy
lootMessageProxiesRegistered = false

--- This function should not be used by the regular user and is therefore not explained
function libOnLootMessage(...)
	local params = {...}
	for _, message in ipairs(params) do
		for key, proxy in pairs(libLootMessageProxies) do
			proxy:Execute(message)
		end
	end
end

--- This function should not be used by the regular user and is therefore not explained
function libDestroyLootMessageProxy(key)
	local signal = libLootMessageProxies[key]
	if (signal) then
		libLootMessageProxies[key] = nil
	end
end

--- Creates a new loot message proxy.
-- Registers the loot message proxy callback
-- @class LootMessageProxy
-- @param key the key to identify the proxy as
function LootMessageProxy.New(key)
	if (libLootMessageProxies[key]) then
		return libLootMessageProxies[key]
	end
	local s = {}
	if (not lootMessageProxiesRegistered) then
		registerNativeEventListener(LOOT_MESSAGE, 'libOnLootMessage')
		lootMessageProxiesRegistered = true
	end
	setmetatable(s, LootMessageProxy)
	s._key = key
	libLootMessageProxies[key] = s
	return s
end

setmetatable(LootMessageProxy, {__call = function(_, ...) return LootMessageProxy.New(...) end})

--- Creates a new loot message proxy callback.
-- Registers the specified function1
-- @class LootMessageProxy
-- @param callback the function to be executed on response
function LootMessageProxy:OnReceive(callback)
	self = type(self) == 'table' and self or LootMessageProxy.New(self)
	self._function = callback
end

--- Executes a specific loot message proxy response.
-- Manually triggers the loot message proxy
-- @class LootMessageProxy
-- @return ambiguous anything the function being called might return
function LootMessageProxy:Execute(message)
	self = type(self) == 'table' and self or LootMessageProxy.New(self)

	if (type(self._function) == 'string') then
		self._function = _G[self._function]
	end
	return self:_function(message)
end

--- Returns the loot message proxy key.
-- Returns the key that the loot message proxy was registered under
-- @class LootMessageProxy
-- @return string the loot message proxy key
function LootMessageProxy:Key()
	return self._key
end

--- Stops the loot message proxy event.
-- Stops the loot message proxy permanently
-- @class LootMessageProxy
-- @return void returns nothing
function LootMessageProxy:Close()
	self = type(self) == 'table' and self or LootMessageProxy.New(self)
	libDestroyLootMessageProxy(self._key)
end

--
--      888                        888      888b     d888                                                       8888888b.                                          .d8888b.  888                            
--      888                        888      8888b   d8888                                                       888   Y88b                                        d88P  Y88b 888                            
--      888                        888      88888b.d88888                                                       888    888                                        888    888 888                            
--      888       .d88b.   .d88b.  888  888 888Y88888P888  .d88b.  .d8888b  .d8888b   8888b.   .d88b.   .d88b.  888   d88P 888d888  .d88b.  888  888 888  888     888        888  8888b.  .d8888b  .d8888b  
--      888      d88""88b d88""88b 888 .88P 888 Y888P 888 d8P  Y8b 88K      88K          "88b d88P"88b d8P  Y8b 8888888P"  888P"   d88""88b `Y8bd8P' 888  888     888        888     "88b 88K      88K      
--      888      888  888 888  888 888888K  888  Y8P  888 88888888 "Y8888b. "Y8888b. .d888888 888  888 88888888 888        888     888  888   X88K   888  888     888    888 888 .d888888 "Y8888b. "Y8888b. 
--      888      Y88..88P Y88..88P 888 "88b 888   "   888 Y8b.          X88      X88 888  888 Y88b 888 Y8b.     888        888     Y88..88P .d8""8b. Y88b 888     Y88b  d88P 888 888  888      X88      X88 
--      88888888  "Y88P"   "Y88P"  888  888 888       888  "Y8888   88888P'  88888P' "Y888888  "Y88888  "Y8888  888        888      "Y88P"  888  888  "Y88888      "Y8888P"  888 "Y888888  88888P'  88888P' 
--                                                                                                 888                                                    888                                               
--                                                                                            Y8b d88P                                               Y8b d88P                                               
--                                                                                             "Y88P"                                                 "Y88P"
--

LookMessageProxy = {}
libLookMessageProxies = {}
LookMessageProxy.__index = LookMessageProxy
lookMessageProxiesRegistered = false

--- This function should not be used by the regular user and is therefore not explained
function libOnLookMessage(...)
	local params = {...}
	for _, message in ipairs(params) do
		for key, proxy in pairs(libLookMessageProxies) do
			proxy:Execute(message)
		end
	end
end

--- This function should not be used by the regular user and is therefore not explained
function libDestroyLookMessageProxy(key)
	local signal = libLookMessageProxies[key]
	if (signal) then
		libLookMessageProxies[key] = nil
	end
end

--- Creates a new look message proxy.
-- Registers the look message proxy callback
-- @class LookMessageProxy
-- @param key the key to identify the proxy as
function LookMessageProxy.New(key)
	if (libLookMessageProxies[key]) then
		return libLookMessageProxies[key]
	end
	local s = {}
	if (not lookMessageProxiesRegistered) then
		registerNativeEventListener(LOOK_MESSAGE, 'libOnLookMessage')
		lookMessageProxiesRegistered = true
	end
	setmetatable(s, LookMessageProxy)
	s._key = key
	libLookMessageProxies[key] = s
	return s
end

setmetatable(LookMessageProxy, {__call = function(_, ...) return LookMessageProxy.New(...) end})

--- Creates a new look message proxy callback.
-- Registers the specified function1
-- @class LookMessageProxy
-- @param callback the function to be executed on response
function LookMessageProxy:OnReceive(callback)
	self = type(self) == 'table' and self or LookMessageProxy.New(self)
	self._function = callback
end

--- Executes a specific look message proxy response.
-- Manually triggers the look message proxy
-- @class LookMessageProxy
-- @return ambiguous anything the function being called might return
function LookMessageProxy:Execute(message)
	self = type(self) == 'table' and self or LookMessageProxy.New(self)
	if (type(self._function) == 'string') then
		self._function = _G[self._function]
	end
	return self:_function(message)
end

--- Returns the look message proxy key.
-- Returns the key that the look message proxy was registered under
-- @class LookMessageProxy
-- @return string the look message proxy key
function LookMessageProxy:Key()
	return self._key
end

--- Stops the look message proxy event.
-- Stops the look message proxy permanently
-- @class LookMessageProxy
-- @return void returns nothing
function LookMessageProxy:Close()
	self = type(self) == 'table' and self or LookMessageProxy.New(self)
	libDestroyLookMessageProxy(self._key)
end

--
--      888888b.            888    888    888          888b     d888                                                       8888888b.                                          .d8888b.  888                            
--      888  "88b           888    888    888          8888b   d8888                                                       888   Y88b                                        d88P  Y88b 888                            
--      888  .88P           888    888    888          88888b.d88888                                                       888    888                                        888    888 888                            
--      8888888K.   8888b.  888888 888888 888  .d88b.  888Y88888P888  .d88b.  .d8888b  .d8888b   8888b.   .d88b.   .d88b.  888   d88P 888d888  .d88b.  888  888 888  888     888        888  8888b.  .d8888b  .d8888b  
--      888  "Y88b     "88b 888    888    888 d8P  Y8b 888 Y888P 888 d8P  Y8b 88K      88K          "88b d88P"88b d8P  Y8b 8888888P"  888P"   d88""88b `Y8bd8P' 888  888     888        888     "88b 88K      88K      
--      888    888 .d888888 888    888    888 88888888 888  Y8P  888 88888888 "Y8888b. "Y8888b. .d888888 888  888 88888888 888        888     888  888   X88K   888  888     888    888 888 .d888888 "Y8888b. "Y8888b. 
--      888   d88P 888  888 Y88b.  Y88b.  888 Y8b.     888   "   888 Y8b.          X88      X88 888  888 Y88b 888 Y8b.     888        888     Y88..88P .d8""8b. Y88b 888     Y88b  d88P 888 888  888      X88      X88 
--      8888888P"  "Y888888  "Y888  "Y888 888  "Y8888  888       888  "Y8888   88888P'  88888P' "Y888888  "Y88888  "Y8888  888        888      "Y88P"  888  888  "Y88888      "Y8888P"  888 "Y888888  88888P'  88888P' 
--                                                                                                            888                                                    888                                               
--                                                                                                       Y8b d88P                                               Y8b d88P                                               
--                                                                                                        "Y88P"                                                 "Y88P"
--

BattleMessageProxy = {}
libBattleMessageProxies = {}
BattleMessageProxy.__index = BattleMessageProxy
battleMessageProxiesRegistered = false

--- This function should not be used by the regular user and is therefore not explained
function libOnBattleMessage(...)
	local params = {...}
	for _, message in ipairs(params) do
		for key, proxy in pairs(libBattleMessageProxies) do
			proxy:Execute(message)
		end
	end
end

--- This function should not be used by the regular user and is therefore not explained
function libDestroyBattleMessageProxy(key)
	local signal = libBattleMessageProxies[key]
	if (signal) then
		libBattleMessageProxies[key] = nil
	end
end

--- Creates a new battle message proxy.
-- Registers the battle message proxy callback
-- @class BattleMessageProxy
-- @param key the key to identify the proxy as
function BattleMessageProxy.New(key)
	if (libBattleMessageProxies[key]) then
		return libBattleMessageProxies[key]
	end
	local s = {}
	if (not battleMessageProxiesRegistered) then
		registerNativeEventListener(BATTLE_MESSAGE, 'libOnBattleMessage')
		battleMessageProxiesRegistered = true
	end
	setmetatable(s, BattleMessageProxy)
	s._key = key
	libBattleMessageProxies[key] = s
	return s
end

setmetatable(BattleMessageProxy, {__call = function(_, ...) return BattleMessageProxy.New(...) end})

--- Creates a new battle message proxy callback.
-- Registers the specified function1
-- @class BattleMessageProxy
-- @param callback the function to be executed on response
function BattleMessageProxy:OnReceive(callback)
	self = type(self) == 'table' and self or BattleMessageProxy.New(self)
	self._function = callback
end

--- Executes a specific battle message proxy response.
-- Manually triggers the battle message proxy
-- @class BattleMessageProxy
-- @return ambiguous anything the function being called might return
function BattleMessageProxy:Execute(message)
	self = type(self) == 'table' and self or BattleMessageProxy.New(self)
	if (type(self._function) == 'string') then
		self._function = _G[self._function]
	end
	return self:_function(message)
end

--- Returns the battle message proxy key.
-- Returns the key that the battle message proxy was registered under
-- @class BattleMessageProxy
-- @return string the battle message proxy key
function BattleMessageProxy:Key()
	return self._key
end

--- Stops the battle message proxy event.
-- Stops the battle message proxy permanently
-- @class BattleMessageProxy
-- @return void returns nothing
function BattleMessageProxy:Close()
	self = type(self) == 'table' and self or BattleMessageProxy.New(self)
	libDestroyBattleMessageProxy(self._key)
end

--
--      8888888888  .d888  .d888                   888    888b     d888                                                       8888888b.                                          .d8888b.  888                            
--      888        d88P"  d88P"                    888    8888b   d8888                                                       888   Y88b                                        d88P  Y88b 888                            
--      888        888    888                      888    88888b.d88888                                                       888    888                                        888    888 888                            
--      8888888    888888 888888  .d88b.   .d8888b 888888 888Y88888P888  .d88b.  .d8888b  .d8888b   8888b.   .d88b.   .d88b.  888   d88P 888d888  .d88b.  888  888 888  888     888        888  8888b.  .d8888b  .d8888b  
--      888        888    888    d8P  Y8b d88P"    888    888 Y888P 888 d8P  Y8b 88K      88K          "88b d88P"88b d8P  Y8b 8888888P"  888P"   d88""88b `Y8bd8P' 888  888     888        888     "88b 88K      88K      
--      888        888    888    88888888 888      888    888  Y8P  888 88888888 "Y8888b. "Y8888b. .d888888 888  888 88888888 888        888     888  888   X88K   888  888     888    888 888 .d888888 "Y8888b. "Y8888b. 
--      888        888    888    Y8b.     Y88b.    Y88b.  888   "   888 Y8b.          X88      X88 888  888 Y88b 888 Y8b.     888        888     Y88..88P .d8""8b. Y88b 888     Y88b  d88P 888 888  888      X88      X88 
--      8888888888 888    888     "Y8888   "Y8888P  "Y888 888       888  "Y8888   88888P'  88888P' "Y888888  "Y88888  "Y8888  888        888      "Y88P"  888  888  "Y88888      "Y8888P"  888 "Y888888  88888P'  88888P' 
--                                                                                                               888                                                    888                                               
--                                                                                                          Y8b d88P                                               Y8b d88P                                               
--                                                                                                           "Y88P"                                                 "Y88P"
--

EffectMessageProxy = {}
libEffectMessageProxies = {}
EffectMessageProxy.__index = EffectMessageProxy
effectMessageProxiesRegistered = false

--- This function should not be used by the regular user and is therefore not explained
function libOnEffectMessage(...)
	local params = {...}
	for begin = 1, #params, 4 do
		local message = params[begin]
		local x = tonumber(params[begin + 1])
		local y = tonumber(params[begin + 2])
		local z = tonumber(params[begin + 3])   
		for key, proxy in pairs(libEffectMessageProxies) do
			proxy:Execute(message, x, y, z)
		end
	end
end

--- This function should not be used by the regular user and is therefore not explained
function libDestroyEffectMessageProxy(key)
	local signal = libEffectMessageProxies[key]
	if (signal) then
		libEffectMessageProxies[key] = nil
	end
end

--- Creates a new effect message proxy.
-- Registers the effect message proxy callback
-- @class EffectMessageProxy
-- @param key the key to identify the proxy as
function EffectMessageProxy.New(key)
	if (libEffectMessageProxies[key]) then
		return libEffectMessageProxies[key]
	end
	local s = {}
	if (not effectMessageProxiesRegistered) then
		registerNativeEventListener(EFFECT_MESSAGE, 'libOnEffectMessage')
		effectMessageProxiesRegistered = true
	end
	setmetatable(s, EffectMessageProxy)
	s._key = key
	libEffectMessageProxies[key] = s
	return s
end

setmetatable(EffectMessageProxy, {__call = function(_, ...) return EffectMessageProxy.New(...) end})

--- Creates a new effect message proxy callback.
-- Registers the specified function1
-- @class EffectMessageProxy
-- @param callback the function to be executed on response
function EffectMessageProxy:OnReceive(callback)
	self = type(self) == 'table' and self or EffectMessageProxy.New(self)
	self._function = callback
end

--- Executes a specific effect message proxy response.
-- Manually triggers the effect message proxy
-- @class EffectMessageProxy
-- @return ambiguous anything the function being called might return
function EffectMessageProxy:Execute(message, x, y, z)
	self = type(self) == 'table' and self or EffectMessageProxy.New(self)
	if (type(self._function) == 'string') then
		self._function = _G[self._function]
	end
	return self:_function(message, x, y, z)
end

--- Returns the effect message proxy key.
-- Returns the key that the effect message proxy was registered under
-- @class EffectMessageProxy
-- @return string the effect message proxy key
function EffectMessageProxy:Key()
	return self._key
end

--- Stops the effect message proxy event.
-- Stops the effect message proxy permanently
-- @class EffectMessageProxy
-- @return void returns nothing
function EffectMessageProxy:Close()
	self = type(self) == 'table' and self or EffectMessageProxy.New(self)
	libDestroyEffectMessageProxy(self._key)
end

--
--      888b    888                   888b     d888                                                       8888888b.                                          .d8888b.  888                            
--      8888b   888                   8888b   d8888                                                       888   Y88b                                        d88P  Y88b 888                            
--      88888b  888                   88888b.d88888                                                       888    888                                        888    888 888                            
--      888Y88b 888 88888b.   .d8888b 888Y88888P888  .d88b.  .d8888b  .d8888b   8888b.   .d88b.   .d88b.  888   d88P 888d888  .d88b.  888  888 888  888     888        888  8888b.  .d8888b  .d8888b  
--      888 Y88b888 888 "88b d88P"    888 Y888P 888 d8P  Y8b 88K      88K          "88b d88P"88b d8P  Y8b 8888888P"  888P"   d88""88b `Y8bd8P' 888  888     888        888     "88b 88K      88K      
--      888  Y88888 888  888 888      888  Y8P  888 88888888 "Y8888b. "Y8888b. .d888888 888  888 88888888 888        888     888  888   X88K   888  888     888    888 888 .d888888 "Y8888b. "Y8888b. 
--      888   Y8888 888 d88P Y88b.    888   "   888 Y8b.          X88      X88 888  888 Y88b 888 Y8b.     888        888     Y88..88P .d8""8b. Y88b 888     Y88b  d88P 888 888  888      X88      X88 
--      888    Y888 88888P"   "Y8888P 888       888  "Y8888   88888P'  88888P' "Y888888  "Y88888  "Y8888  888        888      "Y88P"  888  888  "Y88888      "Y8888P"  888 "Y888888  88888P'  88888P' 
--                  888                                                                      888                                                    888                                               
--                  888                                                                 Y8b d88P                                               Y8b d88P                                               
--                  888                                                                  "Y88P"                                                 "Y88P"
--

NpcMessageProxy = {}
libNpcMessageProxies = {}
NpcMessageProxy.__index = NpcMessageProxy
npcMessageProxiesRegistered = false

--- This function should not be used by the regular user and is therefore not explained
function libOnNpcMessage(...)
	local params = {...}
	for begin = 1, #params, 4 do
		local speaker = params[begin]
		local text = params[begin + 1]  
		for key, proxy in pairs(libNpcMessageProxies) do
			proxy:Execute(speaker, text)
		end
	end
end
--- This function should not be used by the regular user and is therefore not explained
function libDestroyNpcMessageProxy(key)
	local signal = libNpcMessageProxies[key]
	if (signal) then
		libNpcMessageProxies[key] = nil
	end
end

--- Creates a new npc message proxy.
-- Registers the npc message proxy callback
-- @class NpcMessageProxy
-- @param key the key to identify the proxy as
function NpcMessageProxy.New(key)
	if (libNpcMessageProxies[key]) then
		return libNpcMessageProxies[key]
	end
	local s = {}
	if (not npcMessageProxiesRegistered) then
		registerNativeEventListener(NPC_MESSAGE, 'libOnNpcMessage')
		npcMessageProxiesRegistered = true
	end
	setmetatable(s, NpcMessageProxy)
	s._key = key
	libNpcMessageProxies[key] = s
	return s
end

setmetatable(NpcMessageProxy, {__call = function(_, ...) return NpcMessageProxy.New(...) end})

--- Creates a new npc message proxy callback.
-- Registers the specified function1
-- @class NpcMessageProxy
-- @param callback the function to be executed on response
function NpcMessageProxy:OnReceive(callback)
	self = type(self) == 'table' and self or NpcMessageProxy.New(self)
	self._function = callback
end

--- Executes a specific npc message proxy response.
-- Manually triggers the npc message proxy
-- @class NpcMessageProxy
-- @return ambiguous anything the function being called might return
function NpcMessageProxy:Execute(speaker, level, text)
	self = type(self) == 'table' and self or NpcMessageProxy.New(self)
	if (type(self._function) == 'string') then
		self._function = _G[self._function]
	end
	return self:_function(speaker, level, text)
end

--- Returns the npc message proxy key.
-- Returns the key that the npc message proxy was registered under
-- @class NpcMessageProxy
-- @return string the npc message proxy key
function NpcMessageProxy:Key()
	return self._key
end

--- Stops the npc message proxy event.
-- Stops the npc message proxy permanently
-- @class NpcMessageProxy
-- @return void returns nothing
function NpcMessageProxy:Close()
	self = type(self) == 'table' and self or NpcMessageProxy.New(self)
	libDestroyNpcMessageProxy(self._key)
end


--
--  .d8888b.                                     d8b      88888888888                888    888b     d888                                                       8888888b.                                    
-- d88P  Y88b                                    Y8P          888                    888    8888b   d8888                                                       888   Y88b                                   
-- 888    888                                                 888                    888    88888b.d88888                                                       888    888                                   
-- 888         .d88b.  88888b.   .d88b.  888d888 888  .d8888b 888   .d88b.  888  888 888888 888Y88888P888  .d88b.  .d8888b  .d8888b   8888b.   .d88b.   .d88b.  888   d88P 888d888 .d88b.  888  888 888  888 
-- 888  88888 d8P  Y8b 888 "88b d8P  Y8b 888P"   888 d88P"    888  d8P  Y8b `Y8bd8P' 888    888 Y888P 888 d8P  Y8b 88K      88K          "88b d88P"88b d8P  Y8b 8888888P"  888P"  d88""88b `Y8bd8P' 888  888 
-- 888    888 88888888 888  888 88888888 888     888 888      888  88888888   X88K   888    888  Y8P  888 88888888 "Y8888b. "Y8888b. .d888888 888  888 88888888 888        888    888  888   X88K   888  888 
-- Y88b  d88P Y8b.     888  888 Y8b.     888     888 Y88b.    888  Y8b.     .d8""8b. Y88b.  888   "   888 Y8b.          X88      X88 888  888 Y88b 888 Y8b.     888        888    Y88..88P .d8""8b. Y88b 888 
--  "Y8888P88  "Y8888  888  888  "Y8888  888     888  "Y8888P 888   "Y8888  888  888  "Y888 888       888  "Y8888   88888P'  88888P' "Y888888  "Y88888  "Y8888  888        888     "Y88P"  888  888  "Y88888 
--                                                                                                                                                 888                                                   888 
--                                                                                                                                            Y8b d88P                                              Y8b d88P                                                                                                                                                                                                                                                                                                                                                                                                                                       

GenericTextMessageProxy = {}
libGenericTextMessageProxies = {}
GenericTextMessageProxy.__index = GenericTextMessageProxy
genericTextMessageProxiesRegistered = false

--- This function should not be used by the regular user and is therefore not explained
function libOnGenericTextMessage(...)
	local params = {...}
	for _, message in ipairs(params) do
		for key, proxy in pairs(libGenericTextMessageProxies) do
			proxy:Execute(message)
		end
	end
end

--- This function should not be used by the regular user and is therefore not explained
function libDestroyGenericTextMessageProxy(key)
	local signal = libGenericTextMessageProxies[key]
	if (signal) then
		libGenericTextMessageProxies[key] = nil
	end
end

--- Creates a new battle message proxy.
-- Registers the battle message proxy callback
-- @class GenericTextMessageProxy
-- @param key the key to identify the proxy as
function GenericTextMessageProxy.New(key)
	if (libGenericTextMessageProxies[key]) then
		return libGenericTextMessageProxies[key]
	end
	local s = {}
	if (not genericTextMessageProxiesRegistered) then
		registerNativeEventListener(GENERIC_TEXT_MESSAGE, 'libOnGenericTextMessage')
		genericTextMessageProxiesRegistered = true
	end
	setmetatable(s, GenericTextMessageProxy)
	s._key = key
	libGenericTextMessageProxies[key] = s
	return s
end

setmetatable(GenericTextMessageProxy, {__call = function(_, ...) return GenericTextMessageProxy.New(...) end})

--- Creates a new battle message proxy callback.
-- Registers the specified function1
-- @class GenericTextMessageProxy
-- @param callback the function to be executed on response
function GenericTextMessageProxy:OnReceive(callback)
	self = type(self) == 'table' and self or GenericTextMessageProxy.New(self)
	self._function = callback
end

--- Executes a specific battle message proxy response.
-- Manually triggers the battle message proxy
-- @class GenericTextMessageProxy
-- @return ambiguous anything the function being called might return
function GenericTextMessageProxy:Execute(message)
	self = type(self) == 'table' and self or GenericTextMessageProxy.New(self)
	if (type(self._function) == 'string') then
		self._function = _G[self._function]
	end
	return self:_function(message)
end

--- Returns the battle message proxy key.
-- Returns the key that the battle message proxy was registered under
-- @class GenericTextMessageProxy
-- @return string the battle message proxy key
function GenericTextMessageProxy:Key()
	return self._key
end

--- Stops the battle message proxy event.
-- Stops the battle message proxy permanently
-- @class GenericTextMessageProxy
-- @return void returns nothing
function GenericTextMessageProxy:Close()
	self = type(self) == 'table' and self or GenericTextMessageProxy.New(self)
	libDestroyGenericTextMessageProxy(self._key)
end



-- 
--  .d8888b.                    888             d8b                            .d88888b.                             8888888b.                                    
-- d88P  Y88b                   888             Y8P                           d88P" "Y88b                            888   Y88b                                   
-- 888    888                   888                                           888     888                            888    888                                   
-- 888         .d88b.  88888b.  888888  8888b.  888 88888b.   .d88b.  888d888 888     888 88888b.   .d88b.  88888b.  888   d88P 888d888 .d88b.  888  888 888  888 
-- 888        d88""88b 888 "88b 888        "88b 888 888 "88b d8P  Y8b 888P"   888     888 888 "88b d8P  Y8b 888 "88b 8888888P"  888P"  d88""88b `Y8bd8P' 888  888 
-- 888    888 888  888 888  888 888    .d888888 888 888  888 88888888 888     888     888 888  888 88888888 888  888 888        888    888  888   X88K   888  888 
-- Y88b  d88P Y88..88P 888  888 Y88b.  888  888 888 888  888 Y8b.     888     Y88b. .d88P 888 d88P Y8b.     888  888 888        888    Y88..88P .d8""8b. Y88b 888 
--  "Y8888P"   "Y88P"  888  888  "Y888 "Y888888 888 888  888  "Y8888  888      "Y88888P"  88888P"   "Y8888  888  888 888        888     "Y88P"  888  888  "Y88888 
--                                                                                        888                                                                 888 
--                                                                                        888                                                            Y8b d88P 
--                                                                                        888                                                             "Y88P"  


ContainerOpenProxy = {}
libContainerOpenProxies = {}
ContainerOpenProxy.__index = ContainerOpenProxy
containerOpenProxiesRegistered = false

--- This function should not be used by the regular user and is therefore not explained
function libOnContainerOpen(index, title, id)
	for key, proxy in pairs(libContainerOpenProxies) do
		proxy:Execute(tonumber(index), title, tonumber(id))
	end
end

--- This function should not be used by the regular user and is therefore not explained
function libDestroyContainerOpenProxy(key)
	local signal = libContainerOpenProxies[key]
	if (signal) then
		libContainerOpenProxies[key] = nil
	end
end

--- Creates a new battle message proxy.
-- Registers the battle message proxy callback
-- @class ContainerOpenProxy
-- @param key the key to identify the proxy as
function ContainerOpenProxy.New(key)
	if (libContainerOpenProxies[key]) then
		return libContainerOpenProxies[key]
	end
	local s = {}
	if (not containerOpenProxiesRegistered) then
		registerNativeEventListener(CONTAINER_OPEN, 'libOnContainerOpen')
		containerOpenProxiesRegistered = true
	end
	setmetatable(s, ContainerOpenProxy)
	s._key = key
	libContainerOpenProxies[key] = s
	return s
end

setmetatable(ContainerOpenProxy, {__call = function(_, ...) return ContainerOpenProxy.New(...) end})

--- Creates a new battle message proxy callback.
-- Registers the specified function1
-- @class ContainerOpenProxy
-- @param callback the function to be executed on response
function ContainerOpenProxy:OnReceive(callback)
	self = type(self) == 'table' and self or ContainerOpenProxy.New(self)
	self._function = callback
end

--- Executes a specific battle message proxy response.
-- Manually triggers the battle message proxy
-- @class ContainerOpenProxy
-- @return ambiguous anything the function being called might return
function ContainerOpenProxy:Execute(index, title, id)
	self = type(self) == 'table' and self or ContainerOpenProxy.New(self)
	if (type(self._function) == 'string') then
		self._function = _G[self._function]
	end
	return self:_function(index, title, id)
end

--- Returns the battle message proxy key.
-- Returns the key that the battle message proxy was registered under
-- @class ContainerOpenProxy
-- @return string the battle message proxy key
function ContainerOpenProxy:Key()
	return self._key
end

--- Stops the battle message proxy event.
-- Stops the battle message proxy permanently
-- @class ContainerOpenProxy
-- @return void returns nothing
function ContainerOpenProxy:Close()
	self = type(self) == 'table' and self or ContainerOpenProxy.New(self)
	libDestroyContainerOpenProxy(self._key)
end



--
--      888b     d888 d8b                            888 888                                                       
--      8888b   d8888 Y8P                            888 888                                                       
--      88888b.d88888                                888 888                                                       
--      888Y88888P888 888 .d8888b   .d8888b  .d88b.  888 888  8888b.  88888b.   .d88b.   .d88b.  888  888 .d8888b  
--      888 Y888P 888 888 88K      d88P"    d8P  Y8b 888 888     "88b 888 "88b d8P  Y8b d88""88b 888  888 88K      
--      888  Y8P  888 888 "Y8888b. 888      88888888 888 888 .d888888 888  888 88888888 888  888 888  888 "Y8888b. 
--      888   "   888 888      X88 Y88b.    Y8b.     888 888 888  888 888  888 Y8b.     Y88..88P Y88b 888      X88 
--      888       888 888  88888P'  "Y8888P  "Y8888  888 888 "Y888888 888  888  "Y8888   "Y88P"   "Y88888  88888P'
--

function table.find(tbl, value, careful)
	local sensitive = (type(careful) ~= "boolean" or not careful) and false or true
	if (not sensitive and type(value) == "string") then
		for i, v in pairs(tbl) do
			if (type(v) == "string") then
				if (v:lower() == value:lower()) then
					return i
				end
			end
		end
		return false
	end
	for i, v in pairs(tbl) do
		if (v == value) then
			return i
		end
	end
	return false
end

function table.contains(t, value, index)
	for n = 1, #t do
		local c = t[n]
		if (type(c) == 'table') and (type(value) ~= 'table') and (index) then
			if (c[index] == value) then
				return c, n
			end
		elseif (c == value) then
			return c, n
		end
	end
	return false
end

function table.serialize(x, recur)
	local t = type(x)
	recur = recur or {}
	if (t == nil) then
		return "nil"
	elseif (t == "string") then
		return string.format("%q", x)
	elseif (t == "number") then
		return tostring(x)
	elseif (t == "boolean") then
		return x and "true" or "false"
	elseif (getmetatable(x)) then
		print("Can not serialize a table that has a metatable associated with it.")
	elseif (t == "function") then
		return tostring(x)
	elseif (t == "table") then
		if (table.find(recur, x)) then
			print("Can not serialize recursive tables.")
		end
		table.insert(recur, x)
		local s = "{"
		for k, v in pairs(x) do
			s = s .. "[" .. table.serialize(k, recur) .. "]" .. " = " .. table.serialize(v, recur) .. ", "
		end
		return s:sub(0, s:len() - 2) .. "}"
	end
	print("Can not serialize value of type '" .. t .. "'.")
end

function table.unserialize(str)
	return loadstring("return " .. str)()
end

function string:titlecase()
	return self:gsub("(%a)([%w_']*)", function(first, rest) return first:upper()..rest:lower() end)
end

function string:split(s)
	local s, tbl = s or " ", {}
	self:gsub(string.format("([^%s]+)", s), function(c) tbl[#tbl + 1] = c end)
	return tbl
end

function string:trim()
  return self:gsub("^%s*(.-)%s*$", "%1")
end

function string:wordcount()
	local n = 0
	self:gsub("(%w+)", function() n = n + 1 end)
	return n
end

--
--       .d8888b.                                           888             
--      d88P  Y88b                                          888             
--      888    888                                          888             
--      888         .d88b.  88888b.d88b.  88888b.   8888b.  888888 .d8888b  
--      888        d88""88b 888 "888 "88b 888 "88b     "88b 888    88K      
--      888    888 888  888 888  888  888 888  888 .d888888 888    "Y8888b. 
--      Y88b  d88P Y88..88P 888  888  888 888 d88P 888  888 Y88b.       X88 
--       "Y8888P"   "Y88P"  888  888  888 88888P"  "Y888888  "Y888  88888P' 
--                                        888                               
--                                        888                               
--                                        888
--
--       (these are still useable but may be deprecated in future releases)
--

printf = print

error = print

Container.GetByName = Container.New

Container.GetFromIndex = Container.New

Container.GetIndexes = Container.GetAll

getActiveRingID = Item.GetRingActiveID

Self.OpenDoor = Self.UseDoor

function Self.CloseDoor(x, y, z)
	return Self.UseDoor(x, y, z, true)
end

table.isStrIn = table.contains

function getTargetsInArea(pos, radius, aggressiveness) --this function will be deprecated completely in the near future, do not use
	local n = #Self.GetTargets(radius)
	local safe = Self.isAreaPvPSafe(radius+2, true, true) or aggressiveness == 4
	return safe and n or 0
end

Self.CutGrass = Self.CutPlant
Self.LookPos = Self.LookPosition

-- throw away first 2 prng results
math.random()
math.random()


--      8888888 8888888b.   .d8888b.        .d8888b.  888                                              
--        888   888   Y88b d88P  Y88b      d88P  Y88b 888                                              
--        888   888    888 888    888      888    888 888                                              
--        888   888   d88P 888             888        888  8888b.  .d8888b  .d8888b   .d88b.  .d8888b  
--        888   8888888P"  888             888        888     "88b 88K      88K      d8P  Y8b 88K      
--        888   888        888    888      888    888 888 .d888888 "Y8888b. "Y8888b. 88888888 "Y8888b. 
--        888   888        Y88b  d88P      Y88b  d88P 888 888  888      X88      X88 Y8b.          X88 
--      8888888 888         "Y8888P"        "Y8888P"  888 "Y888888  88888P'  88888P'  "Y8888   88888P' 
                                                                                               
                                                                                               
                                                    

IpcPublisherSocket = {}
IpcPublisherSocket.__index = IpcPublisherSocket
libIpcPublisherSockets = {}

--- Creates a new ipc publisher socket.
-- @class IpcPublisherSocket
-- @param key the key used to reference the socket
-- @param port the port the socket will bind to
function IpcPublisherSocket.New(key, port)
	if (libIpcPublisherSockets[key]) then
		return libIpcPublisherSockets[key]
	end
	local s = {}
	setmetatable(s, IpcPublisherSocket)
	s._key = key
	s._socket = IpcBind(port, SOCKET_PUB)
	libIpcPublisherSockets[key] = s
	return s
end

setmetatable(IpcPublisherSocket, {__call = function(_, ...) return IpcPublisherSocket.New(...) end})

--- Closes the ipc socket.
-- @class IpcPublisherSocket
function IpcPublisherSocket:Close()
	self = type(self) == 'table' and self or IpcPublisherSocket.New(self)
	IpcDisconnect(self._socket)
	libIpcPublisherSockets[self._key] = nil
	return true
end

--- Publishes a message to all subscribers of a topic.
-- @class IpcPublisherSocket
-- @param topic the topic of the message
-- @param message the message
function IpcPublisherSocket:PublishMessage(topic, message)
	self = type(self) == 'table' and self or IpcPublisherSocket.New(self)
	return (IpcSendTopic(self._socket, topic, message) == 1)
end



IpcSubscriberSocket = {}
IpcSubscriberSocket.__index = IpcSubscriberSocket
libIpcSubscriberSockets = {}

--- Creates a new ipc subscriber socket.
-- @class IpcSubscriberSocket
-- @param key the key used to reference the socket
-- @param port the port the socket will connect to
function IpcSubscriberSocket.New(key, port)
	if (libIpcSubscriberSockets[key]) then
		return libIpcSubscriberSockets[key]
	end
	local s = {}
	setmetatable(s, IpcSubscriberSocket)
	s._key = key
	s._socket = IpcConnect(port, SOCKET_SUB)
	libIpcSubscriberSockets[key] = s
	return s
end

setmetatable(IpcSubscriberSocket, {__call = function(_, ...) return IpcSubscriberSocket.New(...) end})

--- Closes the ipc socket.
-- @class IpcSubscriberSocket
function IpcSubscriberSocket:Close()
	self = type(self) == 'table' and self or IpcSubscriberSocket.New(self)
	IpcDisconnect(self._socket)
	libIpcSubscriberSockets[self._key] = nil
	return true
end

--- Subscribes to a new topic.
-- @class IpcSubscriberSocket
-- @topic the topic to subscribe to
function IpcSubscriberSocket:AddTopic(topic)
	self = type(self) == 'table' and self or IpcSubscriberSocket.New(self)
	return (IpcSubscribe(self._socket, topic) == 1)
end

--- Receives the next message in the queue.
-- @class IpcSubscriberSocket
function IpcSubscriberSocket:Recv()
	self = type(self) == 'table' and self or IpcSubscriberSocket.New(self)
	if (IpcPoll(self._socket) == 0) then return false end
	local topic = IpcRecv(self._socket, 0)
	local message = IpcRecv(self._socket, 1)
	return true, topic, message
end



IpcResponderSocket = {}
IpcResponderSocket.__index = IpcResponderSocket
libIpcResponderSockets = {}

--- Creates a new ipc responder socket.
-- @class IpcResponderSocket
-- @param key the key used to reference the socket
-- @param port the port the socket will bind to
function IpcResponderSocket.New(key, port)
	if (libIpcResponderSockets[key]) then
		return libIpcResponderSockets[key]
	end
	local s = {}
	setmetatable(s, IpcResponderSocket)
	s._key = key
	s._socket = IpcBind(port, SOCKET_REP)
	libIpcResponderSockets[key] = s
	return s
end

setmetatable(IpcResponderSocket, {__call = function(_, ...) return IpcResponderSocket.New(...) end})

--- Closes the ipc socket.
-- @class IpcResponderSocket
function IpcResponderSocket:Close()
	self = type(self) == 'table' and self or IpcResponderSocket.New(self)
	IpcDisconnect(self._socket)
	libIpcResponderSockets[self._key] = nil
	return true
end

--- Gets the next request in the queue.
-- @class IpcPublisherSocket
function IpcResponderSocket:GetRequest()
	self = type(self) == 'table' and self or IpcResponderSocket.New(self)
	if (IpcPoll(self._socket) == 0) then return false end
	local request = IpcRecv(self._socket, 0)
	if (request == false) then return false end
	return true, request
end

--- Gets the next request in the queue.
-- @class IpcPublisherSocket
function IpcResponderSocket:SendResponse(message)
	self = type(self) == 'table' and self or IpcResponderSocket.New(self)
	return (IpcSend(self._socket, message) == 1)
end



IpcRequestorSocket = {}
IpcRequestorSocket.__index = IpcRequestorSocket
libIpcRequestorSockets = {}

--- Creates a new ipc requestor socket.
-- @class IpcRequestorSocket
-- @param key the key used to reference the socket
-- @param port the port the socket will connect to
function IpcRequestorSocket.New(key, port)
	if (libIpcRequestorSockets[key]) then
		return libIpcRequestorSockets[key]
	end
	local s = {}
	setmetatable(s, IpcRequestorSocket)
	s._key = key
	s._socket = IpcConnect(port, SOCKET_REQ)
	libIpcRequestorSockets[key] = s
	return s
end

setmetatable(IpcRequestorSocket, {__call = function(_, ...) return IpcRequestorSocket.New(...) end})

--- Closes the ipc socket.
-- @class IpcRequestorSocket
function IpcRequestorSocket:Close()
	self = type(self) == 'table' and self or IpcRequestorSocket.New(self)
	IpcDisconnect(self._socket)
	libIpcRequestorSockets[self._key] = nil
	return true
end

--- Gets the next request in the queue.
-- @class IpcPublisherSocket
function IpcRequestorSocket:GetResponse()
	self = type(self) == 'table' and self or IpcRequestorSocket.New(self)
	local response = IpcRecv(self._socket, 1)
	return response
end

--- Gets the next request in the queue.
-- @class IpcPublisherSocket
function IpcRequestorSocket:SendRequest(message)
	self = type(self) == 'table' and self or IpcRequestorSocket.New(self)
	return (IpcSend(self._socket, message) == 1)
end


--      
--      888    888          888    888                                       .d8888b.  888                            
--      888    888          888    888                                      d88P  Y88b 888                            
--      888    888          888    888                                      888    888 888                            
--      8888888888  .d88b.  888888 888  888  .d88b.  888  888 .d8888b       888        888  8888b.  .d8888b  .d8888b  
--      888    888 d88""88b 888    888 .88P d8P  Y8b 888  888 88K           888        888     "88b 88K      88K      
--      888    888 888  888 888    888888K  88888888 888  888 "Y8888b.      888    888 888 .d888888 "Y8888b. "Y8888b. 
--      888    888 Y88..88P Y88b.  888 "88b Y8b.     Y88b 888      X88      Y88b  d88P 888 888  888      X88      X88 
--      888    888  "Y88P"   "Y888 888  888  "Y8888   "Y88888  88888P'       "Y8888P"  888 "Y888888  88888P'  88888P' 
--                                                        888                                                         
--                                                   Y8b d88P                                                         
--                                                   "Y88P"        
--

Hotkeys = {}

Hotkeys.F1 = 0x70
Hotkeys.F2 = 0x71
Hotkeys.F3 = 0x72
Hotkeys.F4 = 0x73
Hotkeys.F5 = 0x74
Hotkeys.F6 = 0x75
Hotkeys.F7 = 0x76
Hotkeys.F8 = 0x77
Hotkeys.F9 = 0x78
Hotkeys.F10 = 0x79
Hotkeys.F11 = 0x7A
Hotkeys.F12 = 0x7B
Hotkeys.PAGEUP = 0x21
Hotkeys.PAGEDOWN = 0x22
Hotkeys.INSERT = 0x2D
Hotkeys.DELETE = 0x2E
Hotkeys.END = 0x23
Hotkeys.HOME = 0x24

Hotkeys.__registeredPressHandler = false
Hotkeys.__registeredReleaseHandler = false
Hotkeys.__pressHandlers = {}
Hotkeys.__releaseHandlers = {}

function __internalHotkeyPressHandler(_key, control, shift)
	local key = tonumber(_key)
	for _, f in pairs(Hotkeys.__pressHandlers) do f(key, control == "1", shift == "1") end
end
function __internalHotkeyReleaseHandler(_key, control, shift)
	local key = tonumber(_key)
	for _, f in pairs(Hotkeys.__releaseHandlers) do f(key, control == "1", shift == "1") end
end

Hotkeys.Register = function(key)
	return (RegisterHotkey(key) == 1)
end

Hotkeys.Unregister = function(key)
	return (UnRegisterHotkey(key) == 1)
end

Hotkeys.AddPressHandler = function(handler)
	if (not Hotkeys.__registeredPressHandler) then
		Hotkeys.__registeredPressHandler = true
		registerEventListener(HOTKEY_PRESS, "__internalHotkeyPressHandler")
	end
	Hotkeys.__pressHandlers[#Hotkeys.__pressHandlers + 1] = handler
end

Hotkeys.AddReleaseHandler = function(handler)
	if (not Hotkeys.__registeredReleaseHandler) then
		Hotkeys.__registeredReleaseHandler = true
		registerEventListener(HOTKEY_RELEASE, "__internalHotkeyReleaseHandler")
	end
	Hotkeys.__releaseHandlers[#Hotkeys.__releaseHandlers + 1] = handler
end