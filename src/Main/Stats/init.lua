local Level = require(script.Level)
local SpecialStats = require(script.SpecialStats)
local BasicStats = require(script.BasicStats)
local module = {}
module.__index = module

function module.new()
	local self: StatsInit = {
		Basic = BasicStats.new(),
		Level = Level.new(),
		SpecialStats = SpecialStats.new(),
	}
	setmetatable(self, module)
	return self
end

function module.toSaveData(self: Stats): Save
	local save: Save = {
		lvl = self.Level:toSave(),
		bStats = self.Basic:toSave(),
		sStats = self.SpecialStats.toSave(),
	}
	return save
end

function module.load(self: Stats, data: Save?)
	assert(data)
	if data.lvl then
		self.Level:load(data.lvl)
	end
	if data.bStats then
		self.Basic:load(data.bStats)
	end
	if data.sStats then
		self.SpecialStats:load(data.sStats)
	end
end
export type Save = {
	lvl: Level.Save,
	bStats: BasicStats.BasicStats,
	sStats: SpecialStats.Save,
}
export type StatsInit = {
	Basic: BasicStats.BasicStats,
	Level: Level.Level,
	SpecialStats: SpecialStats.SpecialStats,
}
export type Stats = typeof(setmetatable({}, module)) & StatsInit

return module
