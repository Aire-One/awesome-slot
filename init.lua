-----
-- AwesomeWM - Slot
--
-- A declarative API to connect signals for the AwesomeWM.
-- It completes the native `gears.signal` module to make signal connection
-- easier to manage.
-----

local gtable = require "gears.table"

-- Load global awesome components from the C API
local capi = {
    client = _G.client,
    screen = _G.screen,
    tag = _G.tag,
}

local awesome_slot = {
    mt = {},
    slots = require "awesome-slot.slots",
    static_connect = {
        client = capi.client,
        screen = capi.screen,
        tag = capi.tag,
        ruled_client = require "ruled.client",
        ruled_notification = require "ruled.notification",
    },
    _private = {
        registered_slots = {},
    },
}

local function generate_id(base_id)
    local id = base_id
    local n = 0

    while awesome_slot.slots[id] ~= nil do
        n = n + 1
        id = base_id .. "_#" .. n
    end

    return id
end

function awesome_slot.get_slot(slot)
    assert(slot)
    local id = type(slot) == "string" and slot or slot.id
    assert(id, "Slot not found!")

    return awesome_slot._private.registered_slots[id]
end

function awesome_slot.create(params)
    local slot = {}

    slot.id = generate_id(params.id or "UNNAMED_SLOT")
    slot.target = params.target
    slot.signal = params.signal
    slot.connected = false

    if params.slot_params then
        slot.params = params.slot_params
        slot.callback = function()
            params.slot(slot.params)
        end
    else
        slot.callback = params.slot
    end

    -- Insert the new slot into the slots list
    awesome_slot._private.registered_slots[slot.id] = slot

    if params.connect then
        awesome_slot.connect(slot)
    end

    return slot
end

function awesome_slot.remove(params)
    local slot = awesome_slot.get_slot(params)

    if slot.connected then
        awesome_slot.disconnect_slot(slot)
    end

    awesome_slot._private.registered_slots[slot.id] = nil

    return true
end

function awesome_slot.connect(params)
    local slot = awesome_slot.get_slot(params)

    -- Some modules expose a static connect_signals function
    -- at the module level, while other tables/objects inheriting from
    -- gears.object implement the signal connection API at the instance level.
    if gtable.hasitem(awesome_slot.static_connect, slot.target) then
        slot.target.connect_signal(slot.signal, slot.callback)
    else
        slot.target:connect_signal(slot.signal, slot.callback)
    end

    slot.connected = true

    return slot
end

function awesome_slot.disconnect(params)
    local slot = awesome_slot.get_slot(params)

    -- Please check the `:connect_slot` method to understand why we do this.
    if gtable.hasitem(awesome_slot.static_connect, slot.target) then
        slot.target.disconnect_slot(slot.signal, slot.callback)
    else
        slot.target:disconnect_slot(slot.signal, slot.callback)
    end

    slot.connected = false

    return slot
end

function awesome_slot.mt:__call(...) -- luacheck: ignore unused argument self
    return awesome_slot.create(...)
end

return setmetatable(awesome_slot, awesome_slot.mt)

-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
