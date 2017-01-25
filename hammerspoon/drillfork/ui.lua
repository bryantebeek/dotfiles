local ui = {}

local mainScreen = hs.screen.mainScreen()
local mainRes = mainScreen:fullFrame()

web = hs.webview.new(bgr):allowTextEntry(true)
web:bringToFront()

bgr = hs.geometry.rect(mainRes.w / 2 - 150, mainRes.h - 300, 300, 300)
bg = hs.drawing.rectangle(bgr)
bg:setFillColor({red=0.1,blue=0.1,green=0.1})

local bodyr = hs.geometry.rect(bgr.x + 10,bgr.y + 34,bgr.w - 20,bgr.h - 20)
bodyText = ""
body = hs.drawing.text(bodyr, bodyText)
body:setTextFont("Menlo")
body:setTextSize(14)

local breadcrumbr = hs.geometry.rect(bgr.x + 10,bgr.y + 10,bgr.w - 20,bgr.h - 20)
breadcrumbText = ""
breadcrumb = hs.drawing.text(breadcrumbr, breadcrumbText)
breadcrumb:setTextFont("Menlo")
breadcrumb:setTextSize(11)

lines = {}

ui.addBreadcrumb = function(name)
    breadcrumbText = breadcrumbText .. name .. " / "
    breadcrumb:setText(breadcrumbText)
end

ui.hide = function()
    web:hide()
    bg:hide()

    lines = {}
    bodyText = ""
    body:hide()

    breadcrumbText = ""
    breadcrumb:hide()
end

ui.show = function()
    ui.render()
    web:show()
    web:hswindow():focus()
    bg:show()
    body:show()
    breadcrumb:show()
end

ui.clearLines = function()
    lines = {}
end

ui.addLine = function(line)
    table.insert(lines, line)
end

ui.render = function()
    breadcrumb:setText(breadcrumbText)

    bodyText = ""

    for i = 1, #lines do
        bodyText = bodyText .. lines[i] .. "\n"
    end

    body:setText(bodyText)
end

return ui