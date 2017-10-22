require "common/define"
require "common/functions"
require "common/misc"
require "common/event_control"
require "ui/ui_base"
require "event_handler"
require "logic/status"

function Main()
    print 'Lua Begins'
    SendGlobalMessage("ENUM_SHOW_START_UI")
end