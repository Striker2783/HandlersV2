local module = {}
module.__index = module

function module.new(Model: Model) : CharacterModel
	if not Model.PrimaryPart then
		return
	end
	local Humanoid = Model:FindFirstChildOfClass("Humanoid")
	if not Humanoid then
		return
	end
	local self: CharacterModelinit = {
		Model = Model,
		Humanoid = Humanoid,
	}

	setmetatable(self, module)
	return self
end

export type CharacterModelinit = {
	Model: Model,
	Humanoid: Humanoid,
}
export type CharacterModel = CharacterModelinit & typeof(setmetatable({}, module))

return module
