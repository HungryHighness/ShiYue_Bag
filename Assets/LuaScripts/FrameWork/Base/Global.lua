require('FrameWork.Base.Class')

Json = require('FrameWork.Third.JsonUtility')

UIManager = require('FrameWork.UI.UIManagerClass').New()

BasePanelClass = require('FrameWork.UI.BasePanelClass')
MainPanelClass = require('FrameWork.UI.MainPanelClass')
BagPanelClass = require('FrameWork.UI.BagPanelClass')
TipPanelClass = require('FrameWork.UI.TipPanelClass')
ItemInfoClass = require('FrameWork.UI.ItemInfoClass')
ItemCellClass = require('FrameWork.UI.ItemCellClass')

PlayerData = require('FrameWork.Data.PlayerDataClass').New()
ItemData = require('FrameWork.Data.ItemDataClass').New()

---@type UnityEngine.Transform
Canvas = CS.UnityEngine.GameObject.Find("Canvas").transform