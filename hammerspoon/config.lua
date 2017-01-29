return function(drillfork)

    local config = {}

    -----
    -- Plugins
    -----
    config.plugins = {
        'drillfork/plugins/applications',
        'drillfork/plugins/terminal'
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
            { key = 'A', name = 'Applications', children = {
                { key = 'C', name = 'Chrome', children = {
                    { key = 'C', name = 'Start', run = drillfork.plugins.applications.show('Google Chrome') },
                    { key = 'R', name = 'Reload', run = function(cb) 
                        hs.application.launchOrFocus('Google Chrome')
                        hs.timer.doAfter(0.5, function() 
                            hs.eventtap.keyStroke({'cmd'}, 'r')
                            drillfork.back()
                            cb()
                        end)
                    end },
                    { key = 'T', name = 'New tab', run = drillfork.plugins.applications.showAndKeyStroke('Google Chrome', {'cmd'}, 't') },
                    { key = 'I', name = 'Incognito', run = drillfork.plugins.applications.showAndKeyStroke('Google Chrome', {'cmd', 'shift'}, 'n') },
                }},
                { key = 'V', name = 'Visual Studio Code', children = {
                    { key = 'V', name = 'Start', run = drillfork.plugins.applications.show('Visual Studio Code') },
                    { key = 'S', name = 'Search', children = function()
                        local choices = {}

                        for file in hs.fs.dir('/Users/bryantebeek/Lifely/projects') do
                            if file ~= '.' and file ~= '..' then
                                local path = '/Users/bryantebeek/Lifely/projects/' .. file
                                local type = hs.fs.fileUTI('/Users/bryantebeek/Lifely/projects/' .. file)

                                if type == 'public.folder' then
                                    table.insert(choices, { text = file, subText = '/Users/bryantebeek/Lifely/projects' })
                                end
                            end
                        end

                        local chooser = hs.chooser.new(function(item)
                            hs.logger.new('Debug', 'Debug'):d(item['text'])
                            drillfork.plugins.terminal.run('/usr/bin/open', {item['subText'] .. '/' .. item['text'], '-a', 'Visual Studio Code'})()
                        end):choices(choices):show()

                        drillfork.finished()
                    end }
                }},
                { key = 'F', name = 'Franz', run = drillfork.plugins.applications.show('Franz') },
                { key = 'S', name = 'Spotify', children = {
                    { key = 'S', name = 'Start', run = drillfork.plugins.applications.show('Spotify') },
                    { key = 'N', name = 'Next', run = hs.spotify.next },
                    { key = 'P', name = 'Previous', run = hs.spotify.previous },
                    { key = 'E', name = 'Search', run = drillfork.plugins.applications.showAndKeyStroke('Spotify', {'cmd'}, 'l') },
                }},
                { key = 'W', name = 'Wunderlist', run = drillfork.plugins.applications.show('Wunderlist') },
                { key = 'M', name = 'Marxico', children = {
                    { key = 'M', name = 'Start', run = drillfork.plugins.applications.show('Default kidnkfckhbdkfgbicccmdggmpgogehop') },
                    { key = 'N', name = 'New note', run = drillfork.plugins.applications.showAndKeyStroke('Default kidnkfckhbdkfgbicccmdggmpgogehop', {'cmd'}, 'n') },
                    { key = 'S', name = 'Search note', run = drillfork.plugins.applications.showAndKeyStroke('Default kidnkfckhbdkfgbicccmdggmpgogehop', {'cmd'}, 's') },
                    { key = 'E', name = 'Evernote', run = drillfork.plugins.applications.show('Evernote') },
                }},
                { key = 'H', name = 'Hammerspoon', children = {
                    { key = 'R', name = 'Reload config', run = hs.reload},
                    { key = 'E', name = 'Edit config', run = drillfork.plugins.terminal.run('/usr/bin/open', {'/Users/bryantebeek/.dotfiles/hammerspoon', '-a', 'Visual Studio Code'}) }
                }},
            }},
            { key = 'S', name = 'System', children = {
                { key = 'S', name = 'Screen', children = {
                    { key = 'S', name = 'Saver', run = hs.caffeinate.startScreensaver }
                }},
                { key = 'W', name = 'Wifi', children = function() 
                    local children = {}

                    table.insert(children, { key = 'N', name = hs.wifi.interfaceDetails().ssid, run = function() hs.pasteboard.writeObjects(hs.wifi.interfaceDetails().ssid) hs.alert('Copied ' .. hs.wifi.interfaceDetails().ssid) end })

                    return children
                end }
            }},
            { key = 'W', name = 'Window', children = {
                { key = 'Q', name = 'Quit', run = function() hs.window.frontmostWindow():close() end },
                { key = 'D', name = 'Desktop', run = hs.window.desktop },
                { key = 'R', name = 'Right', run = function(cb)
                    local win = drillfork.initialWindow()
                    local f = win:frame()
                    local screen = win:screen()
                    local max = screen:frame()

                    f.x = max.x + (max.w / 2)
                    f.y = max.y
                    f.w = max.w / 2
                    f.h = max.h
                    win:setFrame(f)
                    
                    drillfork.back()
                    cb()
                end }
            }}
        }
    end

    return config

end