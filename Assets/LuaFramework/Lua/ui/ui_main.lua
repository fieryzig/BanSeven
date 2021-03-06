local cls_ui_main = class("cls_ui_main", cls_ui_base)
cls_ui_main.s_ui_panel = 'UIPrefabs/MainCanvas'

function cls_ui_main:ctor()
    self.super.ctor(self)
end

function cls_ui_main:InitCards()
    --table.sort(self.cards, SortCards)
    --print(table.concat(cards, ", ", 1, #cards ))
    self.cards_ui = {}
    first_x = -200
    for _,card in ipairs(self.cards) do -- card is a string
        self.cards_ui[card] = newObject(resMgr:GetRes('Prefabs/'..card));
        self.cards_ui[card].transform:SetParent(self.m_transform);
        self.cards_ui[card]:GetComponent('RectTransform').localScale = Vector3(1,1,1);
        self.cards_ui[card]:GetComponent('RectTransform').localPosition = Vector3(first_x,-150,0);
        first_x = first_x + 30;
    end
end

function cls_ui_main:GetChosenCard()
    for _,card in pairs(self.cards_ui) do -- card is a gameobject
        --print('choose' .. _);
        if (card ~= nil) then
            if (card.transform.localPosition.y > -150 and card.transform.localPosition.y < -100) then return card; end;
        end
    end
    return nil;
end

function cls_ui_main:OnStart()
    log("main ui")
    if offline == 1 then
        require 'logic/offline'
    else
        --require 'logic/online'
    end

    self.state = 'ready'
    self.m_ready_btn = self.m_transform:FindChild("ReadyBtn").gameObject;
    self.m_submit_btn = self.m_transform:FindChild("SubmitBtn").gameObject;
    hide(self.m_submit_btn);
    self.m_lock_btn = self.m_transform:FindChild("LockBtn").gameObject;
    hide(self.m_lock_btn);

    self.m_lua_behaviour:AddClick(self.m_ready_btn, function (obj)
        --
        Init();
        self.player_id = GetID()
        self.cards = GetCards()
        self.state = 'running'
        hide(self.m_ready_btn);
        show(self.m_submit_btn);
        show(self.m_lock_btn);
        self.count = 0;
        self:InitCards(self.cards, self.m_transform);
    end)

    self.m_lua_behaviour:AddClick(self.m_submit_btn, function(obj)
        chosen = self:GetChosenCard()
        if (chosen == nil) then return; end
        local name = chosen.name;
        name = string.sub(name,1,-8);
        color, num = SplitCard(name); updown = legal[color];
        print('debug:'..color..' '..updown[1]..' '..updown[2]);
        if updown[1] ~= num and updown[2] ~= num then return; end
        if num == 7 then 
            updown[1] = updown[1] - 1;
            updown[2] = updown[2] + 1;
        elseif num > 7 then
            updown[2] = updown[2] + 1;
        else
            updown[1] = updown[1] - 1;
        end 
        LuaHelper.SubmitCard(name, color, num, 0);
        self.cards_ui[name] = nil;
        GameObject.Destroy(chosen);
        self.count = self.count + 1;
        next_turn();
    end)

    self.m_lua_behaviour:AddClick(self.m_lock_btn, function(obj)
        chosen = self:GetChosenCard();
        if (chosen == nil) then return; end
        
        for k,v in pairs(self.cards_ui) do
            if self.cards_ui[k] ~= nil then
                color, num = SplitCard(k); updown = legal[color];
                if updown[1] == num or updown[2] == num then
                    print('lock--------------- '..color..' ' .. num);
                    return;
                end
            end
        end
           
        chosen:GetComponent('CardController').locked = true;
        LuaHelper.ChangeColor(chosen, Color(0.5,0.5,0.5));
        chosen.transform.localPosition = Vector3(chosen.transform.localPosition.x, -150, 0);
        chosen.name = string.sub(chosen.name,1,-8);     
        self.cards_ui[chosen.name] = nil;
        self.count = self.count + 1;
        next_turn();
    end)

    self.otherPlayer = WaitForTurn;
end

function cls_ui_main:Over()
    return self.count == 13 
end

function cls_ui_main:Update()
    if status_turn ~= 0 and self.state == 'running' then
        self.otherPlayer();
    end
    if self:Over() then
        print('Over');
        SendGlobalMessage("ENUM_SHOW_OVER_UI");
        self:Close();
    end 
end

function cls_ui_main:OnDestroy()

end

function ShowMainUI()
    cls_ui_main:new()
end