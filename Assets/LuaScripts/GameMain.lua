--package.cpath = package.cpath .. ';C:/HungryHighness/IDE/apps/Rider/ch-0/222.4167.23.plugins/EmmyLua/debugger/emmy/windows/x64/?.dll'
--local dbg = require('emmy_core')
--dbg.tcpConnect('localhost', 9966)

require('FrameWork.Base.Global')

GameMain = {}

function GameMain.Start()
    print('------------GameStart---------')
    UIManager:ShowUI(MainPanelClass)
    PlayerData:Init()
end




