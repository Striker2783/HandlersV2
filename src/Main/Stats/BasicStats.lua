local module = {}
module.__index = module

function module.new()
	local self: BasicStatsInit = {
		Strength = 0,
		Defense = 0,
	}
	setmetatable(self, module)
	return self
end

function module.load(self: BasicStats, data: Save?)
	assert(data)
	if data.s then
		self.Strength = data.s
	end
	if data.d then
		self.Defense = data.d
	end
end

function module.toSave(self: BasicStats): Save
	local save: Save = {
		s = self.Strength,
		d = self.Defense,
	}
	return save
end
export type Save = {
	s: number,
	d: number,
}
export type BasicStatsInit = {
	Strength: number,
	Defense: number,
}
export type BasicStats = BasicStatsInit & typeof(setmetatable({}, module))

return module
