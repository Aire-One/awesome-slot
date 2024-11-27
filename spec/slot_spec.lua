local slot = require "awesome-slot"

local function new_target()
   return {
      signal = nil, -- Only need to bind 1 signal in the tests
      connect_signal = function(self, _signal_name, signal_callback)
         self.signal = signal_callback
      end,
      disconnect_signal = function()
         -- Unimplemented
      end,
      emit_signal = function(self, _signal_name, ...)
         self.signal(...)
      end,
   }
end

describe("Awesome-slot", function()
   it("should create slot", function()
      local target = new_target()

      local s = slot {
         target = target,
         signal = "signal",
         slot = function() end,
      }

      assert.is_not_nil(s)
   end)

   it("should remove slot", function()
      local target = new_target()

      local s = slot {
         target = target,
         signal = "signal",
         slot = function() end,
      }

      slot.remove(s)

      assert.is_false(s.connected) -- remove should also invoke disconnect_signal
      assert.is_nil(slot.get_slot(s))
   end)

   it("should automatically connect slot", function()
      local target = new_target()

      local s = slot {
         target = target,
         signal = "signal",
         slot = function() end,
      }

      assert.is_true(s.connected)
   end)

   it("should prevent slot connection with parameter", function()
      local target = new_target()

      local s = slot {
         target = target,
         signal = "signal",
         slot = function() end,
         connect = false,
      }

      assert.is_false(s.connected)
   end)

   it("should connect signal", function()
      local target = new_target()

      local s = slot {
         target = target,
         signal = "signal",
         slot = function() end,
         slot_params = { key = "value" },
         connect = false,
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
      }

      assert.is_not_nil(slot.get_slot(id))
   end)

   it("should generate id", function()
      local target = new_target()

      local s = slot {
         target = target,
         signal = "signal",
         slot = function() end,
      }

      assert.is_not_nil(s.id)
   end)

   it("should manage slot parameters", function()
      local target = new_target()
      local signal_name = "signal"
      local params = { key = "value" }
      local callback = spy.new(function(p)
         return function()
            assert.same(params, p)
         end
      end)

      slot {
         target = target,
         signal = signal_name,
         slot = callback,
         slot_params = params,
      }

      target:emit_signal(signal_name)
      assert.spy(callback).called()
   end)

   it("should retrieve signal parameters", function()
      local target = new_target()
      local signal_name = "signal"
      local callback = spy.new(function()
         return function(a, b, c)
            assert.equal(a, 1)
            assert.equal(b, 2)
            assert.equal(c, 3)
         end
      end)

      slot {
         target = target,
         signal = signal_name,
         slot = callback,
      }

      target:emit_signal(signal_name, 1, 2, 3)
   end)
end)
