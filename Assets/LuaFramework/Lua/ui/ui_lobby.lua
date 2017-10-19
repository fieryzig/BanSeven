local cls_ui_lobby = class("cls_ui_lobby",cls_ui_base)
cls_ui_lobby.s_ui_panel = 'UIPrefabs/LobbyCanvas'

function cls_ui_lobby:ctor()
    self.super.ctor(self)
end

function cls_ui_lobby:OnStart()
    log("lobby ui begins")
    
end

function cls_ui_lobby:Update()

end

function cls_ui_lobby:OnDestroy()

end

function ShowLobbyUI()
    cls_ui_lobby:new()
end