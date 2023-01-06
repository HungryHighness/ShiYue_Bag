---@class BagPanel : BasePanel
local BagPanelClass = Class('BagPanel', BasePanelClass)

function BagPanelClass:BindUI()
    self.maxBagItem = 16
    if self.nowType == nil then
        self.nowType = -1
    end
    self.equips = nil
    self.items = nil
    self.ExitBtn = self.obj.transform:Find('ExitBtn'):GetComponent(typeof(CS.UnityEngine.UI.Button))
    self.ExitBtn.onClick:AddListener(function()
        UIManager:HideUI(BagPanelClass)
    end)

    local group = self.obj.transform:Find('Group')
    self.equipTog = group.transform:Find('EquipTog'):GetComponent(typeof(CS.UnityEngine.UI.Toggle))
    self.equipTog.onValueChanged:AddListener(function(value)
        if value == true then
            self:ChangeType(1)
        end
    end)
    self.itemTog = group.transform:Find('ItemTog'):GetComponent(typeof(CS.UnityEngine.UI.Toggle))
    self.itemTog.onValueChanged:AddListener(function(value)
        if value == true then
            self:ChangeType(2)
        end
    end)
    self:BagInit()
end

function BagPanelClass:BagInit()
    local content = CS.UnityEngine.GameObject.Find('Content').transform
    ---@type ItemCell[]
    self.bagItems = {}
    for i = 1, self.maxBagItem do
        ---@type ItemCell
        local itemCell = ItemCellClass.New()
        itemCell:Init()
        itemCell:SetParent(content)
        self.bagItems[i] = itemCell
    end
    self:ItemInit()
    self:ChangeType(1)
end

function BagPanelClass:ItemInit()
    self.equips = {}
    self.items = {}
    for i, v in ipairs(PlayerData.equips) do
        self.equips[i] = v
    end
    for i, v in ipairs(PlayerData.items) do
        self.items[i] = v
    end
end

function BagPanelClass:ChangeType(type)
    if self.nowType == type then
        return
    end
    self.nowType = type

    local items
    if self.nowType == 1 then
        items = self.equips
    else
        items = self.items
    end

    for i, v in ipairs(self.bagItems) do
        v:ChangeInfo(items[i])
    end

end
return BagPanelClass