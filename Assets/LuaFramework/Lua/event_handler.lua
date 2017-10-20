local _message_handler = {
    -- common message
    ["ENUM_SHOW_START_UI"] = { file = "ui/ui_start", func = "ShowStartUI(...)"},
    ["ENUM_SHOW_LOBBY_UI"] = { file = "ui/ui_lobby", func = "ShowLobbyUI(...)"},
    ["ENUM_SHOW_MAIN_UI"] = { file = "ui/ui_main", func = "ShowMainUI(...)"},
  
}

local function ReceiveUIMessage(message,... )
    local handleEvents = _message_handler[message]
    if handleEvents then
        if handleEvents.file~=nil then
            require( handleEvents.file )
        end

        local func = handleEvents.func
        if type(func) == "string" then
            func = load(func)
        end

        if func then
            func( luaType, ... )
        end
        func = nil
    end
end

function SendUIMessage( ... )
    ReceiveUIMessage(...)
end

function SendGlobalMessage( ... )
    ReceiveUIMessage(...)
    triggerGlobalEvent(...)
end