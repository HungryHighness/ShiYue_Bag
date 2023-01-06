---UI基础类
---@class BasePanel : Object
local BasePanelClass = Class("BasePanel")

function BasePanelClass:Ctor()
    ---@type UnityEngine.GameObject
    self.obj = nil
end

---Init
---@param name BasePanel
function BasePanelClass:Init(name)
    self.obj = CS.Framework.ABManager.Instance:LoadRes('ui', name, typeof(CS.UnityEngine.GameObject))
    self.obj.transform:SetParent(Canvas, false)

    self:BindUI()
end

function BasePanelClass:BindUI()

end

---@param callback function
function BasePanelClass:ShowMe(callback)
    if callback ~= nil then
        callback(self)
    end
    self.obj:SetActive(true)
end

function BasePanelClass:HideMe()
    self.obj:SetActive(false)
end

return BasePanelClass