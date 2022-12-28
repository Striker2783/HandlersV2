local PlayerHandler = require(script.Parent.PlayerHandle)
local module = {}
module.__index = module

function module.new(): Game
	local self: Gameinit = {
		PlayerHandler = PlayerHandler.new(),
	}

	setmetatable(self, module)
	return self
end

export type Gameinit = {
	PlayerHandler: PlayerHandler.PlayerHandle,
}
export type Game = Gameinit & typeof(setmetatable({}, module))

return module
