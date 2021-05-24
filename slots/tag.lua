local tag_slots = {}

function tag_slots.default_layouts (params)
    local alayout = require 'awful.layout'

    alayout.append_default_layouts(params.layouts)
end

return tag_slots
