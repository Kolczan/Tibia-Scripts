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

VK_MULTIPLY = 0x6A
VK_ADD = 0x6B
VK_SUBTRACT = 0x6D
VK_DIVIDE = 0x6F
VK_F1 = 0x70
VK_F2 = 0x71
VK_F3 = 0x72
VK_F4 = 0x73
VK_F5 = 0x74
VK_F6 = 0x75
VK_F7 = 0x76
VK_F8 = 0x77
VK_F9 = 0x78
VK_F10 = 0x79
VK_F11 = 0x7A
VK_F12 = 0x7B
VK_F13 = 0x7C
VK_F14 = 0x7D
VK_F15 = 0x7E
VK_F16 = 0x7F
VK_F17 = 0x80
VK_F18 = 0x81
VK_F19 = 0x82
VK_F20 = 0x83
VK_F21 = 0x84
VK_F22 = 0x85
VK_F23 = 0x86
VK_F24 = 0x87
VK_PRIOR = 0x21
VK_NEXT = 0x22
VK_INSERT = 0x2D
VK_DELETE = 0x2E
VK_END = 0x23
VK_HOME = 0x24

SKULL_NONE = 0
SKULL_WHITE = 1
SKULL_RED = 4
SKULL_ORANGE = 2
SKULL_YELLOW = 3
SKULL_BLACK = 5

PARTY_YELLOW = 1
PARTY_YELLOW_SHAREDEXP = 2
PARTY_YELLOW_NOSHAREDEXP_BLINK = 3
PARTY_YELLOW_NOSHAREDEXP = 4
PARTY_BLUE = 1
PARTY_BLUE_SHAREDEXP = 2
PARTY_BLUE_NOSHAREDEXP_BLINK = 3
PARTY_BLUE_NOSHAREDEXP = 4
PARTY_WHITEBLUE = 5
PARTY_WHITEYELLOW = 6

WAR_ALLY = 1
WAR_ENEMY = 2
WAR_INWAR = 3

PVP_ALLY = WAR_ALLY
PVP_ENEMY = WAR_ENEMY
PVP_INWAR = WAR_INWAR
PVP_GUILDMATE = 4
PVP_HASGUILD = 5

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


math.randomseed(os.time())


function registerEventListener(eventType, functionName)
    if (eventType == TIMER_TICK) then
        return Module.New(functionName, functionName)
    end
    return registerNativeEventListener(eventType, functionName)
end

function eq(a, b)
	return a == b
end
function neq(a, b)
	return a ~= b
end
function gt(a, b)
	return a > b
end
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
-- Used to delay the script environment for a specified time
-- @class Global
-- @param a the time to sleep for
-- @param b optional; will cause function to randomly choose a number between a and b
-- @return void returns nothing
function wait(a, b)
    if not b then sleep(a) else sleep(math.random(a, b)) end
end
function isPositionAdjacent(pos1, pos2)
    return (math.abs(pos1.x - pos2.x) <= 1 and math.abs(pos1.y - pos2.y) <= 1 and pos1.z == pos2.z)
end
function getDistanceBetween(pos1, pos2)
    return math.max(math.abs(pos1.x - pos2.x), math.abs(pos1.y - pos2.y))
end
function getPositionFromDirection(pos, dir, len)
    local n = len or 1
    if(dir == NORTH)then
        pos.y = pos.y - n
    elseif(dir == SOUTH)then
        pos.y = pos.y + n
    elseif(dir == WEST)then
        pos.x = pos.x - n
    elseif(dir == EAST)then
        pos.x = pos.x + n
    elseif(dir == NORTHWEST)then
        pos.y = pos.y - n
        pos.x = pos.x - n
    elseif(dir == NORTHEAST)then
        pos.y = pos.y - n
        pos.x = pos.x + n
    elseif(dir == SOUTHWEST)then
        pos.y = pos.y + n
        pos.x = pos.x - n
    elseif(dir == SOUTHEAST)then
        pos.y = pos.y + n
        pos.x = pos.x + n
    end
    return pos
end
--- Toggle all features.
-- Enables or disables walker looter and targeter
-- @class Global
-- @param status true enables false disables
-- @return void returns nothing
function setBotEnabled(status)
    setWalkerEnabled(status)
    setLooterEnabled(status)
    setTargetingEnabled(status)
end

Module = {}
libModules = {}
Module.__index = Module
modulesRegistered = false

