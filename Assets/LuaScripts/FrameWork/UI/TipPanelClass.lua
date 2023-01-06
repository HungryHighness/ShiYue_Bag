---@class TipPanel : BasePanel
local TipPanelClass = Class("TipPanel", BasePanelClass)

function TipPanelClass:BindUI()
    self.itemImg = self.obj.transform:Find('ItemImg'):GetComponent(typeof(CS.UnityEngine.UI.Image))
    self.NameText = self.obj.transform:Find('NameText'):GetComponent(typeof(CS.TMPro.TextMeshProUGUI))
    self.InfoText = self.obj.transform:Find('InfoText'):GetComponent(typeof(CS.TMPro.TextMeshProUGUI))
end

return TipPanelClass