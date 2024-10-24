local ruled_slots = {}

function ruled_slots.append_client_rules(params)
   local client = require "ruled.client"

   for _, rule in pairs(params.rules) do
      client.append_rule(rule)
   end
end

function ruled_slots.append_notification_rules(params)
   local notification = require "ruled.notification"

   for _, rule in pairs(params.rules) do
      notification.append_rule(rule)
   end
end

return ruled_slots
