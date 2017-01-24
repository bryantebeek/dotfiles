-----
-- Automatic configuration reloading
-----
function reloadConfig(files)
    doReload = false
    for _,file in pairs(files) do
        if file:sub(-4) == ".lua" then
            doReload = true
        end
    end
    if doReload then
        hs.reload()
    end
end
hs.pathwatcher.new(os.getenv("HOME") .. "/.hammerspoon/", reloadConfig):start()

-----
-- Hide / Unhide XM.app with the '§' key
-----
hs.window.animationDuration=0

function hideUnhideApplication(applicationName)

    local function go()
        local app = hs.appfinder.appFromName(applicationName)

        if not app then
            hs.application.launchOrFocus(applicationName)
        end

        local window = app:mainWindow()

        if app:isHidden() then app:activate() else app:hide() end
    end

    return go
end

hs.hotkey.bind("shift cmd", "§", hideUnhideApplication("XM"))
-- hs.hotkey.bind({}, "§", hideUnhideApplication("Marxico"))

require("keyboard")

-----
-- Show a message when the configuration is reloaded
-----
hs.alert.show("Configuration reloaded")