function libOnTimer()
	if(#libModules > 0)then
	    for i, m in ipairs(libModules) do
	    	if(m._tempDelay < (os.clock()*1000) and m._tempDelay > 0 and not m._active)then
	    		m.delayTime = 0
	    		m._active = true
	    	end
	        if(m._active)then
	            m:Execute()
	        end
	    end
	end
end
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
            if(mod:Name() == name)then
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
	self = type(self)=='table' and self or Module.New(self)
	
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
	self = type(self)=='table' and self or Module.New(self)
    return self._active
end
--- Starts the module.
-- Sets the module to active to start executing the function
-- @class Module
-- @return void returns nothing
function Module:Start()
	self = type(self)=='table' and self or Module.New(self)
    self._active = true
end
--- Delays the module.
-- Pauses the module for a specific amount of time
-- @class Module
-- @param delayTime amount of time in milliseconds to delay the module
-- @return void returns nothing
function Module:Delay(delayTime)
	self = type(self)=='table' and self or Module.New(self)
	self._tempDelay = (os.clock() * 1000) + delayTime
    self._active = false
end
--- Stops the module.
-- Stops the module permanently
-- @class Module
-- @return void returns nothing
function Module:Stop()
	self = type(self)=='table' and self or Module.New(self)
    self._active = false
end

Client = {}
--- Hide equipment window.
-- Minimizes the equipment window dialog windows must be closed
-- @class Client
-- @return void returns nothing
Client.HideEquipment = minimizeEquipment
--- Show equipment window.
-- Maximizes the equipment window dialog windows must be closed
-- @class Client
-- @return void returns nothing
Client.ShowEquipment = maximizeEquipment


HUD = {}
HUD.__index = HUD

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
HUD.CreateTextDisplay = HUD.New
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
-- Adjust an existing display's text
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
-- Displays an red message in the channel
-- @class Channel
-- @param sender the text to show where character's names are displayed
-- @param text the message to display
-- @return void returns nothing
function Channel:SendRedMessage(sender, text)
    luaSendChannelMessage(self._id, CHANNEL_RED, sender, text)
end
--- Sends yellow message.
-- Displays an yellow message in the channel
-- @class Channel
-- @param sender the text to show where character's names are displayed
-- @param text the message to display
-- @return void returns nothing
function Channel:SendYellowMessage(sender, text)
    luaSendChannelMessage(self._id, CHANNEL_YELLOW, sender, text)
end
function Channel:SpeakCallback(message)
    if (self._speakCallback == nil) then return 0 end
    return self._speakCallback(self, message)
end
function Channel:CloseCallback()
    if (self._closeCallback == nil) then return 0 end
    return self._closeCallback(self)
end

function libOnCustomChannelClose(channel)
    for i, c in ipairs(libChannels) do
        if (c:ID() == math.floor(channel)) then
            c:CloseCallback()
            table.remove(libChannels, i)
            break
        end
    end
end
function libOnCustomChannelSpeak(channel, message)
    for i, c in ipairs(libChannels) do
        if (c:ID() == math.floor(channel)) then
            c:SpeakCallback(message)
            break
        end
    end
end


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
Creature.GetByName = Creature.New
Creature.GetByID = Creature.New
Creature.GetFromIndex = Creature.New

-- iterator helper
function Creature.iParamHelper(...)
	local params = {...}
	local distance = 10
	local sort = nil
	local checks = {}
	
	if (type(params[1]) == "table") then -- we have a table of checks
		function FindFunction(name)
			if (name == "distance" or name == "dist") then return Creature.DistanceFromSelf end
			
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
function Creature.iCheckHelper(checks, creature)
	for _, check in ipairs(checks) do
		if (not check[2][1](check[1](creature), check[2][2])) then
			return false
		end
	end
	return true
end
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

    if (sort) then table.sort(spectators, sort) end
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
	self = type(self)=='table' and self or Creature.New(self)
    return (self._id > 0 and self._listindex <= CREATURES_HIGH and self._listindex >= CREATURES_LOW)
end
--- Get creature name.
-- Returns the creature object's name
-- @class Creature
-- @return string creature name
function Creature:Name()
	self = type(self)=='table' and self or Creature.New(self)
    return self._name
end
--- Get creature id.
-- Returns the creature object's creature id
-- @class Creature
-- @return number creature id
function Creature:ID()
	self = type(self)=='table' and self or Creature.New(self)
    return self._id
end
--- Get creature index.
-- Returns the creature object's creature index
-- @class Creature
-- @return number creature index
function Creature:Index()
	self = type(self)=='table' and self or Creature.New(self)
    return self._listindex
end
--- Get creature look direction.
-- Returns the creature's look direction, directions defined in constants
-- @class Creature
-- @return number creature look direction
function Creature:LookDirection()
	self = type(self)=='table' and self or Creature.New(self)
    return getCreatureLookDirection(self._listindex)
end
--- Get creature speed.
-- Returns the creature's speed
-- @class Creature
-- @return number creature speed
function Creature:Speed()
	self = type(self)=='table' and self or Creature.New(self)
    return getCreatureSpeed(self._listindex)
end
--- Get creature outfit.
-- Returns the creature's outfit in a table
-- @class Creature
-- @return table creature looktypes
function Creature:Outfit()
	self = type(self)=='table' and self or Creature.New(self)
    return getCreatureOutfit(self._listindex)
end
--- Get creature health percent.
-- Returns the creature's health percent
-- @class Creature
-- @return number creature health percent
function Creature:HealthPercent()
	self = type(self)=='table' and self or Creature.New(self)
    return getCreatureHealthPercent(self._listindex)
end
--- Is creature you.
-- Returns true if you are the creature object
-- @class Creature
-- @return boolean true or false
function Creature:isSelf()
	self = type(self)=='table' and self or Creature.New(self)
    return self._id == getSelfID()
end
--- Is creature target.
-- Returns true if the creature object is your target
-- @class Creature
-- @return boolean true or false
function Creature:isTarget()
	self = type(self)=='table' and self or Creature.New(self)
    return self._id == getSelfTargetID()
end
--- Is creature followed.
-- Returns true if the creature object is followed by you
-- @class Creature
-- @return boolean true or false
function Creature:isFollowed()
	self = type(self)=='table' and self or Creature.New(self)
    return self._id == getSelfFollowID()
end
--- Is creature player.
-- Returns true if the creature object is a player
-- @class Creature
-- @return boolean true or false
function Creature:isPlayer()
	self = type(self)=='table' and self or Creature.New(self)
    return self:isValid() and isCreaturePlayer(self._listindex) or self:isSelf()
end
--- Is creature NPC.
-- Returns true if the creature object is a NPC
-- @class Creature
-- @return boolean true or false
function Creature:isNpc()
	self = type(self)=='table' and self or Creature.New(self)
    return self:isValid() and isCreatureNpc(self._listindex)
end
--- Is creature monster.
-- Returns true if the creature object is a monster
-- @class Creature
-- @return boolean true or false
function Creature:isMonster()
	self = type(self)=='table' and self or Creature.New(self)
	return self:isValid() and isCreatureMonster(self._listindex) 
end
--- Is creature summon.
-- Returns true if the creature object is a summon
-- @class Creature
-- @return boolean true or false
function Creature:isSummon()
	self = type(self)=='table' and self or Creature.New(self)
	return self:isValid() and isCreatureSummon(self._listindex) 
end
--- Is creature self summon.
-- Returns true if the creature object is a self summon
-- @class Creature
-- @return boolean true or false
function Creature:isSelfSummon()
	self = type(self)=='table' and self or Creature.New(self)
	return self:isValid() and isCreatureSelfSummon(self._listindex) 
end
--- Is creature strange summon.
-- Returns true if the creature object is a strange summon
-- @class Creature
-- @return boolean true or false
function Creature:isStrangeSummon()
	self = type(self)=='table' and self or Creature.New(self)
	return self:isValid() and isCreatureStrangeSummon(self._listindex) 
end
--- Is creature mother.
-- Returns true if the creature object is a mother
-- @class Creature
-- @return boolean true or false
function Creature:isMother()
	self = type(self)=='table' and self or Creature.New(self)
	return self:isValid() and isCreatureMother(self._listindex) 
end

--- Is creature friendly.
-- Returns true if the creature object is a friendly
-- @class Creature
-- @return boolean true or false
function Creature:isFriendly()
	self = type(self)=='table' and self or Creature.New(self)
    return self:isWarAlly() or self:isPartyMember() or self:isSelf()
end
--- Is creature innocent.
-- Returns true if the creature object is innocent
-- @class Creature
-- @return boolean true or false
function Creature:isInnocent()
	self = type(self)=='table' and self or Creature.New(self)
    return (self:Skull() == SKULL_YELLOW or self:Skull() == SKULL_NONE) and not self:isWarEnemy()
end
--- Get creature skull.
-- Returns the creature's skull type
-- @class Creature
-- @return number containing creature's skull type
function Creature:Skull()
	self = type(self)=='table' and self or Creature.New(self)
    return getCreatureSkull(self._listindex)
end
--- Is creature white skulled.
-- Returns true if the creature object is white skulled
-- @class Creature
-- @return boolean true or false
function Creature:isWhiteSkull()
	self = type(self)=='table' and self or Creature.New(self)
    return self:Skull() == SKULL_WHITE
end
--- Is creature red skulled.
-- Returns true if the creature object is red skulled
-- @class Creature
-- @return boolean true or false
function Creature:isRedSkull()
	self = type(self)=='table' and self or Creature.New(self)
    return self:Skull() == SKULL_RED
end
--- Is creature orange skulled.
-- Returns true if the creature object is orange skulled
-- @class Creature
-- @return boolean true or false
function Creature:isOrangeSkull()
	self = type(self)=='table' and self or Creature.New(self)
    return self:Skull() == SKULL_ORANGE
end
--- Is creature yellow skulled.
-- Returns true if the creature object is yellow skulled
-- @class Creature
-- @return boolean true or false
function Creature:isYellowSkull()
	self = type(self)=='table' and self or Creature.New(self)
    return self:Skull() == SKULL_YELLOW
end
--- Is creature black skulled.
-- Returns true if the creature object is black skulled
-- @class Creature
-- @return boolean true or false
function Creature:isBlackSkull()
	self = type(self)=='table' and self or Creature.New(self)
    return self:Skull() == SKULL_BLACK
end
--- Get creature shield.
-- Returns the creature's party shield type
-- @class Creature
-- @return number creature shield type
function Creature:PartyStatus()
	self = type(self)=='table' and self or Creature.New(self)
    return getCreaturePartyStatus(self._listindex)
end
--- Is creature party leader.
-- Returns true if the creature object is the party leader
-- @class Creature
-- @return boolean true or false
function Creature:isPartyLeader()
	self = type(self)=='table' and self or Creature.New(self)
    return (self:PartyStatus() == PARTY_YELLOW or
            self:PartyStatus() == PARTY_YELLOW_SHAREDEXP or
            self:PartyStatus() == PARTY_YELLOW_NOSHAREDEXP_BLINK or
            self:PartyStatus() == PARTY_YELLOW_NOSHAREDEXP)
end
--- Is creature party member.
-- Returns true if the creature object is a party member
-- @class Creature
-- @return boolean true or false
function Creature:isPartyMember()
	self = type(self)=='table' and self or Creature.New(self)
    return (self:isPartyLeader() or
            self:PartyStatus() == PARTY_BLUE or
            self:PartyStatus() == PARTY_BLUE_SHAREDEXP or
            self:PartyStatus() == PARTY_BLUE_NOSHAREDEXP_BLINK or
            self:PartyStatus() == PARTY_BLUE_NOSHAREDEXP)
end
--- Is creature invited to party.
-- Returns true if the creature object is invited to the party
-- @class Creature
-- @return boolean true or false
function Creature:isInvitedToParty()
	self = type(self)=='table' and self or Creature.New(self)
    return self:PartyStatus() == PARTY_WHITEBLUE
end
--- Is creature inviting to party.
-- Returns true if the creature object is inviting to the party
-- @class Creature
-- @return boolean true or false
function Creature:isInvitingToParty()
	self = type(self)=='table' and self or Creature.New(self)
    return self:PartyStatus() == PARTY_WHITEYELLOW
end
--- Is creature sharing exp.
-- Returns true if the creature object is sharing exp in the party
-- @class Creature
-- @return boolean true or false
function Creature:isSharingExp()
	self = type(self)=='table' and self or Creature.New(self)
    return (self:PartyStatus() == PARTY_BLUE_SHAREDEXP or
            self:PartyStatus() == PARTY_YELLOW_SHAREDEXP)
end
--- Get creature pvp icon.
-- Returns the creature's war icon type
-- @class Creature
-- @return number creature war icon type
function Creature:WarIcon()
	self = type(self)=='table' and self or Creature.New(self)
    return getCreaturePvPIcon(self._listindex)
end
function Creature:PvPIcon()
	self = type(self)=='table' and self or Creature.New(self)
    return getCreaturePvPIcon(self._listindex)
end
--- Is creature war enemy.
-- Returns true if the creature object is a war enemy
-- @class Creature
-- @return boolean true or false
function Creature:isWarEnemy()
	self = type(self)=='table' and self or Creature.New(self)
    return self:PvPIcon() == PVP_ENEMY
end
--- Is creature war ally.
-- Returns true if the creature object is a war ally
-- @class Creature
-- @return boolean true or false
function Creature:isWarAlly()
	self = type(self)=='table' and self or Creature.New(self)
    return self:PvPIcon() == PVP_ALLY
end
--- Is creature in war.
-- Returns true if the creature object is in a war
-- @class Creature
-- @return boolean true or false
function Creature:isInWar()
	self = type(self)=='table' and self or Creature.New(self)
    return (self:PvPIcon() == PVP_INWAR or self:isWarAlly() or self:isWarEnemy())
end
--- Get creature position.
-- Returns the creature's position in x,y,z
-- @class Creature
-- @return table x,y,z coordinates of creature
function Creature:Position()
	self = type(self)=='table' and self or Creature.New(self)
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
	self = type(self)=='table' and self or Creature.New(self)
    return isPositionAdjacent(self:Position(), getSelfPosition())
end
--- Is creature on screen.
-- Returns true if the creature position is on your screen
-- @class Creature
-- @param multiFloor optional; skip same floor check if true
-- @return boolean true or false
function Creature:isOnScreen(multiFloor)
	self = type(self)=='table' and self or Creature.New(self)
    local selfloc = getSelfPosition()
    local thisloc = self:Position()
    return (math.abs(selfloc.x - thisloc.x) <= 7 and
            math.abs(selfloc.y - thisloc.y) <= 5
            and (selfloc.z == thisloc.z or multiFloor))
end
--- Is creature alive.
-- Returns true if the creature is alive
-- @class Creature
-- @return boolean true or false
function Creature:isAlive()
	self = type(self)=='table' and self or Creature.New(self)
    return getCreatureHealthPercent(self._listindex) > 0
end
--- Is creature visible.
-- Returns true if the creature is visible
-- @class Creature
-- @return boolean true or false
function Creature:isVisible()
	self = type(self)=='table' and self or Creature.New(self)
    return getCreatureVisible(self._listindex)
end
--- Get creature distance.
-- Returns the creature's sqms from you
-- @class Creature
-- @return number sqms from your distance
function Creature:DistanceFromSelf()
	self = type(self)=='table' and self or Creature.New(self)
    return getDistanceBetween(self:Position(), getSelfPosition())
end
--- Attack creature.
-- Sets the creature as the target
-- @class Creature
-- @return boolean true or false
function Creature:Attack()
	self = type(self)=='table' and self or Creature.New(self)
    local ret = attackCreature(self._id)
    if (ret == 1) then wait(500) end --we need to sleep, we CANT be spamming attack. DO NOT EVER DO IT.
    return ret
end
--- Follow creature.
-- Sets the creature to be followed
-- @class Creature
-- @return boolean true or false
function Creature:Follow()
	self = type(self)=='table' and self or Creature.New(self)
    local ret = followCreature(self._id)
    if (ret == 1) then wait(500) end --we need to sleep, we CANT be spamming follow. DO NOT EVER DO IT.
    return ret
end


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
    while(index < 16)do
        index = index + 1
        if (getContainerOpen(index)) then
            last = Container.New(index)
        end
    end
    return last
end
--- Get open containers.
-- Returns the open containers in a table
-- @class Container
-- @return table container objects
function Container.GetAll()
    local index = -1
    local indexes = {}
    while (index < 16) do
        index = index + 1
        if(getContainerOpen(index))then
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
    while(not found and index < 16)do
        index = index + 1
        found = getContainerOpen(index)
    end
    if(not found)then
        index = -1
    end
    return Container.New(index)
end
--- Creates a container object from the next relative container.
-- Creates a container object from the next open container relative to the current container object
-- @class Container
-- @return object Container
function Container:GetNext()
	self = type(self)=='table' and self or Container.New(self)
    return Container.GetNextOpen(self._index)
end
--- Get container's index.
-- Returns the container's index number
-- @class Container
-- @return number container index
function Container:Index()
	self = type(self)=='table' and self or Container.New(self)
    return self._index
end
--- Get container's id.
-- Returns the container's itemid
-- @class Container
-- @return number container itemid
function Container:ID()
	self = type(self)=='table' and self or Container.New(self)
    return getContainerID(self._index)
end
--- Get container's name.
-- Returns the container's name
-- @class Container
-- @return string container name
function Container:Name()
	self = type(self)=='table' and self or Container.New(self)
    return getContainerName(self._index)
end
--- Get container's item count.
-- Returns the amount of occupied slots in the container
-- @class Container
-- @return number taken slots
function Container:ItemCount()
	self = type(self)=='table' and self or Container.New(self)
    return getContainerItemCount(self._index)
end
--- Get container's item capacity.
-- Returns the total amount of slots the container has
-- @class Container
-- @return number total slots
function Container:ItemCapacity()
	self = type(self)=='table' and self or Container.New(self)
    return getContainerItemCapacity(self._index)
end
--- Is container open.
-- Returns true if the container is open, false if not
-- @class Container
-- @return boolean true or false
function Container:isOpen()
	self = type(self)=='table' and self or Container.New(self)
    return getContainerOpen(self._index)
end
--- Is container empty.
-- Returns true if the container is empty, false if not
-- @class Container
-- @return boolean true or false
function Container:isEmpty()
	self = type(self)=='table' and self or Container.New(self)
    return getContainerItemCount(self._index) == 0
end
--- Is container full.
-- Returns true if the container is full, false if not
-- @class Container
-- @return boolean true or false
function Container:isFull()
	self = type(self)=='table' and self or Container.New(self)
    return getContainerItemCount(self._index) == getContainerItemCapacity(self._index)
end
--- Get container's item capacity.
-- Returns the amount of vacant slots in the container
-- @class Container
-- @return number vacant slots
function Container:EmptySlots()
	self = type(self)=='table' and self or Container.New(self)
    return getContainerItemCapacity(self._index) - getContainerItemCount(self._index)
end
--- Closes container.
-- Closes the container
-- @class Container
-- @return boolean true or false
function Container:Close()
	self = type(self)=='table' and self or Container.New(self)
    return closeContainer(self._index)
end
--- Minimizes container.
-- Minimizes the container (it will fail if any dialog windows are open)
-- @class Container
-- @return boolean true or false
function Container:Minimize()
	self = type(self)=='table' and self or Container.New(self)
    return minimizeContainer(self._index)
end
--- Opens items in the container.
-- Opens items based on their itemids in the container
-- @class Container
-- @param ... itemids to open in the container
-- @return void returns nothing
function Container:OpenChildren(...)
	self = type(self)=='table' and self or Container.New(self)
	
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
                while (self:UseItem(i, id[3]) ~= 1) do wait(300) end
				
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
	self = type(self)=='table' and self or Container.New(self)
    local count = 0
    for spot = 0, self:ItemCount()-1 do
        local item = self:GetItemData(spot)
        if (item.id == id) then
            count = count + math.max(item.count, 1)
        end
    end
    return count
end
--- Get item data from spot in the container.
-- Returns the item data from the specified slot in the container
-- @class Container
-- @param spot the specific slot to query
-- @return table containing item data
function Container:GetItemData(spot)
	self = type(self)=='table' and self or Container.New(self)
    return getContainerSpotData(self._index, spot)
end
--- Returns an iterator of items in the container.
-- Returns a (spot, container) iterator to the next item in the container.
-- @class Container
-- @return integer spot, table itemData
function Container:iItems()
	self = type(self)=='table' and self or Container.New(self)
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
-- @param openInSameWindow if true, open the item in the same window
-- @return boolean true or false
function Container:UseItem(spot, openInSameWindow)
	self = type(self)=='table' and self or Container.New(self)
    return containerUseItem(self._index, spot, openInSameWindow or false)
end

function Container:UseItemWithContainerItem(spotfrom, contto, spotto)
	self = type(self)=='table' and self or Container.New(self)
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
	self = type(self)=='table' and self or Container.New(self)
    return containerUseItemWithGround(self._index, spot, x, y, z)
end
--- Uses item in the container with a creature.
-- Uses an item in a specific spot in the container on a specific creature
-- @class Container
-- @param spot the specific slot to use
-- @param id the creature id to use the item with
-- @return boolean true or false
function Container:UseItemWithCreature(spot, id)
	self = type(self)=='table' and self or Container.New(self)
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
	self = type(self)=='table' and self or Container.New(self)
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
	self = type(self)=='table' and self or Container.New(self)
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
	self = type(self)=='table' and self or Container.New(self)
    return containerMoveItemToContainer(self._index, spotfrom, containerto, spotto, count or -1)
end

function Container:GoBack()
	self = type(self)=='table' and self or Container.New(self)
    return containerBack(self._index)
end



Item = {}
--- Get item name from id.
-- Returns the item's name by providing it's itemid
-- @class Item
-- @param id the itemid
-- @return string the item's name
Item.GetName = getItemNameByID
--- Get itemid from name.
-- Returns the itemid by providing it's name
-- @class Item
-- @param name the item's name
-- @return number the itemid
Item.GetID = getItemIDByName
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

Item.isWalkable = isItemWalkable
Item.isFurniture = isItemFurniture
Item.isField = isItemField
Item.GetWeight = getItemWeight
Item.GetValue = getItemValue
Item.GetCost = getItemCost


--- Get active id of ring.
-- Returns the corresponding active id of the unequipped ring item
-- @class Item
-- @param itemid the itemid of an unequipped ring
-- @return number the active itemid
function Item.GetRingActiveID(itemid)
    local rings = {
        [3092] = 3095, [3091] = 3094, [3093] = 3096, [3052] = 3089, [3098] = 3100,
        [3097] = 3099, [3051] = 3088, [3053] = 3090, [3049] = 3086, [9593] = 9593,
        [9393] = 9392, [3007] = 3007, [6299] = 6300, [9585] = 9585, [3048] = 3048,
        [3050] = 3087, [3245] = 3245, [3006] = 3006, [349] = 349, [3004] = 3004,
		[16114] = 16264
    }
    return rings[itemid] or 0
end


function Item.GetItemIDFromDualInput(input)
	return (type(input) == "string" and Item.GetID(input)) or input
end
function Item.GetItemNameFromDualInput(input)
	return (type(input) == "number" and Item.GetName(input)) or input
end

function Item.MakeDualInputTableIntoIDTable(input)
	local t = {}
	for i=1, #input do
		t[i] = Item.GetItemIDFromDualInput(input[i])
	end
	return t
end



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
--- Pickup item on map.
-- Moves an item from a specific position of the map to another position
-- @class Map
-- @param xfrom source coordinate in the map on the x-axis
-- @param yfrom source coordinate in the map on the y-axis
-- @param xto destination coordinate in the map on the x-axis
-- @param yto destination coordinate in the map on the y-axis
-- @param count optional; amount of item stack to move (default is entire stack)
-- @return 1 for success or 0 for failure
Map.MoveItem = mapMoveItem

Map.GetWalkableTiles = function(center, range)
    local walkables = {}
    local base = center
	range = (range > 10) and 10 or range

	veryUnsafeFunctionEnterCriticalMode()
    for x = -range, range do
        for y = -range, range do
            if (Map.IsTileWalkable(base.x+x, base.y+y, base.z)) then
                table.insert(walkables, {x=base.x+x, y=base.y+y, z=base.z})
            end
        end
    end
	veryUnsafeFunctionExitCriticalMode()

    return walkables
end

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

Self = {}

function Self.Speak(msg, talkType, wpm, range)
	local func = selfSay
	
	if(talkType == SPEAK_YELL or talkType == "yell")then
        func = selfYell
    elseif(talkType == SPEAK_WHISPER or talkType == "whisper")then
        func = selfWhisper
    elseif(talkType == SPEAK_NPC or talkType == "npc")then
        func = selfNpcSay
    end
    wpm = wpm or 0
    range = range or 7
    local rangeFrom, rangeTo = math.max(wpm - range, 0), math.max(wpm + range, 0)
    if (type(msg) == 'table') then
        for i = 1, #msg do
            if(wpm > 0) then wait(((msg[i]:len() / 5) * (math.random(rangeFrom, rangeTo) / 60)) * 1000) end
            func(msg[i])
        end
    else
        if(wpm > 0) then wait(((msg:len() / 5) * (math.random(rangeFrom, rangeTo) / 60)) * 1000) end
        return func(msg)
    end
end

function Self.Say(msg, wpm, range)
    Self.Speak(msg, SPEAK_SAY, wpm, range)
end
function Self.Yell(msg, wpm, range)
    return Self.Speak(msg, SPEAK_YELL, wpm, range)
end
function Self.Whisper(msg, wpm, range)
    return Self.Speak(msg, SPEAK_WHISPER, wpm, range)
end
function Self.SayToNpc(msg, wpm, range)
    return Self.Speak(msg, SPEAK_NPC, wpm, range)
end
function Self.PrivateMessage(player, msg)
    return selfPrivateMessage(player, msg)
end

Self.ID = getSelfID
function Self.Name()
    return getCreatureName(getCreatureListIndex(getSelfID()))
end
Self.TargetID = getSelfTargetID
Self.FollowID = getSelfFollowID
Self.Position = getSelfPosition
Self.LookDirection = getSelfLookDirection
function Self.LookPos(range)
    return getPositionFromDirection(Self.Position(), Self.LookDirection(), range or 1)
end
Self.Speed = getSelfSpeed
Self.Outfit = getSelfOutfit
Self.Skull = getSelfSkull
Self.PartyStatus = getSelfPartyStatus
Self.PvPIcon = getSelfPvPIcon
Self.WarIcon = Self.PvPIcon
Self.MaxHealth = getSelfMaxHealth
Self.Health = getSelfHealth
Self.MaxMana = getSelfMaxMana
Self.Mana = getSelfMana
Self.Experience = getSelfExperience
Self.Level = getSelfLevel
Self.Cap = getSelfCap
Self.Stamina = getSelfStamina
Self.Soul = getSelfSoul

Self.isHasted = function() return getSelfFlag("hasted") end
Self.isManaShielded = function() return getSelfFlag("mshielded") end
Self.isParalyzed = function() return getSelfFlag("paralyzed") end
Self.isPoisoned = function() return getSelfFlag("poisoned") end
Self.isBurning = function() return getSelfFlag("burning") end
Self.isElectrified = function() return getSelfFlag("electrified") end
Self.isCursed = function() return getSelfFlag("cursed") end
Self.isFreezing = function() return getSelfFlag("freezing") end
Self.isDrunk = function() return getSelfFlag("drunk") end
Self.isDrowning = function() return getSelfFlag("drowning") end
Self.isDazzled = function() return getSelfFlag("dazzled") end
Self.isBleeding = function() return getSelfFlag("bleeding") end
Self.isInFight = function() return getSelfFlag("inbattle") end
Self.isPzLocked = function() return getSelfFlag("ispzlocked") end
Self.isInPz = function() return getSelfFlag("inpz") end
Self.isBuffed = function() return getSelfFlag("strenghthened") end




Self.GetSpellCooldown = getSelfSpellCooldown
Self.MeetsSpellRequirements = getSelfSpellRequirementsMet
function Self.CanCastSpell(spell)
    return (Self.GetSpellCooldown(spell) == 0 and Self.MeetsSpellRequirements(spell))
end
Self.UseItem = selfUseItem
Self.UseItemFromGround = selfUseItemFromGround
Self.BrowseField = selfBrowseField
Self.UseItemWithGround = selfUseItemWithGround
Self.UseItemWithCreature = selfUseItemWithCreature
function Self.UseItemFromEquipment(slot)
    local contains, index = table.contains(EQUIPMENT_SLOTS, slot)
    return contains and slotUseItem(index) or 0
end
function Self.UseItemFromMyPosition()
    return Self.UseItemFromGround(Self.Position().x, Self.Position().y, Self.Position().z)
end
function Self.UseItemWithMyPosition(id)
	id = Item.GetItemIDFromDualInput(id)
    return Self.UseItemWithGround(id, Self.Position().x, Self.Position().y, Self.Position().z)
end
function Self.UseItemWithMe(id)
	id = Item.GetItemIDFromDualInput(id)
    return Self.UseItemWithCreature(id, Self.ID())
end
function Self.UseItemWithTarget(id)
	id = Item.GetItemIDFromDualInput(id)
    return Self.UseItemWithCreature(id, Self.TargetID())
end
function Self.UseItemWithFollow(id)
	id = Item.GetItemIDFromDualInput(id)
    return Self.UseItemWithCreature(id, Self.FollowID())
end
Self.Head = getHeadSlotData
Self.Armor = getArmorSlotData
Self.Legs = getLegsSlotData
Self.Feet = getFeetSlotData
Self.Amulet = getAmuletSlotData
Self.Weapon = getWeaponSlotData
Self.Ring = getRingSlotData
Self.Backpack = getBackpackSlotData
Self.Shield = getShieldSlotData
Self.Ammo = getAmmoSlotData
Self.GetCreatureKills = getSelfCreatureKillCount
Self.ResetCreatureKills = resetSelfCreatureKillCount
Self.Ping = getSelfPing
function Self.UseBed(x, y, z, mode)
	while (Self.UseItemFromGround(x, y, z) == 0) do
		wait(100)
	end

	if (doSelfSelectTrainingMode(mode) == 1) then
		return true
	end
	return false
end
function Self.StopAttack()
    return attackCreature(0)
end
function Self.StopFollow()
    return followCreature(0)
end
function Self.Turn(direction)
    if (type(direction) == "string") then
		local index = table.find(DIRECTIONS, direction, false)
        return index and doSelfTurn(index-1) or 0
    else
        return doSelfTurn(direction)
    end
end
function Self.Step(direction)
    if (type(direction) == "string") then
		local index = table.find(DIRECTIONS, direction, false)
        return index and doSelfStep(index-1) or 0
    else
        return doSelfStep(direction)
    end
end
function Self.ShopSellAllItems(item)
    return Self.ShopSellItem(item, Self.ShopGetItemSaleCount(item))
end
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
    until count <= 0
    return 1, 0
end
function Self.ShopBuyItem(item, count)
    local func = (type(item) == "string") and shopBuyItemByName or shopBuyItemByID
    count = tonumber(count) or 1
    repeat
        local amnt = math.min(count, 100)
        if (func(item, amnt) == 0) then
            return 0, amnt
        end
        wait(300,600)
        count = (count - amnt)
    until count <= 0
    return 1, 0
end
function Self.ShopBuyItemsUpTo(item, c)
    local count = c - Self.ItemCount(item)
    if (count > 0) then
        return Self.ShopBuyItem(item, count)
    end
    return 0, 0
end
function Self.ShopGetItemPurchasePrice(item)
    local func = (type(item) == "string") and shopGetItemBuyPriceByName or shopGetItemBuyPriceByID
    return func(item)
end
function Self.ShopGetItemSaleCount(item)
    local func = (type(item) == "string") and shopGetItemSaleCountByName or shopGetItemSaleCountByID
    return func(item)
end
function Self.Money()
    return Self.ItemCount(3031) + (Self.ItemCount(3035) * 100) + (Self.ItemCount(3043) * 10000)
end
function Self.DepositMoney(amount)
    delayWalker(3000)
    
	if (type(amount) == 'number') then
		Self.SayToNpc({'hi', 'deposit ' .. math.max(amount, 1), 'yes'}, 70, 5)
	else
		Self.SayToNpc({'hi', 'deposit all', 'yes'}, 70, 5)
    end
end
function Self.WithdrawMoney(amount)
    delayWalker(3000)
    Self.SayToNpc({'hi', 'withdraw ' .. amount, 'yes'}, 70, 5)
end
function Self.Flasks()
    return Self.ItemCount(283) + Self.ItemCount(284) + Self.ItemCount(285)
end
function Self.OpenMainBackpack(minimize)
	repeat
		wait(200)
	until (Self.UseItemFromEquipment("backpack") > 0)
	wait(1200)
	
	local ret = Container.GetFirst()
	if (minimize == true) then
		ret:Minimize()
		wait(100)
	end
	return ret
end
function Self.ItemCount(itemid, container, countEquipment)
	if (countEquipment == nil) then countEquipment = true end
	
	itemid = Item.GetItemIDFromDualInput(itemid)
    if (container) then -- count specific container
        return Container.GetByName(container):CountItemsOfID(itemid) or 0
    end

	veryUnsafeFunctionEnterCriticalMode()
    local value = 0
    if (countEquipment) then
        local slots = {Self.Head, Self.Armor, Self.Legs, Self.Feet, Self.Amulet, Self.Weapon, Self.Ring, Self.Shield, Self.Ammo}
        for i = 1, #slots do -- count slots
            local slot = slots[i]()
            if(slot.id == itemid)then
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
function Self.Cast(words, mana)
    if(not mana or Self.Mana() >= mana)then
        return Self.CanCastSpell(words) and Self.Say(words) and wait(300) or 0
    end
end
function Self.DistanceFromPosition(x, y, z)
    return getDistanceBetween(Self.Position(), {x=x,y=y,z=z})
end
function Self.UseLever(x, y, z, itemid)	
	local ret = 0
	if (itemid == 0 or itemid == nil) then
		repeat
			wait(1500)
		until (Self.UseItemFromGround(x, y, z) ~= 0 or Self.Position().z ~= z)
		return (Self.Position().z == z)
	elseif (itemid > 99) then
		local mapitem = Map.GetTopUseItem(x, y, z)
		while (mapitem.id == itemid and Self.Position().z == z) do
			Self.UseItemFromGround(x, y, z)
			wait(1500)
			mapitem = Map.GetTopUseItem(x, y, z)
		end
		return (Self.Position().z == z)
	end
	return false
end
function Self.UseDoor(x, y, z, close)
    close = close or false
    if (not Map.IsTileWalkable(x, y, z) or close) then
        local used = Self.UseItemFromGround(x, y, z)
        wait(1000, 1500)
        return Map.IsTileWalkable(x, y, z) ~= close
    end
end
function Self.CutGrass(x, y, z)
    local itemid = nil
    for _, id in ipairs({3308, 3330, 9594, 9596, 9598}) do
        if(Self.ItemCount(id) >= 1)then
            itemid = id
            break
        end
    end
    if(itemid)then -- we found a machete
        local grass = Self.UseItemWithGround(itemid, x, y, z)
        wait(1500, 2000)
        return Map.IsTileWalkable(x, y, z)
    end
    return false
end
function Self.UsePick(x, y, z)
    local itemid = false
    for _, id in ipairs({3456, 9594, 9596, 9598}) do
        if(Self.ItemCount(id) >= 1)then
            itemid = id
            break
        end
    end
    if (itemid) then -- we found a pick
        local hole = Self.UseItemWithGround(itemid, x, y, z)
        wait(1500, 2000)
        return Map.IsTileWalkable(x, y, z)
    end
    return false
end
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
function Self.DropFlasks(x, y, z)
    Self.DropItems(x, y, z, 283, 284, 285)
end
function Self.Equip(itemid, slot, count)
	itemid = Item.GetItemIDFromDualInput(itemid)
    if not(table.contains(EQUIPMENT_SLOTS, slot))then
        error(slot .. "' is not a valid slot.") return false
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
end

function Self.Dequip(slot, container)
	if (not table.contains(EQUIPMENT_SLOTS, slot)) then
		error(slot .. "' is not a valid slot.")
		return false
	end

	container = container or Container.GetFirst()
	if (type(container) == 'number') then
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



Self.OpenLocker = function()
    -- Depot position (defaults to look pos)
    local depotPos = Self.LookPos(1)

    -- Detect entry
    local pos = Self.Position()
    local adjacentWalkableTiles = Map.GetWalkableTiles(pos, 1)
    if adjacentWalkableTiles and adjacentWalkableTiles[1] then
        local entryPos = adjacentWalkableTiles[1]
        depotPos = getPositionFromDirection(pos, Map.GetDirectionTo(entryPos, pos), 1)
    end

    wait(500, 1000)
	local field = Container.GetByName("Browse Field")
	while (not field:isOpen()) do -- locker isn't open
        Self.BrowseField(depotPos.x, depotPos.y, depotPos.z)
        wait(800, 1000)
        field = Container.GetByName("Browse Field")
    end

    while (field:UseItem(0, true) ~= 1) do
		wait(100)
	end
end
function Self.OpenDepot()
    delayWalker(5000)
    local locker, depot = Container.GetByName("Locker"), Container.GetByName("Depot Chest")
    if (depot:isOpen()) then -- depot is already open
        return depot
    end
    if (not locker:isOpen()) then -- locker isn't open
        Self.OpenLocker()
        wait(800, 1000)
        locker = Container.GetByName("Locker")
    end
    if (locker:isOpen()) then  -- if the locker opened successfully
        while (locker:UseItem(0, true) ~= 1) do
			wait(100)
		end
        wait(1000, 1400)
        depot = Container.GetByName("Depot Chest")
        if (depot:isOpen()) then  -- if the depot opened successfully
            return depot
        end
    end
    return false
end
function Self.DepositItems(...)
	setBotEnabled(false)

	local depositInfo = {}

	for i = 1, #arg do
		local data = arg[i]
		local spot = 0
		local id = 0
		if (type(data) == 'table') then
			spot = data[2]
			id = Item.GetItemIDFromDualInput(data[1])
		else
			spot = 0
			id = Item.GetItemIDFromDualInput(data)
		end

		if (not depositInfo[spot]) then
			depositInfo[spot] = {}
			depositInfo[spot].realIndex = -1
			depositInfo[spot].items = {}
		end
		table.insert(depositInfo[spot].items, id)
	end

	local indexes = Container.GetIndexes() -- list of containers open before we start depositing
	local depot = Self.OpenDepot()

	local badIndexes = #indexes == 0
	if (badIndexes or not depot) then
		if (badIndexes) then
			print("Warning: no open backpacks to deposit from.")
		else
			print("Warning: depositor failed to open depot.")
		end
		setBotEnabled(true)
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
			print("Warning: depositor missing backpack in depot slot " .. spot .. ". Please place cascading backpacks in your depot")
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
								print("Warning: depositor unable to find room in deposit backpack " .. data.realIndex .. ".")
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
	setBotEnabled(true)
	return true
end
function Self.WithdrawItems(slot, ...)
    local function withdrawFromChildContainers(items, parent, slot)
        local bid = parent:GetItemData(slot).id
        if (#items > 0) and (Item.isContainer(bid)) then
            parent:UseItem(slot, true) -- open backpack on the slot
        else
            return true
        end
        wait(500, 900)
        local child = Container.GetLast() -- get the child opened backpack
        if (child:ID() == bid) then -- the child bp id matches the itemid clicked, close enough
            local childCount = child:ItemCount()
            local offset = 0
            local count = {}
            for spot = 0, childCount - 1 do -- loop through all the items in depot backpack
                local item = child:GetItemData(spot - offset)
                local data, index = table.contains(items, item.id, 1)--, table.find(items, item.id)
                if (data) then
                    if (not count[item.id]) then count[item.id] = 0 end -- start the count
                    local dest = Container.GetFirst()
                    local skip = false
                    local toMove = item.count -- we think we're going to move all the item at first, this may change below
                    
                    local slotnum = tonumber(data[2])
                    if (slotnum) then
                        slot = slotnum
                    end
                    toMove = math.min(data[3] - count[item.id], item.count) -- get what's left to withdraw or all of the item, whichever is least
                    if((count[item.id] + toMove) > data[3])then -- this is probably not needed, but just incase we are trying to move more than the limit
                        skip = true -- skip the entire moving
                        table.remove(items, index) -- remove the item from the list
                    end
                    
                    if not (skip) then
                        local compCount = child:CountItemsOfID(item.id)
                        child:MoveItemToContainer(spot - offset, dest:Index(), slot, toMove)
                        wait(500, 900)
                        if(compCount > child:CountItemsOfID(item.id))then -- less of the itemid in there now, item moved successfully.. most likely.
                            count[item.id] = count[item.id] + toMove
                            if(toMove == item.count)then -- if we deposited a full item stack then decrease the offset, if not remove the item since we're done.
                                offset = offset + 1
                            else
                                table.remove(items, index)
                            end
                        else
                            return true -- we didn't move the item, container is full. TODO: recurse the player containers.
                        end
                    end
                end
            end
            return withdrawFromChildContainers(items, child, child:ItemCount() - 1)
        end
        return false
    end
    setBotEnabled(false) -- turn off walker/looter/targeter
    local depot = Self.OpenDepot()
    if (depot) then -- did we open depot?
		local items = {}
		for i = 1, #arg do
			local data = arg[i]
			items[i] = {Item.GetItemIDFromDualInput(data[1]), data[2], data[3]}
		end
		
        withdrawFromChildContainers(items, depot, slot)
    end
    setBotEnabled(true)
    delayWalker(2500)
end
function Self.CloseContainers()
    for i = 0, 15 do
        closeContainer(i)
        wait(100)
    end
end
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


function Self.GetTargets(distance)
    local tbl = {}
    local spectators = Self.GetSpectators()
    for _, cid in ipairs(spectators) do
        if(cid:DistanceFromSelf() <= distance and cid:isMonster())then
            table.insert(tbl, cid)
        end
    end
    return tbl
end
function Self.isAreaPvPSafe(radius, multiFloor, ignoreParty, ...)
    local spectators = Self.GetSpectators(multiFloor)
    for _, cid in ipairs(spectators) do
        if(cid:DistanceFromSelf() <= radius and cid:isPlayer())then
            if(not cid:isPartyMember() or not ignoreParty)then
                if(not table.find({...}, cid:Name(), false))then
                    return false
                end
            end
        end
    end
    return true
end


Walker = {}
function Walker.Stop()
	setWalkerEnabled(false)
end
function Walker.Start()
	setWalkerEnabled(true)
end
function Walker.Delay(time)
	delayWalker(time)
end
function Walker.Goto(label)
	gotoLabel(label)
end
function Walker.ConditionalGoto(cond, truelabel, falselabel)
	if (cond) then
		Walker.Goto(truelabel)
	elseif (falselabel ~= nil) then
		Walker.Goto(falselabel)
	end
end
Walker.IsStuck = getWalkerStuck
Walker.IsLuring = getWalkerLuring

Looter = {}
function Looter.Stop()
	setLooterEnabled(false)
end
function Looter.Start()
	setLooterEnabled(true)
end

Targeting = {}
function Targeting.Stop()
	setTargetingEnabled(false)
end
function Targeting.Start()
	setTargetingEnabled(true)
end

Cavebot = {}
function Cavebot.Stop()
	Walker.Stop()
	Looter.Stop()
	Targeting.Stop()
end
function Cavebot.Start()
	Walker.Start()
	Looter.Start()
	Targeting.Start()
end




----------[[ SIGNALS CLASS ]]------------
Signal = {}
libSignals = {}
Signal.__index = Signal
signalsRegistered = false
function libOnReceive(key, value)
    local signal = libSignals[key]
    if(signal and signal._function)then
        -- Cast types to original value
        local originType = value:sub(1,5)
        local originVal = value:sub(6)
        if(originType == 'int::')then
            value = tonumber(originVal)
        elseif(originType == 'tbl::')then
            value = table.unserialize(originVal)
        elseif(originType == 'bol::')then
            value = originVal == 'true' and true or false
        end
        signal:Execute(value)
    end
end
function libDestroySignal(key)
    local signal = libSignals[key]
    if(signal)then
        libSignals[key] = nil
    end
end

--- Creates a new signal.
-- Registers the specified function to loop as a signal
-- @class Signal
-- @param key the key to identify the signal as
function Signal.New(key)
    if(libSignals[key])then
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
    self = type(self)=='table' and self or Signal.New(self)
    self._function = callback
end

--- Executes a specific module.
-- Manually triggers the module function
-- @class Signal
-- @param value the data to send through the signal
-- @return void returns nothing
function Signal:Send(value)
    self = type(self)=='table' and self or Signal.New(self)

    if (self._key and value ~= nil) then
        -- type checking
        local prefix = ''
        local valType = type(value)
        if(valType == 'number')then
            prefix = 'int::'
        elseif(valType == 'table')then
            prefix = 'tbl::'
            value = table.serialize(value)
        elseif(valType == 'boolean')then
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
    self = type(self)=='table' and self or Signal.New(self)
    
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
    self = type(self)=='table' and self or Signal.New(self)
    libDestroySignal(self._key)
end


----------[[ LOCAL SPEECH PROXY CLASS ]]------------
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
function libOnLocalSpeech(...)
	local params = {...}
	for begin=1, #params, 4 do
		local mtype = LocalSpeechTypes[tonumber(params[begin])]
		local speaker = params[begin+1]
		local level = tonumber(params[begin+2])
		local text = params[begin+3]
		
		for key, proxy in pairs(libLocalSpeechProxies) do
			proxy:Execute(mtype, speaker, level, text)
		end
	end
end
function libDestroyLocalSpeechProxy(key)
    local signal = libLocalSpeechProxies[key]
    if(signal)then
        libLocalSpeechProxies[key] = nil
    end
end

--- Creates a new local speech proxy.
-- Registers the local speech proxy callback
-- @class LocalSpeechProxy
-- @param key the key to identify the proxy as
function LocalSpeechProxy.New(key)
    if(libLocalSpeechProxies[key])then
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
    self = type(self)=='table' and self or LocalSpeechProxy.New(self)
    self._function = callback
end
--- Executes a specific local speech proxy response.
-- Manually triggers the local speech proxy
-- @class LocalSpeechProxy
-- @return ambiguous anything the function being called might return
function LocalSpeechProxy:Execute(mtype, speaker, level, text)
    self = type(self)=='table' and self or LocalSpeechProxy.New(self)
    
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
    self = type(self)=='table' and self or LocalSpeechProxy.New(self)
    libDestroyLocalSpeechProxy(self._key)
end


----------[[ PRIVATE MESSAGE PROXY CLASS ]]------------
PrivateMessageProxy = {}
libPrivateMessageProxies = {}
PrivateMessageProxy.__index = PrivateMessageProxy
privateMessageProxiesRegistered = false
function libOnPrivateMessage(...)
	local params = {...}
	for begin=1, #params, 4 do
		local speaker = params[begin]
		local level = tonumber(params[begin+1])
		local text = params[begin+2]
		
		for key, proxy in pairs(libPrivateMessageProxies) do
			proxy:Execute(speaker, level, text)
		end
	end
end
function libDestroyPrivateMessageProxy(key)
    local signal = libPrivateMessageProxies[key]
    if(signal)then
        libPrivateMessageProxies[key] = nil
    end
end

--- Creates a new private message proxy.
-- Registers the private message proxy callback
-- @class PrivateMessageProxy
-- @param key the key to identify the proxy as
function PrivateMessageProxy.New(key)
    if(libPrivateMessageProxies[key])then
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
    self = type(self)=='table' and self or PrivateMessageProxy.New(self)
    self._function = callback
end
--- Executes a specific private message proxy response.
-- Manually triggers the private message proxy
-- @class PrivateMessageProxy
-- @return ambiguous anything the function being called might return
function PrivateMessageProxy:Execute(speaker, level, text)
    self = type(self)=='table' and self or PrivateMessageProxy.New(self)
    
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
    self = type(self)=='table' and self or PrivateMessageProxy.New(self)
    libDestroyPrivateMessageProxy(self._key)
end


----------[[ ERROR MESSAGE PROXY CLASS ]]------------
ErrorMessageProxy = {}
libErrorMessageProxies = {}
ErrorMessageProxy.__index = ErrorMessageProxy
errorMessageProxiesRegistered = false
function libOnErrorMessage(...)
	local params = {...}
	for _,message in ipairs(params) do
		for key, proxy in pairs(libErrorMessageProxies) do
			proxy:Execute(message)
		end
	end
end
function libDestroyErrorMessageProxy(key)
    local signal = libErrorMessageProxies[key]
    if(signal)then
        libErrorMessageProxies[key] = nil
    end
end

--- Creates a new error message proxy.
-- Registers the error message proxy callback
-- @class ErrorMessageProxy
-- @param key the key to identify the proxy as
function ErrorMessageProxy.New(key)
    if(libErrorMessageProxies[key])then
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
    self = type(self)=='table' and self or ErrorMessageProxy.New(self)
    self._function = callback
end
--- Executes a specific error message proxy response.
-- Manually triggers the error message proxy
-- @class ErrorMessageProxy
-- @return ambiguous anything the function being called might return
function ErrorMessageProxy:Execute(message)
    self = type(self)=='table' and self or ErrorMessageProxy.New(self)
    
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
    self = type(self)=='table' and self or ErrorMessageProxy.New(self)
    libDestroyErrorMessageProxy(self._key)
end

----------[[ LOOT MESSAGE PROXY CLASS ]]------------
LootMessageProxy = {}
libLootMessageProxies = {}
LootMessageProxy.__index = LootMessageProxy
lootMessageProxiesRegistered = false
function libOnLootMessage(...)
	local params = {...}
	for _,message in ipairs(params) do
		for key, proxy in pairs(libLootMessageProxies) do
			proxy:Execute(message)
		end
	end
end
function libDestroyLootMessageProxy(key)
    local signal = libLootMessageProxies[key]
    if(signal)then
        libLootMessageProxies[key] = nil
    end
end

--- Creates a new loot message proxy.
-- Registers the loot message proxy callback
-- @class LootMessageProxy
-- @param key the key to identify the proxy as
function LootMessageProxy.New(key)
    if(libLootMessageProxies[key])then
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
    self = type(self)=='table' and self or LootMessageProxy.New(self)
    self._function = callback
end
--- Executes a specific loot message proxy response.
-- Manually triggers the loot message proxy
-- @class LootMessageProxy
-- @return ambiguous anything the function being called might return
function LootMessageProxy:Execute(message)
    self = type(self)=='table' and self or LootMessageProxy.New(self)
    
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
    self = type(self)=='table' and self or LootMessageProxy.New(self)
    libDestroyLootMessageProxy(self._key)
end

----------[[ LOOK MESSAGE PROXY CLASS ]]------------
LookMessageProxy = {}
libLookMessageProxies = {}
LookMessageProxy.__index = LookMessageProxy
lookMessageProxiesRegistered = false
function libOnLookMessage(...)
	local params = {...}
	for _,message in ipairs(params) do
		for key, proxy in pairs(libLookMessageProxies) do
			proxy:Execute(message)
		end
	end
end
function libDestroyLookMessageProxy(key)
    local signal = libLookMessageProxies[key]
    if(signal)then
        libLookMessageProxies[key] = nil
    end
end

--- Creates a new look message proxy.
-- Registers the look message proxy callback
-- @class LookMessageProxy
-- @param key the key to identify the proxy as
function LookMessageProxy.New(key)
    if(libLookMessageProxies[key])then
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
    self = type(self)=='table' and self or LookMessageProxy.New(self)
    self._function = callback
end
--- Executes a specific look message proxy response.
-- Manually triggers the look message proxy
-- @class LookMessageProxy
-- @return ambiguous anything the function being called might return
function LookMessageProxy:Execute(message)
    self = type(self)=='table' and self or LookMessageProxy.New(self)
    
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
    self = type(self)=='table' and self or LookMessageProxy.New(self)
    libDestroyLookMessageProxy(self._key)
end

----------[[ BATTLE MESSAGE PROXY CLASS ]]------------
BattleMessageProxy = {}
libBattleMessageProxies = {}
BattleMessageProxy.__index = BattleMessageProxy
battleMessageProxiesRegistered = false
function libOnBattleMessage(...)
	local params = {...}
	for _,message in ipairs(params) do
		for key, proxy in pairs(libBattleMessageProxies) do
			proxy:Execute(message)
		end
	end
end
function libDestroyBattleMessageProxy(key)
    local signal = libBattleMessageProxies[key]
    if(signal)then
        libBattleMessageProxies[key] = nil
    end
end

--- Creates a new battle message proxy.
-- Registers the battle message proxy callback
-- @class BattleMessageProxy
-- @param key the key to identify the proxy as
function BattleMessageProxy.New(key)
    if(libBattleMessageProxies[key])then
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
    self = type(self)=='table' and self or BattleMessageProxy.New(self)
    self._function = callback
end
--- Executes a specific battle message proxy response.
-- Manually triggers the battle message proxy
-- @class BattleMessageProxy
-- @return ambiguous anything the function being called might return
function BattleMessageProxy:Execute(message)
    self = type(self)=='table' and self or BattleMessageProxy.New(self)
    
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
    self = type(self)=='table' and self or BattleMessageProxy.New(self)
    libDestroyBattleMessageProxy(self._key)
end




----------[[ EFFECT MESSAGE PROXY CLASS ]]------------
EffectMessageProxy = {}
libEffectMessageProxies = {}
EffectMessageProxy.__index = EffectMessageProxy
effectMessageProxiesRegistered = false
function libOnEffectMessage(...)
	local params = {...}
	for begin=1, #params, 4 do
		local message = params[begin]
		local x = tonumber(params[begin+1])
		local y = tonumber(params[begin+2])
		local z = tonumber(params[begin+3])
		
		for key, proxy in pairs(libEffectMessageProxies) do
			proxy:Execute(message, x, y, z)
		end
	end
end
function libDestroyEffectMessageProxy(key)
    local signal = libEffectMessageProxies[key]
    if(signal)then
        libEffectMessageProxies[key] = nil
    end
end


--- Creates a new effect message proxy.
-- Registers the effect message proxy callback
-- @class EffectMessageProxy
-- @param key the key to identify the proxy as
function EffectMessageProxy.New(key)
    if(libEffectMessageProxies[key])then
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
    self = type(self)=='table' and self or EffectMessageProxy.New(self)
    self._function = callback
end
--- Executes a specific effect message proxy response.
-- Manually triggers the effect message proxy
-- @class EffectMessageProxy
-- @return ambiguous anything the function being called might return
function EffectMessageProxy:Execute(message, x, y, z)
    self = type(self)=='table' and self or EffectMessageProxy.New(self)
    
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
    self = type(self)=='table' and self or EffectMessageProxy.New(self)
    libDestroyEffectMessageProxy(self._key)
end



--[[ OTHER SHIT ]]--

function table.find(tbl, value, careful)
    local sensitive = (type(careful) ~= "boolean" or not careful) and false or true
    
    if(not sensitive and type(value) == "string")then
        for i, v in pairs(tbl) do
            if(type(v) == "string") then
                if(v:lower() == value:lower()) then
                    return i
                end
            end
        end
        return false
    end
    for i, v in pairs(tbl) do
        if(v == value) then
            return i
        end
    end
    return false
end
function table.contains(t, value, index)
    for n = 1, #t do
        local c = t[n]
        if(type(c) == 'table') and (type(value) ~= 'table') and (index) then
            if(c[index] == value)then
                return c, n
            end
        elseif(c == value)then
            return c, n
        end
    end
    return false
end
function table.serialize(x, recur)
    local t = type(x)
    recur = recur or {}
    if(t == nil) then
        return "nil"
    elseif(t == "string") then
        return string.format("%q", x)
    elseif(t == "number") then
        return tostring(x)
    elseif(t == "boolean") then
        return x and "true" or "false"
    elseif(getmetatable(x)) then
        error("Can not serialize a table that has a metatable associated with it.")
    elseif(t == "function") then
		return tostring(x)
    elseif(t == "table") then
        if(table.find(recur, x)) then
            error("Can not serialize recursive tables.")
        end
        table.insert(recur, x)
        local s = "{"
        for k, v in pairs(x) do
            s = s .. "[" .. table.serialize(k, recur) .. "]" .. " = " .. table.serialize(v, recur) .. ", "
        end
        return s:sub(0, s:len() - 2) .. "}"
    end
    error("Can not serialize value of type '" .. t .. "'.")
end
function table.unserialize(str)
    return loadstring("return " .. str)()
end


function string:titlecase()
    return self:gsub("(%a)([%w_']*)", function(first, rest) return first:upper()..rest:lower() end)
end
function string:split(s)
    local s, tbl = s or " ", {}
    self:gsub(string.format("([^%s]+)", s), function(c) tbl[#tbl+1] = c end)
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


-- COMPATS (these are still useable but may be deprecated in future releases)
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