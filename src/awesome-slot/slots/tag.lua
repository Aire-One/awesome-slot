local layout = require "awful.layout"

local tag_slots = {}

function tag_slots.default_layouts(params)
   return function()
      layout.append_default_layouts(params.layouts)
   end
end

return tag_slots
