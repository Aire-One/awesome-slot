local client_slots = {}

function client_slots.append_mousebindings (params)
    local amouse = require 'awful.mouse'

    amouse.append_client_mousebindings(params.mousebindings)
end

function client_slots.append_keybindings (params)
    local akeyboard = require 'awful.keyboard'

    akeyboard.append_client_keybindings(params.keybindings)
end

return client_slots
