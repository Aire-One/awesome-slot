local type Button = require("awful.button")
local type Key = require("awful.key")
local keyboard = require("awful.keyboard")
local mouse = require("awful.mouse")

local record ClientSlots
end

local record AppendMousebindingsParams
   mousebindings: { Button }
end

function ClientSlots.append_mousebindings(params: AppendMousebindingsParams)
   mouse.append_client_mousebindings(params.mousebindings)
end

local record AppendKeybindingsParams
   keybindings: { Key }
end

function ClientSlots.append_keybindings(params: AppendKeybindingsParams)
   keyboard.append_client_keybindings(params.keybindings)
end

return ClientSlots
