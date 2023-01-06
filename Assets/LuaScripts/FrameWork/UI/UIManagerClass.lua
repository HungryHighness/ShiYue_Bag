---@class UIManager : Object
local UIManagerClass = Class("UIManager")

---@type table<string, BasePanel>
UIManagerClass.dic = {}

---显示UI面板
---@param basePanelClass BasePanel
---@param callback function
function UIManagerClass:ShowUI(basePanelClass, callback)
    local name = basePanelClass.CName
    if self.dic[name] == nil then
        local basePanel = basePanelClass.New()
        basePanel:Init(name)
        self.dic[name] = basePanel
    end
    self.dic[name]:ShowMe(callback)
    

    
end

---隐藏UI面板
---@param basePanelClass BasePanel
---@public
function UIManagerClass:HideUI(basePanelClass)
    local name = basePanelClass.CName
    if self.dic[name] == nil then
        return
    end
    self.dic[name]:HideMe()
end

return UIManagerClass