local cls_ui_over = class("cls_ui_over", cls_ui_base)
cls_ui_over.s_ui_panel = 'UIPrefabs/OverCanvas'

function cls_ui_over:ctor()
    self.super.ctor(self)
end

function cls_ui_over:OnStart()
    self.m_play_button = self.m_transform:FindChild("PlayButton").gameObject;
    self.m_lua_behaviour:AddClick(self.m_play_button, function(obj)
        log('playbutton');
        SendGlobalMessage("ENUM_SHOW_MAIN_UI");
        self:Close();
    end)
    LuaHelper.GetScore();
end

function ShowOverUI()
    cls_ui_over:new()
end