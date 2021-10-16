-- Only allow symbols available in all Lua versions
std = "min"

files[".luacheckrc"].ignore = { "111", "112", "131" }

-- Global objects defined by the C code
read_globals = {
    "awesome",
    "button",
    "dbus",
    "drawable",
    "drawin",
    "key",
    "keygrabber",
    "mousegrabber",
    "selection",
    "tag",
    "window",
    "table.unpack",
    "math.atan2",
}

globals = {
    "screen",
    "mouse",
    "root",
    "client",
}

-- Enable cache (uses .luacheckcache relative to this rc file).
cache = true

-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
