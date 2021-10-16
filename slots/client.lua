local client_slots = {}

function client_slots.append_mousebindings(params)
    local amouse = require "awful.mouse"

    for _, bindings in pairs(params.mousebindings) do
        amouse.append_client_mousebindings(bindings)
    end
end

function client_slots.append_keybindings(params)
    local akeyboard = require "awful.keyboard"

    for _, bindings in pairs(params.keybindings) do
        akeyboard.append_client_keybindings(bindings)
    end
end

return client_slots

-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
