local ruled_slots = {}

function ruled_slots.append_client_rules (params)
    local rclient = require 'ruled.client'

    for _,rule in pairs(params.rules) do
        rclient.append_rule(rule)
    end
end

function ruled_slots.append_notification_rules (params)
    local rnotification =  require 'ruled.notification'

    for _,rule in pairs(params.rules) do
        rnotification.append_rule(rule)
    end
end

return ruled_slots
