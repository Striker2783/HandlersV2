local module = {}
module.__index = module

function module.new()
	local self: Levelinit = {
		Level = 1,
		EXP = 0,
	}

	setmetatable(self, module)
	return self
end

function module.addEXP(self: Level, amount: number)
	self.EXP = self.EXP + amount
end

function module.removeEXP(self: Level, amount: number)
	self.EXP = self.EXP - amount
end

function module.calculateNextLevel(self: Level)
	return self.Level * 10
end

function module.hasEnoughEXP(self: Level)
	return self.EXP >= self:calculateNextLevel()
end

function module.addLevel(self: Level)
	self.Level = self.Level + 1
end
function module.toSave(self: Level): Save
	return { self.Level, self.EXP }
end
function module.load(self: Level, data: { number })
	assert(#data == 2, "Unknown Level format")
	self.Level = data[1]
	self.EXP = data[2]
end
--[[
	(Fairly inefficient because it only calculates 1 level at a time)
]]
function module.levelUp(self: Level)
	local requiredEXP = self:hasEnoughEXP()
	if not requiredEXP then
		return
	end
	self:removeEXP(requiredEXP)
	self:addLevel()
	self:levelUp()
end
export type Save = {
	[number]: number,
}
export type Levelinit = {
	Level: number,
	EXP: number,
}
export type Level = Levelinit & typeof(setmetatable({}, module))

return module
