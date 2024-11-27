local client = require "ruled.client"
local notification = require "ruled.notification"

local ruled_slots = {}

function ruled_slots.append_client_rules(params)
   return function()
      client.append_rules(params.rules)
   end
end

function ruled_slots.append_notification_rules(params)
   return function()
      notification.append_rules(params.rules)
   end
end

return ruled_slots
