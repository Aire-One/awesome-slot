project = "awesome-slot"
title = "A declarative API to connect signals for the AwesomeWM"

all = false
dir = "doc"
format = "markdown"
pretty = "lua"
prettify_files = true
backtick_references = true
merge = true
use_markdown_titles = true
wrap = true
sort_modules = true
not_luadoc = true

file = {
    "init.lua",
    exclude = {
        "slots",
    },
}

-- Define some new ldoc tags from the AwesomeWM doc
new_type("constructorfct", "Constructor", false, "Parameters")
new_type("staticfct", "Static functions", false, "Parameters")
