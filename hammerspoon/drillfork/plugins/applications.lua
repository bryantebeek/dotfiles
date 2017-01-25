applications = {}

applications.show = function(name)
    return function() 
        hs.application.launchOrFocus(name) 
    end 
end

applications.showAndKeyStroke = function(name, modifiers, key)
    return function()
        hs.application.launchOrFocus(name)
        hs.timer.doAfter(0.5, function() 
            hs.eventtap.keyStroke(modifiers, key) 
        end)
    end
end

return applications