---@class ItemCell : Object
local ItemCellClass = Class("ItemCell")

function ItemCellClass:Ctor()
    ---@type UnityEngine.GameObject
    self.obj = nil
    self.flag = false
end

---Init
---@param itemInfo ItemInfo
function ItemCellClass:Init(itemInfo)
    self.obj = CS.Framework.ABManager.Instance:LoadRes('ui', 'ItemCell', typeof(CS.UnityEngine.GameObject))
    ---@type UnityEngine.UI.Image
    self.itemImg = self.obj.transform:Find('ItemImg'):GetComponent(typeof(CS.UnityEngine.UI.Image))
    ---@type TMPro.TextMeshProUGUI
    self.itemNumText = self.obj.transform:Find('ItemNumText'):GetComponent(typeof(CS.TMPro.TextMeshProUGUI))

    self:BindEvent()
    self:ChangeInfo(itemInfo)
end

function ItemCellClass:SetParent(parent)
    self.obj.transform:SetParent(parent, false)
end

---ChangeInfo
---@param itemInfo ItemInfo
function ItemCellClass:ChangeInfo(itemInfo)
    if itemInfo == nil then
        self:HideImg()
        return
    end
    self.flag = true
    local data = ItemData.data[itemInfo.id]

    ---@type UnityEngine.U2D.SpriteAtlas
    local spriteAtlas = CS.Framework.ABManager.Instance:LoadRes('ui', 'ItemsSpriteAtlas', typeof(CS.UnityEngine.U2D.SpriteAtlas))

    self.itemImg.sprite = spriteAtlas:GetSprite(data.icon)
    self.itemImg.color = CS.UnityEngine.Color(1, 1, 1, 1)
    self.itemNumText.text = itemInfo.num
    self.tips = data.tips
    self.name = data.name
end
function ItemCellClass:HideImg()
    self.flag = false
    self.itemImg.sprite = nil
    self.itemImg.color = CS.UnityEngine.Color(1, 1, 1, 0)
    self.itemNumText.text = ''
end
function ItemCellClass:BindEvent()
    ---@type UnityEngine.EventSystems.EventTrigger
    local trigger = self.itemImg:GetComponent(typeof(CS.UnityEngine.EventSystems.EventTrigger))
    local pointerEnter = CS.UnityEngine.EventSystems.EventTrigger.Entry()
    pointerEnter.eventID = CS.UnityEngine.EventSystems.EventTriggerType.PointerEnter
    ---@param eventData UnityEngine.EventSystems.BaseEventData
    pointerEnter.callback:AddListener(function(eventData)
        if self.flag == false then
            return
        end
        ---@param tipPanel TipPanel
        UIManager:ShowUI(TipPanelClass, function(tipPanel)
            tipPanel.obj.transform.position = self.obj.transform.position
            tipPanel.itemImg.sprite = self.itemImg.sprite
            tipPanel.NameText.text = self.name
            tipPanel.InfoText.text = self.tips
        end)
    end)
    trigger.triggers:Add(pointerEnter)

    local pointerExit = CS.UnityEngine.EventSystems.EventTrigger.Entry()
    pointerExit.eventID = CS.UnityEngine.EventSystems.EventTriggerType.PointerExit
    pointerExit.callback:AddListener(function(eventData)
        if self.flag == false then
            return
        end
        UIManager:HideUI(TipPanelClass)
    end)
    trigger.triggers:Add(pointerExit)

    local beginDrag = CS.UnityEngine.EventSystems.EventTrigger.Entry()
    beginDrag.eventID = CS.UnityEngine.EventSystems.EventTriggerType.BeginDrag
    beginDrag.callback:AddListener(function(eventData)
        UIManager:HideUI(TipPanelClass)
    end)
    trigger.triggers:Add(beginDrag)

    local endDrag = CS.UnityEngine.EventSystems.EventTrigger.Entry()
    endDrag.eventID = CS.UnityEngine.EventSystems.EventTriggerType.EndDrag
    endDrag.callback:AddListener(function(eventData)
        UIManager:HideUI(TipPanelClass)
    end)
    trigger.triggers:Add(endDrag)

    local drag = CS.UnityEngine.EventSystems.EventTrigger.Entry()
    drag.eventID = CS.UnityEngine.EventSystems.EventTriggerType.Drag
    drag.callback:AddListener(function(eventData)
        UIManager:HideUI(TipPanelClass)
    end)
    trigger.triggers:Add(drag)
end
return ItemCellClass