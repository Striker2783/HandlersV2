local module = {}
module.__index = {}

function module.new()
	local self: Moneyinit = {
		Money = 0,
	}

	setmetatable(self, module)
	return self
end

function module.hasEnough(self: Money, amount: number)
	return self.Money >= amount
end

function module.set(self: Money, amount: number)
    self.Money = amount
end

function module.remove(self: Money, amount: number)
	self.Money = self.Money - amount
end

function module.add(self: Money, amount: number)
    self.Money = self.Money + amount
end

export type Moneyinit = {
	Money: number,
}
export type Money = Moneyinit & typeof(setmetatable({}, module))

return module
