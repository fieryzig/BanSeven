local cls_ui_start = class("cls_ui_start",cls_ui_base)
cls_ui_start.s_ui_panel = 'UIPrefabs/StartCanvas'

function cls_ui_start:ctor()
    self.super.ctor(self)
end

function cls_ui_start:OnStart()
    log("start ui begins")
    self.m_offline_btn = self.m_transform:FindChild("OfflineBtn").gameObject;
    self.m_lua_behaviour:AddClick(self.m_offline_btn, function (obj)
        --
        offline = 1;
        SendGlobalMessage("ENUM_SHOW_MAIN_UI")
        self:Close()
    end)

    self.m_login_btn = self.m_transform:FindChild("LoginBtn").gameObject;
    self.m_lua_behaviour:AddClick(self.m_login_btn, function(obj)
        --
        ret = Network:Connect()
        if ret == 0 then
            -- Do the Login things in Logic/
            SendGlobalMessage("ENUM_SHOW_LOBBY_UI")
            self:Close()  
        end
    end)
end

function cls_ui_start:Update()

end

function cls_ui_start:OnDestroy()

end

function ShowStartUI()
    cls_ui_start:new()
end