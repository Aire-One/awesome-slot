rockspec_format = "3.0"

package = "awesome-slot"
version = "dev-1"

source = {
   url = "git+https://github.com/Aire-One/awesome-slot.git",
}

description = {
   summary = "A declarative API to connect signals for the AwesomeWM.",
   detailed = "A declarative API to connect signals for the AwesomeWM.",
   homepage = "https://github.com/Aire-One/awesome-slot",
   license = "*** please specify a license ***",
   labels = {
      "awesome",
      "signals",
      "declarative",
   },
}

dependencies = {
   "lua >= 5.1, < 5.5",
}

build = {
   type = "builtin",
   modules = {
      ["awesome-slot.init"] = "src/awesome-slot/init.lua",
      ["awesome-slot.slots.client"] = "src/awesome-slot/slots/client.lua",
      ["awesome-slot.slots.init"] = "src/awesome-slot/slots/init.lua",
      ["awesome-slot.slots.ruled"] = "src/awesome-slot/slots/ruled.lua",
      ["awesome-slot.slots.screen"] = "src/awesome-slot/slots/screen.lua",
      ["awesome-slot.slots.tag"] = "src/awesome-slot/slots/tag.lua",
   },
   copy_directories = {
      "doc",
   },
}

test = {
   type = "busted",
}
