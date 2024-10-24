local screen_slots = {}

function screen_slots.wallpaper(screen, params)
   local beautiful = require "beautiful"
   local wallpaper = require "gears.wallpaper"

   params = params or {
      wallpaper = beautiful.wallpaper,
   }

   local w = params.wallpaper

   if w then
      -- If wallpaper is a function, call it with the screen
      if type(w) == "function" then
         w = w(screen)
      end

      wallpaper.maximized(w, screen, true)
   end
end

return screen_slots
