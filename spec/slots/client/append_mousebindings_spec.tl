local type Button = require("awful.button")
local client = require("awesome-slot.slots.client")
local mouse = require("awful.mouse")

describe("Test awesome-slot.slots.client.append_mousebindings", function()

   -- Spies cannot be used with Teal since it doesn't allow to augment assert.
   -- Instead, we will use a local variable to store the registered bindings and
   -- override the append_client_mousebinding function to store the bindings in
   -- the local variable.
   local registered_bindings: { Button } = {}
   function mouse.append_client_mousebindings(bindings: { Button })
      for _, binding in ipairs(bindings) do
         table.insert(registered_bindings , binding)
      end
   end

   before_each(function()
      registered_bindings = {}
   end)

   it("should invoke awful.mouse.append_client_mousebinding", function()
      local bindings = {
         Button {
            modifiers = { "Mod1" },
            button = 1,
            on_press = function() end,
         },
      }

      client.append_mousebindings {
         mousebindings = bindings,
      }

      assert(#registered_bindings == #bindings)
      for i=1,#bindings do
         assert(registered_bindings[i] == bindings[i])
      end
   end)
end)
