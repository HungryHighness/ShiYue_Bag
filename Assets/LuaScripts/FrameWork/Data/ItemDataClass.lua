local ItemDataClass = Class('ItemData')

function ItemDataClass:Ctor()
    local text = CS.Framework.ABManager.Instance:LoadRes('json', 'ItemData', typeof(CS.UnityEngine.TextAsset))
    local itemCell = Json.decode(text.text)
    
    self.data = {}
    for i, v in pairs(itemCell) do
        self.data[v.id] = v
    end
end

return ItemDataClass