local CharacterModel = require(script.CharacterModel)
local module = {}
module.__index = module

function module.new(Model: Model): Character
	local ModelC = CharacterModel.new(Model)
	if not ModelC then
		return
	end
	local self: CharacterInit = {
		Model = ModelC,
	}

	setmetatable(self, module)
	return self
end

export type CharacterInit = {
	Model: CharacterModel.CharacterModel,
}
export type Character = CharacterInit & typeof(setmetatable({}, module))

return module
