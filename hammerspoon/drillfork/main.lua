drillfork = {}
drillfork.config = {}
drillfork.plugins = {}
drillfork.ui = require('drillfork/ui')

-- Constants
alphabet = {"A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"}

-- Variables
hotkeys = {}

drillfork.setConfigurationFile = function(file)
    drillfork.config = require(file)(drillfork)

    for _, plugin in pairs(drillfork.config.plugins) do
        drillfork.plugins[plugin] = require('drillfork/plugins/' .. plugin)
    end
end

drillfork.start = function()
    k = hs.hotkey.modal.new(drillfork.config.leaderKeyModifiers, drillfork.config.leaderKey)

    function clear()
        for i = 1, #alphabet do
            hs.hotkey.deleteAll({}, alphabet[i])
        end
    end

    function show(hotkey)
        drillfork.ui.clearLines()
        drillfork.ui.addBreadcrumb(hotkey["name"])

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
                local status, result = pcall(child["run"], child)
                if status then return k:exit() end
            end) 
        end

        drillfork.ui.render()
    end

    function k:entered()
        show({ key = drillfork.config.leaderKey, name = "Home", children = drillfork.config.hotkeys() })
        drillfork.ui.show()
    end

    function k:exited()
        clear()
        drillfork.ui.hide()
    end

    k:bind({}, 'escape', function() k:exit() end)
end

return drillfork