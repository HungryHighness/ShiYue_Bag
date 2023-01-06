
---@class MainPanel : BasePanel
local MainPanelClass = Class("MainPanel", BasePanelClass)
---@type UnityEngine.UI.Button
MainPanelClass.bagBtn = nil


function MainPanelClass:BindUI()
    self.bagBtn = self.obj.transform:Find('BagBtn'):GetComponent(typeof(CS.UnityEngine.UI.Button))
    self.bagBtn.onClick:AddListener(function()
       UIManager:ShowUI(BagPanelClass)
    end)
end

return MainPanelClass