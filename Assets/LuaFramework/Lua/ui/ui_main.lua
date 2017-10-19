local cls_ui_main = class("cls_ui_main", cls_ui_base)
cls_ui_main.s_ui_panel = 'UIPrefabs/MainCanvas'

function cls_ui_main:ctor()
    self.super.ctor(self)
end

function cls_ui_main:OnStart()
    log("main ui")
end

function cls_ui_main:Update()

end

function cls_ui_main:OnDestroy()

end

function ShowMainUI()
    cls_ui_main:new()
end