local screen_slots = {}

function screen_slots.wallpaper(screen, params)
    local beautiful = require "beautiful"
    local gwallpaper = require "gears.wallpaper"

    params = params or {
        wallpaper = beautiful.wallpaper,
    }

    local wallpaper = params.wallpaper

    if wallpaper then
        -- If wallpaper is a function, call it with the screen
        if type(wallpaper) == "function" then
            wallpaper = wallpaper(screen)
        end

        gwallpaper.maximized(wallpaper, screen, true)
    end
end

return screen_slots

-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
