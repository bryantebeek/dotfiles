local mainScreen = hs.screen.mainScreen()
local mainRes = mainScreen:fullFrame()
hkbgrect = hs.geometry.rect(mainRes.w / 2 - 150, mainRes.h - 500, 300, 500)
hotkeybg = hs.drawing.rectangle(hkbgrect)
hotkeybg:setFillColor({red=0.1,blue=0.1,green=0.1})
local hktextrect = hs.geometry.rect(hkbgrect.x + 10,hkbgrect.y + 38,hkbgrect.w - 20,hkbgrect.h - 20)
hotkeytext = hs.drawing.text(hktextrect, "")
hotkeytext:setTextStyle({font = {name = "Menlo", size = 14}})

local hktextrect2 = hs.geometry.rect(hkbgrect.x + 10,hkbgrect.y + 10,hkbgrect.w - 20,hkbgrect.h - 20)
breadcrumb = ""
breadcrumbs = hs.drawing.text(hktextrect2, breadcrumb)
breadcrumbs:setTextStyle({font = {name = "Menlo", size = 12}})

k = hs.hotkey.modal.new({}, '/')

alphabet = {"A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"}

function addBreadcrumb(name)
    breadcrumb = breadcrumb .. name .. " / "
    breadcrumbs:setText(breadcrumb)
end

function clear()
    for i = 1, #alphabet do
        hs.hotkey.deleteAll({}, alphabet[i])
    end
end

function disableKeys()
    for i = 1, #alphabet do
        hs.hotkey.bind({}, alphabet[i], function() end)
    end
end

function start(name) 
    return function() 
        hs.application.launchOrFocus(name) 
    end 
end

function desktop() 
    return function() 
        hs.window.desktop()
    end 
end

hotkey = {
    key = "/", name = "Home", children = {
        { key = "A", name = "Applications", children = {
            { key = "C", name = "Chrome", run = start("Google Chrome") },
            { key = "V", name = "Visual Studio Code", run = start("Visual Studio Code") },
            { key = "F", name = "Franz", run = start("Franz") },
            { key = "S", name = "Spotify", run = start("Spotify") },
            { key = "E", name = "Evernote", run = start("Evernote") },
            { key = "W", name = "Wunderlist", run = start("Wunderlist") },
            { key = "M", name = "Marxico", run = start("Default kidnkfckhbdkfgbicccmdggmpgogehop") },
        }},
        { key = "D", name = "Desktop", run = desktop() },
        { key = "S", name = "System", children = {
            { key = "S", name = "Screen", children = {
                { key = "S", name = "Saver", run = hs.caffeinate.startScreensaver }
            }}
        }},
        { key = "W", name = "Window", children = {
            { key = "Q", name = "Quit", run = function() hs.window.frontmostWindow():close() end}
        }}
    }
}

function k:entered()
    show(hotkey)
    hotkeybg:show()
    hotkeytext:show()
    breadcrumbs:show()
end

function k:exited() 
    hotkeybg:hide()
    hotkeytext:hide()
    breadcrumb = ""
    breadcrumbs:hide()
    clear()
end

function show(hotkey)
    local hkstr = "";

    addBreadcrumb(hotkey["name"])

    clear()
    disableKeys()

    for i = 1, #hotkey["children"] do
        local child = hotkey["children"][i]
        hkstr = hkstr .. child["key"] .. " → " .. child["name"] .. "\n"

        hs.hotkey.bind({}, child["key"], function()
            runner = child["run"]
            if runner ~= nil then
                k:exit()
                runner()
            else
                show(child) 
            end
        end) 
    end

    -- local hkstr_styled = hs.styledtext.new(hkstr, {font={name="Menlo",size=14}, paragraphStyle={lineSpacing=12.0}})
    hotkeytext:setText(hkstr)
end

k:bind({}, 'escape', function() k:exit() end)
