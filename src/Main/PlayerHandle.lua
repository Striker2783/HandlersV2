local Players = game:GetService("Players")
local PlayerC = require(script.Parent.PlayerC)
local module = {}
module.__index = module

function module.new(): PlayerHandle
	local self: PlayerHandleinit = {
		Players = {},
	}

	setmetatable(self, module)
    Players.PlayerAdded:Connect(function(player)
        self:onPlayerAdd(player)
    end)
	return self
end

function module.onPlayerAdd(self: PlayerHandle, player: Player)
    self.Players[player] = PlayerC.new(player)
end

export type PlayerHandleinit = {
	Players: { [Player]: PlayerC.PlayerC },
}
export type PlayerHandle = PlayerHandleinit & typeof(setmetatable({}, module))

return module
