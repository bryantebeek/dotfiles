return function(drillfork)

    local config = {}

    -----
    -- Plugins
    -----
    config.plugins = {
        'applications'
    }

    -----
    -- Leader
    -----
    config.leaderKey = '.'
    config.leaderKeyModifiers = {'cmd'}

    -----
    -- Hotkeys
    -----
    config.hotkeys = function()
        return {
            { key = "A", name = "Applications", children = {
                { key = "C", name = "Chrome", children = {
                    { key = "C", name = "Start", run = drillfork.plugins.applications.show("Google Chrome") },
                    { key = "R", name = "Reload", run = drillfork.plugins.applications.showAndKeyStroke("Google Chrome", {'cmd'}, 'r') },
                    { key = "T", name = "New tab", run = drillfork.plugins.applications.showAndKeyStroke("Google Chrome", {'cmd'}, 't') },
                    { key = "I", name = "Incognito", run = drillfork.plugins.applications.showAndKeyStroke("Google Chrome", {'cmd', 'shift'}, 'n') },
                }},
                { key = "V", name = "Visual Studio Code", run = drillfork.plugins.applications.show("Visual Studio Code") },
                { key = "F", name = "Franz", run = drillfork.plugins.applications.show("Franz") },
                { key = "S", name = "Spotify", children = {
                    { key = "S", name = "Start", run = drillfork.plugins.applications.show("Spotify") },
                    { key = "N", name = "Next", run = hs.spotify.next },
                    { key = "P", name = "Previous", run = hs.spotify.previous },
                }},
                { key = "W", name = "Wunderlist", run = drillfork.plugins.applications.show("Wunderlist") },
                { key = "M", name = "Marxico", children = {
                    { key = "M", name = "Start", run = drillfork.plugins.applications.show("Default kidnkfckhbdkfgbicccmdggmpgogehop") },
                    { key = "N", name = "New note", run = drillfork.plugins.applications.showAndKeyStroke("Default kidnkfckhbdkfgbicccmdggmpgogehop", {'cmd'}, 'n') },
                    { key = "S", name = "Search note", run = drillfork.plugins.applications.showAndKeyStroke("Default kidnkfckhbdkfgbicccmdggmpgogehop", {'cmd'}, 's') },
                    { key = "E", name = "Evernote", run = drillfork.plugins.applications.show("Evernote") },
                }},
                { key = "H", name = "Hammerspoon", children = {
                    { key = "R", name = "Reload config", run = hs.reload}
                }},
            }},
            { key = "S", name = "System", children = {
                { key = "S", name = "Screen", children = {
                    { key = "S", name = "Saver", run = hs.caffeinate.startScreensaver }
                }},
                { key = "W", name = "Wifi", children = function() 
                    local children = {}

                    table.insert(children, { key = "N", name = hs.wifi.interfaceDetails().ssid, run = function() hs.pasteboard.writeObjects(hs.wifi.interfaceDetails().ssid) hs.alert('Copied ' .. hs.wifi.interfaceDetails().ssid) end })

                    return children
                end }
            }},
            { key = "W", name = "Window", children = {
                { key = "Q", name = "Quit", run = function() hs.window.frontmostWindow():close() end },
                { key = "D", name = "Desktop", run = hs.window.desktop },
            }}
        }
    end

    return config

end