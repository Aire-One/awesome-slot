local type KeyModifier = require("awful.key_modifier")

local interface ButtonProps
   modifiers: { KeyModifier }
   button: number
   on_press: function()
   on_release: function()
end

local record Button is ButtonProps
   metamethod __call: function(Button, ButtonProps): Button
end

return Button
