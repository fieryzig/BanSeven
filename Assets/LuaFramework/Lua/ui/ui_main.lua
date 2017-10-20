local cls_ui_main = class("cls_ui_main", cls_ui_base)
cls_ui_main.s_ui_panel = 'UIPrefabs/MainCanvas'

function cls_ui_main:ctor()
    self.super.ctor(self)
end

function cls_ui_main:InitCards()
    table.sort(self.cards)
    --print(table.concat(cards, ", ", 1, #cards ))
    self.cards_ui = {}
    first_x = -200
    for _,card in ipairs(self.cards) do
        self.cards_ui[card] = newObject(resMgr:GetRes('Prefabs/'..card));
        self.cards_ui[card].transform:SetParent(self.m_transform);
        self.cards_ui[card]:GetComponent('RectTransform').localPosition = Vector3(first_x,-150,0);
        first_x = first_x + 25;
    end
end

function cls_ui_main:OnStart()
    log("main ui")
    self.state = 'ready'
    self.m_ready_btn = self.m_transform:FindChild("ReadyBtn").gameObject;
    self.m_submit_btn = self.m_transform:FindChild("SubmitBtn").gameObject;
    hide(self.m_submit_btn);
    self.m_lock_btn = self.m_transform:FindChild("LockBtn").gameObject;
    hide(self.m_lock_btn);

    self.m_lua_behaviour:AddClick(self.m_ready_btn, function (obj)
        --
        if offline == 1 then
            log('req offline')
            require 'logic/offline'
        else
            log('req online')
            --require 'logic/online'
        end
        self.player_id = GetID()
        self.cards = GetCards()
        self.state = 'running'
        hide(self.m_ready_btn);
        show(self.m_submit_btn);
        show(self.m_lock_btn);
        
        self:InitCards(self.cards, self.m_transform);
    end)
end



function cls_ui_main:Update()
    if self.state == 'running' then
        if (Input.GetMouseButtonDown(0)) then
            print(Input.mousePostion);
            hit = RayHit:GetHit(Input.mousePostion);
            print('hit->'..hit);
        end
    end
end

function cls_ui_main:OnDestroy()

end

function ShowMainUI()
    cls_ui_main:new()
end