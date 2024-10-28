local Key = require("awful.key")
local client = require("awesome-slot.slots.client")
local keyboard = require("awful.keyboard")

describe("Test awesome-slot.slots.client.append_keybindings", function()

   -- Spies cannot be used with Teal since it doesn't allow to augment assert.
   -- Instead, we will use a local variable to store the registered bindings and
   -- override the append_client_keybinding function to store the bindings in
   -- the local variable.
   local registered_bindings: { Key } = {}
   function keyboard.append_client_keybindings(bindings: { Key })
      for _, binding in ipairs(bindings) do
         table.insert(registered_bindings , binding)
      end
   end

   before_each(function()
      registered_bindings = {}
   end)

   it("should invoke awful.mouse.append_client_keybinding", function()
      local bindings = {
         Key {
            modifiers = { "Mod1" },
            key = "a",
            on_press = function() end,
         },
      }

      client.append_keybindings {
         keybindings = bindings,
      }

      assert(#registered_bindings == #bindings)
      for i=1,#bindings do
         assert(registered_bindings[i] == bindings[i])
      end
   end)
end)
