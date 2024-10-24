local client_slots = {}

function client_slots.append_mousebindings(params)
   local mouse = require "awful.mouse"

   for _, bindings in pairs(params.mousebindings) do
      mouse.append_client_mousebindings(bindings)
   end
end

function client_slots.append_keybindings(params)
   local keyboard = require "awful.keyboard"

   for _, bindings in pairs(params.keybindings) do
      keyboard.append_client_keybindings(bindings)
   end
end

return client_slots
