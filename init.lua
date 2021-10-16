-----
-- AwesomeWM - Slot
--
-- An OO/Declarative API to connect signals for the AwesomeWM.
-- It completes the native `gears.signal` module to make signal connection
-- easier to manage.
-----

local gtable = require 'gears.table'

-- Load global awesome components from the C API
local capi = {
    client = _G.client,
    screen = _G.screen,
    tag = _G.tag
}

local awesome_slot = {
    mt = {},
    _instance = nil,
    slots = require 'awesome-slot.slots',
    static_connect = {
        client = capi.client,
        screen = capi.screen,
        tag = capi.tag,
        ruled_client = require 'ruled.client',
        ruled_notification = require 'ruled.notification'
    }
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

-- Singleton
function awesome_slot.instance()
    if not awesome_slot._instance then
        awesome_slot._instance = {
            slots = {}, -- List of created slot
            -- Methods
            do_action = awesome_slot.do_action,
            create_slot = awesome_slot.create_slot,
            delete_slot = awesome_slot.delete_slot,
            connect_slot = awesome_slot.connect_slot,
            disconnect_slot = awesome_slot.disconnect_slot,
            get_slot = awesome_slot.get_slot
        }
    end

    return awesome_slot._instance
end

function awesome_slot:get_slot(id)
    assert(id)
    return self.slots[id]
end

awesome_slot.actions = {
    NONE = 0,
    CREATE = 1,
    DELETE = 1 << 1,
    CONNECT = 1 << 2,
    DISCONNECT = 1 << 3
}

awesome_slot.slot_status = {
    CREATED = 1,
    CONNECTED = 2
}

function awesome_slot:create_slot(params)
    local id = generate_id(params.id or "UNNAMED_SLOT")

    local slot = {}

    slot.target = params.target
    slot.signal = params.signal

    slot.params = params.slot_params

    if slot.params then
        slot.callback = function ()
            params.slot(slot.params)
        end
    else
        slot.callback = params.slot
    end

    slot.status = awesome_slot.slot_status.CREATED

    -- Insert the ne slot into the slots list
    self.slots[id] = slot

    return slot
end

function awesome_slot:delete_slot(params)
    local slot = self:get_slot(params.id)

    if not slot then
        return false
    end

    if slot.status == awesome_slot.slot_status.CONNECTED then
        print 'please disconnnect the slot before deleting it'
        return false
    end

    self.slots[params.id] = nil

    return true
end

function awesome_slot:connect_slot(params)
    local slot = self:get_slot(params.id)

    if not slot then
        return false
    end

    -- Some modules expose a static connect_signals function
    -- at the module level, while other tables/objects inheriting from
    -- gears.object implement the signal connection API at the instance level.
    if gtable.hasitem(awesome_slot.static_connect, slot.target) then
        slot.target.connect_signal(slot.signal, slot.callback)
    else
        slot.target:connect_signal(slot.signal, slot.callback)
    end

    slot.status = awesome_slot.slot_status.CONNECTED

    return slot
end

function awesome_slot:disconnect_slot(params)
    local slot = self:get_slot(params.id)

    if not slot then
        return false
    end

    -- Please check the `:connect_slot` method to understand why we do this.
    if gtable.hasitem(awesome_slot.static_connect, slot.target) then
        slot.target.disconnect_slot(slot.signal, slot.callback)
    else
        slot.target:disconnect_slot(slot.signal, slot.callback)
    end

    slot.status = awesome_slot.slot_status.CREATED

    return slot
end

function awesome_slot:do_action (params)
    local params = params or {} -- luacheck: ignore shadowing params
    local out = self

    if not params.action then
        return out
    end

    if awesome_slot.actions.DISCONNECT & params.action ~= 0 then
        out = self:disconnect_slot(params)
    end

    if awesome_slot.actions.CREATE & params.action ~= 0 then
        out = self:create_slot(params)
    end

    if awesome_slot.actions.DELETE & params.action ~= 0 then
        out = self:delete_slot(params)
    end

    if awesome_slot.actions.CONNECT & params.action ~= 0 then
        out = self:connect_slot(params)
    end

    return out
end

function awesome_slot.mt:__call(params) -- luacheck: ignore unused argument self
    return awesome_slot.instance():do_action(params)
end

return setmetatable(awesome_slot, awesome_slot.mt)
