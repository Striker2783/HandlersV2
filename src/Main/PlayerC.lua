local DataStoreService = game:GetService("DataStoreService")
local PlayerSaves = DataStoreService:GetDataStore("DSave1")
local CharacterC = require(script.Parent.CharacterC)
local Stats = require(script.Parent.Stats)

local module = {}
module.__index = module

function module.new(Player: Player): PlayerC
	local self: PlayerCinit = {
		Player = Player,
		Stats = Stats.new(),
		Loaded = false,
	}
	setmetatable(self, module)

	return self
end

function module.startUp(self: PlayerC)
	self:loadDSS()
	self:events()
end

function module.characterAdded(self: PlayerC, char: Model)
	self.Char = CharacterC.new(char)
	self.Char.Model.Humanoid.Died:Connect(function()
		self.Char = nil
	end)
end

function module.events(self: PlayerC)
	self:characterAdded(self.Player.Character or self.Player.CharacterAdded:Wait())
	self.Player.CharacterAdded:Connect(function(character)
		self:characterAdded(character)
	end)
end

function module.load(self: PlayerC, data: any)
	assert(data)
	if data.Stats then
		self.Stats:loadStats(data.Stats)
	end
end

function module.loadDSS(self: PlayerC)
	local success, data = pcall(PlayerSaves:GetAsync(tostring(self.Player.UserId)))
	if success then
		if data then
			self:load(data)
		end
		self:setAsLoaded()
	else
		self.Player:Kick("Failed to load data")
	end
end

function module.DSSSave(self: PlayerC)
	if not self:isLoaded() then
		return
	end
	local save = self:toSave()
	PlayerSaves:SetAsync(tostring(self.Player.UserId), save)
end

function module.toSave(self: PlayerC): Save
	local save: Save = {
		Stats = self.Stats:toSaveData(),
	}
	return save
end

function module.isLoaded(self: PlayerC)
	return self.Loaded
end

function module.setAsLoaded(self: PlayerC)
	self.Loaded = true
end

type Save = {
	Stats: Stats.Save,
}
export type PlayerCinit = {
	Player: Player,
	Char: CharacterC.Character?,
	Stats: Stats.Stats,
	Loaded: boolean,
}
export type PlayerC = PlayerCinit & typeof(setmetatable({}, module))

return module
