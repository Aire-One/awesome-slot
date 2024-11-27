local keyboard = require "awful.keyboard"
local mouse = require "awful.mouse"

local client_slots = {}

function client_slots.append_mousebindings(params)
   return function()
      mouse.append_client_mousebindings(params.mousebindings)
   end
end

function client_slots.append_keybindings(params)
   return function()
      keyboard.append_client_keybindings(params.keybindings)
   end
end

return client_slots
