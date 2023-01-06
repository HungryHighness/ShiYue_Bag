---@class PlayerData : Object
local PlayerDataClass = Class('PlayerData')

function PlayerDataClass:Ctor()
    self.equips = {}
    self.items = {}
end
function PlayerDataClass:Init()
    self:AddData(1, 1, 1)
    self:AddData(1, 2, 2)
    self:AddData(2, 3, 3)
    self:AddData(2, 4, 4)
    self:AddData(2, 5, 5)

end
function PlayerDataClass:AddData(itemType, id, num, index)
    local temp = {}
    temp.id = id
    temp.num = num
   
    if itemType == 1 then
        self.equips[#self.equips + 1] = temp
    else
        self.items[#self.items + 1] = temp
    end
end
return PlayerDataClass