local client = require("ruled.client")
local notification = require("ruled.notification")

local record RuledSlots
end

local record AppendClientRulesParams
   rules: { client.RuleComponent }
end

function RuledSlots.append_client_rules(params: AppendClientRulesParams)
   client.append_rules(params.rules)
end

function RuledSlots.append_notification_rules(params)
   for _, rule in pairs(params.rules) do
      notification.append_rule(rule)
   end
end

return RuledSlots
