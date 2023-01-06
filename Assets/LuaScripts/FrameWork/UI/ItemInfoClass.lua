---@class ItemInfo : Object
local ItemInfoClass = Class('ItemInfo')

function ItemInfoClass:Ctor(id, num, type)
    self.id = id
    self.num = num
    self.type = type
end

return ItemInfoClass