drillfork = {}
drillfork.config = {}
drillfork.plugins = {}
drillfork.ui = require('drillfork/ui')

-- Constants
alphabet = {"A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"}

-- Variables
hotkeys = {}
initialWindow = nil
modal = nil

-- Helpers
function clearHotkeys()
    for i = 1, #alphabet do
        hs.hotkey.deleteAll({}, alphabet[i])
    end
end

drillfork.setConfigurationFile = function(file)
    drillfork.config = require(file)(drillfork)

    for _, plugin in pairs(drillfork.config.plugins) do
        local id = string.gsub(plugin, 'drillfork/plugins/', '')
        drillfork.plugins[id] = require(plugin)
    end
end

drillfork.initialWindow = function()
    return initialWindow
end

drillfork.back = function()
    if initialWindow ~= nil then
        initialWindow:focus()
    end
end

drillfork.finished = function()
    clearHotkeys()
    modal:exit()
    drillfork.ui.hide()
end

drillfork.start = function()
    modal = hs.hotkey.modal.new(drillfork.config.leaderKeyModifiers, drillfork.config.leaderKey)

    function show(hotkey)
        drillfork.ui.clearLines()
        drillfork.ui.setBreadcrumb(hotkey["name"])

        clearHotkeys()

        local children = hotkey["children"]
        local status, result = pcall(children)

        if status then children = result end

        for i = 1, #children do
            local child = children[i]
            drillfork.ui.addLine("[" .. child["key"] .. "] → " .. child["name"])

            hs.hotkey.bind({}, child["key"], function()
                -- If the hotkey has children, we'll show them
                if child["children"] then return show(child) end

                -- If the hotkey has a runner, we run it
                local callback = function() initialWindow = nil end
                local status, result = pcall(child["run"], callback)
                if status then drillfork.finished() end
            end) 
        end

        drillfork.ui.render()
    end

    function modal:entered()
        initialWindow = hs.window.focusedWindow()
        show({ key = drillfork.config.leaderKey, name = "Home", children = drillfork.config.hotkeys() })
        drillfork.ui.show()
    end

    modal:bind({}, 'escape', function() drillfork.finished() end)
end

return drillfork