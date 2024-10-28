local type KeyModifier = require("awful.key_modifier")

local interface KeyProps
   modifiers: { KeyModifier }
   key: string
   keygroup: string
   on_press: function()
   on_release: function()
end

local record Key is KeyProps
   metamethod __call: function(Key, KeyProps): Key
end

return Key
