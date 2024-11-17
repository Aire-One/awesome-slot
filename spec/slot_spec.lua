local slot = require "awesome-slot"

local function new_target()
   return {
      connect_signal = spy.new(function() end),
      disconnect_signal = spy.new(function() end),
   }
end

describe("Awesome-slot", function()
   it("should create slot", function()
      local target = new_target()

      local s = slot {
         target = target,
         signal = "signal",
         slot = function() end,
         slot_params = { key = "value" },
      }

      assert.is_not_nil(s)
   end)

   it("should remove slot", function()
      local target = new_target()

      local s = slot {
         target = target,
         signal = "signal",
         slot = function() end,
         slot_params = { key = "value" },
      }

      slot.remove(s)

      assert.is_nil(slot.get_slot(s))
   end)

   it("should connect slot (from constructor parameters)", function()
      local target = new_target()

      local s = slot {
         target = target,
         signal = "signal",
         slot = function() end,
         slot_params = { key = "value" },
         connect = true,
      }

      assert.is_true(s.connected)
   end)

   it("should connect signal", function()
      local target = new_target()

      local s = slot {
         target = target,
         signal = "signal",
         slot = function() end,
         slot_params = { key = "value" },
      }

      slot.connect(s)

      assert.is_true(s.connected)
   end)

   it("should disconnect slot", function()
      local target = new_target()

      local s = slot {
         target = target,
         signal = "signal",
         slot = function() end,
         slot_params = { key = "value" },
         connect = true,
      }

      slot.disconnect(s)

      assert.is_false(s.connected)
   end)

   it("should get slot", function()
      local target = new_target()

      local s = slot {
         target = target,
         signal = "signal",
         slot = function() end,
         slot_params = { key = "value" },
      }

      assert.is_not_nil(slot.get_slot(s))
   end)

   it("should get slot by id", function()
      local target = new_target()
      local id = "SOME_ID"

      slot {
         id = id,
         target = target,
         signal = "signal",
         slot = function() end,
         slot_params = { key = "value" },
      }

      assert.is_not_nil(slot.get_slot(id))
   end)

   it("should generate id", function()
      local target = new_target()

      local s = slot {
         target = target,
         signal = "signal",
         slot = function() end,
         slot_params = { key = "value" },
      }

      assert.is_not_nil(s.id)
   end)
end)
