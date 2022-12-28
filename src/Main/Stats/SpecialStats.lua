local module = {}
module.__index = module

function module.new()
    local self: SpecialStatsinit = {}
    
    setmetatable(self, module)
    return self
end

function module.toSave(self: SpecialStats): Save
    local save: Save = {}
    return save
end

function module.load(self: SpecialStats, data: Save?)
    assert(data)
    --TODO
end

export type Save = {}
export type SpecialStatsinit = {}
export type SpecialStats = SpecialStatsinit & typeof(setmetatable({}, module))

return module