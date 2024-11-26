-----
-- AwesomeWM - Slot
--
-- A declarative API to connect signals for the AwesomeWM.
-- It completes the native `gears.signal` module to make signal connection
-- easier to manage.
--
-- Usage example
-- ---
--
-- Tis module allows to create Slot objects. These object can connect to any
-- signals from Awesome WM's `gears.object`s and module level signals.
--
-- In the following example, we create a slot that connects to the `client`
-- global `"request::default_keybindings"` signal to attach keybindings to
-- clients.
--
-- The `slot.slots.client.append_keybindings` function is part of this module
-- and is defined as a function iterating over the `keybindings` parameter to
-- register all defined keybindings with the `awful.keyboard.append_client_keybindings`
-- function.
--
--    local client_keybinding = slot {
--      id = "CLIENT_KEY_BINDINGS",
--      connect = true,
--      target = capi.client,
--      signal = "request::default_keybindings",
--      slot = slot.slots.client.append_keybindings,
--      slot_params = {
--        keybindings = {
--          awful.key({ "Mod4" }, "f",
--            function(client)
--             client.fullscreen = not client.fullscreen
--             client:raise()
--            end,
--            { description = "toggle fullscreen", group = "client" }),
--          },
--          -- ...
--        },
--    }
--
-- @author Aire-One
-- @copyright 2021 Aire-One <aireone@aireone.xyz>
-----

local gtable = require "gears.table"

local capi = {
   client = _G.client,
   screen = _G.screen,
   tag = _G.tag,
}

local awesome_slot = {
   mt = {},

   --- Slots defined by this module.
   -- @table awesome_slot.slots
   slots = require "awesome-slot.slots",

   --- Special objects that require a static connection instead of object level connection.
   -- @table awesome_slot.static_connect
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

--- Find a previously registered slot.
--
-- If the slot asked doesn't exist, the function will fail and throw an error.
--
-- @tparam string|Slot slot The slot id or instance to find.
-- @treturn Slot The slot.
-- @staticfct awesome_slot.get_slot
function awesome_slot.get_slot(slot)
   assert(slot)
   local id = type(slot) == "string" and slot or slot.id
   assert(id, "Slot not found!")

   return awesome_slot._private.registered_slots[id]
end

--- Create a new Slot instance.
--
-- @tparam table params
-- @tparam[opt] string params.id The slot ID.
-- @tparam any params.target The slot target object.
-- @tparam string params.signal The signal the slot connects to.
-- @tparam function params.slot The callback function to connect to the signal.
-- @tparam table params.slot_params The parameters to pass to the callback
--   function. (The signal will invoke the callback function with this table as
--   parameter)
-- @tparam[opt=false] boolean params.connect Connect the slot now.
-- @treturn Slot The created Slot instance.
-- @constructorfct awesome_slot
function awesome_slot.create(params)
   local slot = {}

   slot.id = generate_id(params.id or "UNNAMED_SLOT")
   slot.target = params.target
   slot.signal = params.signal
   slot.connected = false
   slot.callback = function(...)
      params.slot(params.slot_params)(...)
   end

   -- Insert the new slot into the slots list
   awesome_slot._private.registered_slots[slot.id] = slot

   if params.connect then
      awesome_slot.connect(slot)
   end

   return slot
end

--- Remove a registered slot and disconnect it.
--
-- @tparam Slot slot The slot to remove.
-- @staticfct awesome_slot.remove
function awesome_slot.remove(slot)
   local s = awesome_slot.get_slot(slot)

   if s.connected then
      awesome_slot.disconnect_slot(s)
   end

   awesome_slot._private.registered_slots[s.id] = nil
end

--- Connect a slot to its signal.
--
-- @tparam Slot slot The slot to connect.
-- @treturn Slot The slot.
-- @staticfct awesome_slot.connect
function awesome_slot.connect(slot)
   local s = awesome_slot.get_slot(slot)

   -- Some modules expose a static connect_signals function
   -- at the module level, while other tables/objects inheriting from
   -- gears.object implement the signal connection API at the instance level.
   if gtable.hasitem(awesome_slot.static_connect, s.target) then
      s.target.connect_signal(s.signal, s.callback)
   else
      s.target:connect_signal(s.signal, s.callback)
   end

   s.connected = true

   return s
end

--- Disconnect a slot from its signal.
--
-- @tparam Slot slot The slot to disconnect.
-- @treturn Slot The slot.
-- @staticfct awesome_slot.disconnect
function awesome_slot.disconnect(slot)
   local s = awesome_slot.get_slot(slot)

   -- Please check the `:connect_slot` method to understand why we do this.
   if gtable.hasitem(awesome_slot.static_connect, s.target) then
      s.target.disconnect_signal(s.signal, s.callback)
   else
      s.target:disconnect_signal(s.signal, s.callback)
   end

   s.connected = false

   return s
end

function awesome_slot.mt:__call(...) -- luacheck: ignore unused argument self
   return awesome_slot.create(...)
end

return setmetatable(awesome_slot, awesome_slot.mt)
