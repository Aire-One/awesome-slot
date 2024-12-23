-- Enable lua-local-debugger
-- https://github.com/tomblind/local-lua-debugger-vscode
if os.getenv "LOCAL_LUA_DEBUGGER_VSCODE" == "1" then
   require("lldebugger").start()
end

-- Fake awesome modules
package.loaded["gears.table"] = {
   hasitem = function(t, item)
      for k, v in pairs(t) do
         if v == item then
            return k
         end
      end
   end,
}

package.loaded["ruled.client"] = {}

package.loaded["ruled.notification"] = {}

package.loaded["awful.keyboard"] = {
   append_client_keybindings = function() end,
}

package.loaded["awful.mouse"] = {}

package.loaded["beautiful"] = {}

package.loaded["wibox.widget.imagebox"] = {}

package.loaded["wibox.container.tile"] = {}

package.loaded["awful.wallpaper"] = {}

package.loaded["awful.layout"] = {}
