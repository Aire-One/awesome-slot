local beautiful = require "beautiful"
local imagebox = require "wibox.widget.imagebox"
local tile = require "wibox.container.tile"
local wallpaper = require "awful.wallpaper"

local screen_slots = {}

function screen_slots.wallpaper(params)
   return function(screen)
      wallpaper {
         screen = screen,
         widget = {
            {
               image = params.wallpaper or beautiful.wallpaper,
               upscale = true,
               downscale = true,
               widget = imagebox,
            },
            valign = "center",
            halign = "center",
            tiled = false,
            widget = tile,
         },
      }
   end
end

return screen_slots
