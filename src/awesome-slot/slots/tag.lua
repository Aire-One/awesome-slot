local tag_slots = {}

function tag_slots.default_layouts(params)
   local layout = require "awful.layout"

   layout.append_default_layouts(params.layouts)
end

return tag_slots
